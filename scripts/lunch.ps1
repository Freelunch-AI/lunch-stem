# DVC Download CLI Tool - PowerShell Version
# A PowerShell script to download DVC-tracked files from Google Drive storage

param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Arguments
)

# Configuration
$RCLONE_REMOTE = "gdrive:lunch-stem-dvc-data/files/md5"
$TEMP_FOLDER = "./temp_folder"
$VERBOSE = $false

# Error handling
$ErrorActionPreference = "Stop"

# Colors for output (using Write-Host colors)
function Write-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Blue
}

function Write-Success {
    param([string]$Message)
    Write-Host "[SUCCESS] $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

function Write-ErrorMsg {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

function Write-Verbose {
    param([string]$Message)
    if ($VERBOSE) {
        Write-Host "[VERBOSE] $Message" -ForegroundColor Magenta
    }
}

# Help function
function Show-Help {
    @"
DVC Download CLI Tool - PowerShell Version

USAGE:
    .\dvc-download.ps1 files <file1> [file2] [file3] ... [options]
    .\dvc-download.ps1 folder <directory_path> [options]

COMMANDS:
    files       Download specific DVC files
    folder      Download all DVC files from a directory

ARGUMENTS FOR 'files' COMMAND:
    <file1> [file2] ...         DVC file paths to download (required, space-separated)
                                Supports both absolute and relative paths

ARGUMENTS FOR 'folder' COMMAND:
    <directory_path>            Target directory containing DVC files (required)
                                Supports both absolute and relative paths

OPTIONS:
    --in-place                  Download files in the same directory as their .dvc files
    --recursive                 (folder command only) Download DVC files recursively from subdirectories
    --verbose                   Enable verbose mode for detailed debugging output (especially for rclone)
    --help                      Show this help message

EXAMPLES:
    # Download specific files to current directory (relative paths)
    .\lunch.ps1 files "docs/file1.pdf.dvc" "../other/file2.pdf.dvc"
    
    # Download specific files (absolute paths)
    .\lunch.ps1 files "C:\project\file1.pdf.dvc" "D:\tmp\file2.pdf.dvc"

    # Download specific files in-place
    .\lunch.ps1 files "docs/file1.pdf.dvc" --in-place

    # Download specific files with verbose output
    .\lunch.ps1 files "docs/file1.pdf.dvc" --verbose

    # Download all DVC files from directory (relative path)
    .\lunch.ps1 folder "docs/target_folder"

    # Download all DVC files from directory (absolute path)
    .\lunch.ps1 folder "C:\project\target_folder"

    # Download all DVC files recursively, preserve structure
    .\lunch.ps1 folder "docs/target_folder" --recursive

    # Download all DVC files in-place with verbose debugging
    .\lunch.ps1 folder "C:\project\target" --recursive --in-place --verbose

"@
}

# Function to extract MD5 hash from DVC file
function Get-MD5Hash {
    param([string]$DvcFile)
    
    Write-Verbose "Attempting to extract MD5 hash from DVC file: $DvcFile"
    
    if (-not (Test-Path $DvcFile)) {
        Write-ErrorMsg "DVC file not found: $DvcFile"
        return $null
    }
    
    Write-Verbose "DVC file exists, reading content..."
    
    try {
        $content = Get-Content $DvcFile -Raw
        if ($content -match 'md5:\s*([a-f0-9]+)') {
            $hash = $matches[1]
            Write-Verbose "Successfully extracted MD5 hash: $hash"
            return $hash
        } else {
            Write-ErrorMsg "Could not find MD5 hash in $DvcFile"
            if ($VERBOSE) {
                Write-Verbose "DVC file content:"
                Get-Content $DvcFile | Select-Object -First 20 | ForEach-Object { Write-Verbose "  $_" }
            }
            return $null
        }
    } catch {
        Write-ErrorMsg "Error reading DVC file: $DvcFile - $($_.Exception.Message)"
        return $null
    }
}

# Function to download a single DVC file
function Download-DvcFile {
    param(
        [string]$DvcFile,
        [string]$InPlace,
        [string]$BaseOutputDir = "",
        [string]$TargetDir = ""
    )
    
    # Convert to absolute path for consistent handling
    try {
        $DvcFile = (Resolve-Path $DvcFile).Path
    } catch {
        Write-ErrorMsg "DVC file not found: $DvcFile"
        return $false
    }
    
    Write-Info "Processing: $(Split-Path $DvcFile -Leaf)"
    Write-Verbose "Absolute path: $DvcFile"
    Write-Verbose "In-place mode: $InPlace"
    Write-Verbose "Base output dir: $BaseOutputDir"
    
    # Get MD5 hash
    $md5Hash = Get-MD5Hash $DvcFile
    if (-not $md5Hash) {
        return $false
    }
    
    # Calculate output file path
    $baseFilename = [System.IO.Path]::GetFileNameWithoutExtension((Split-Path $DvcFile -Leaf))
    
    Write-Verbose "Base filename (without .dvc extension): $baseFilename"
    
    if ($InPlace -eq "true") {
        # Download in the same directory as the .dvc file
        $outputFile = Join-Path (Split-Path $DvcFile -Parent) $baseFilename
        Write-Verbose "In-place mode: output file will be $outputFile"
    } elseif ($BaseOutputDir) {
        # For directory downloads with structure preservation
        $dvcDir = Split-Path $DvcFile -Parent
        
        Write-Verbose "Directory mode: dvcDir=$dvcDir, targetDir=$TargetDir"
        
        if ($TargetDir) {
            try {
                $TargetDir = (Resolve-Path $TargetDir).Path
            } catch {
                Write-ErrorMsg "Cannot resolve target directory: $TargetDir"
                return $false
            }
        }
        
        if ($dvcDir -eq $TargetDir) {
            # File is in root target directory
            $outputFile = Join-Path $BaseOutputDir $baseFilename
            if (-not (Test-Path $BaseOutputDir)) {
                New-Item -ItemType Directory -Path $BaseOutputDir -Force | Out-Null
            }
            Write-Verbose "Root directory mode: creating $BaseOutputDir"
        } else {
            # File is in subdirectory, preserve structure
            # PowerShell-compatible way to get relative path
            $relativePath = $dvcDir.Substring($TargetDir.Length).TrimStart('\', '/')
            $targetSubDir = Join-Path $BaseOutputDir $relativePath
            $outputFile = Join-Path $targetSubDir $baseFilename
            if (-not (Test-Path $targetSubDir)) {
                New-Item -ItemType Directory -Path $targetSubDir -Force | Out-Null
            }
            Write-Verbose "Subdirectory mode: relativePath=$relativePath, creating $targetSubDir"
        }
    } else {
        # Simple download to current directory
        $outputFile = $baseFilename
        Write-Verbose "Simple mode: downloading to current directory"
    }
    
    Write-Info "  MD5: $md5Hash"
    Write-Info "  Output: $outputFile"
    
    # Check if file already exists
    if (Test-Path $outputFile) {
        Write-Warning "  Skipping: $outputFile already exists"
        Write-Verbose "  File already exists at: $(Resolve-Path $outputFile -ErrorAction SilentlyContinue)"
        return $true
    }
    
    # Create temp directory
    if (-not (Test-Path $TEMP_FOLDER)) {
        New-Item -ItemType Directory -Path $TEMP_FOLDER -Force | Out-Null
    }
    Write-Verbose "Created temp directory: $(Resolve-Path $TEMP_FOLDER)"
    
    # Calculate rclone path
    $hashPrefix = $md5Hash.Substring(0, 2)
    $hashSuffix = $md5Hash.Substring(2)
    $rclonePath = "$RCLONE_REMOTE/$hashPrefix/$hashSuffix"
    
    Write-Info "  Downloading from: $rclonePath"
    Write-Verbose "  Hash prefix: $hashPrefix"
    Write-Verbose "  Hash suffix: $hashSuffix"
    Write-Verbose "  Full rclone path: $rclonePath"
    Write-Verbose "  Temp folder: $TEMP_FOLDER"
    
    try {
        # Download file using rclone
        if ($VERBOSE) {
            Write-Verbose "Running rclone command with verbose output:"
            Write-Verbose "rclone copy `"$rclonePath`" `"$TEMP_FOLDER`" --progress --verbose"
            $rcloneOutput = & rclone copy $rclonePath $TEMP_FOLDER --progress --verbose 2>&1
            $rcloneExitCode = $LASTEXITCODE
            if ($VERBOSE) {
                Write-Verbose "rclone output:"
                $rcloneOutput | ForEach-Object { Write-Verbose "  $_" }
            }
        } else {
            $null = & rclone copy $rclonePath $TEMP_FOLDER 2>&1
            $rcloneExitCode = $LASTEXITCODE
        }
        
        if ($rcloneExitCode -eq 0) {
            # Find downloaded file
            $downloadedFile = Join-Path $TEMP_FOLDER $hashSuffix
            Write-Verbose "  Looking for downloaded file: $downloadedFile"
            
            if (Test-Path $downloadedFile) {
                Write-Verbose "  Downloaded file found, moving to final location"
                # Move to final location
                Move-Item $downloadedFile $outputFile
                Write-Success "  Downloaded: $outputFile"
                Write-Verbose "  Final file location: $(Resolve-Path $outputFile)"
                $success = $true
            } else {
                Write-ErrorMsg "  Error: No file downloaded"
                Write-Verbose "  Expected file not found: $downloadedFile"
                if ($VERBOSE) {
                    Write-Verbose "  Contents of temp folder:"
                    try {
                        Get-ChildItem $TEMP_FOLDER | ForEach-Object { Write-Verbose "    $($_.Name)" }
                    } catch {
                        Write-Verbose "  Temp folder is empty or doesn't exist"
                    }
                }
                $success = $false
            }
        } else {
            Write-ErrorMsg "  Error: Failed to download from rclone"
            Write-Verbose "  rclone command failed with exit code: $rcloneExitCode"
            $success = $false
        }
    } catch {
        Write-ErrorMsg "  Error: Exception during download - $($_.Exception.Message)"
        $success = $false
    }
    
    # Clean up temp folder
    if (Test-Path $TEMP_FOLDER) {
        Remove-Item $TEMP_FOLDER -Recurse -Force
    }
    Write-Verbose "  Cleaned up temp folder"
    
    return $success
}

# Command: Download specific files
function Invoke-FilesCommand {
    $dvcFiles = @()
    $inPlace = "false"
    
    # Parse positional arguments (files) and optional flags
    $i = 0
    while ($i -lt $args.Count) {
        $arg = $args[$i]
        switch ($arg) {
            "--in-place" {
                $inPlace = "true"
                $i++
            }
            "--verbose" {
                $script:VERBOSE = $true
                Write-Verbose "Verbose mode enabled"
                $i++
            }
            "--help" {
                Show-Help
                exit 0
            }
            default {
                if ($arg.StartsWith("--")) {
                    Write-ErrorMsg "Unknown option: $arg"
                    Show-Help
                    exit 1
                } else {
                    # Positional argument (DVC file path)
                    $dvcFiles += $arg
                    $i++
                }
            }
        }
    }
    
    # Validate required arguments
    if ($dvcFiles.Count -eq 0) {
        Write-ErrorMsg "Missing required arguments: DVC file paths"
        Show-Help
        exit 1
    }
    
    Write-Info "Processing $($dvcFiles.Count) DVC file(s)"
    if ($inPlace -eq "true") {
        Write-Info "Mode: In-place download"
    } else {
        Write-Info "Mode: Download to current directory"
    }
    
    if ($VERBOSE) {
        Write-Verbose "Files to process:"
        $dvcFiles | ForEach-Object { Write-Verbose "  - $_" }
    }
    
    $successCount = 0
    $totalCount = $dvcFiles.Count
    
    # Process each file
    foreach ($dvcFile in $dvcFiles) {
        if (Download-DvcFile $dvcFile $inPlace) {
            $successCount++
        }
        Write-Host ""
    }
    
    Write-Success "Download complete! Successfully downloaded $successCount/$totalCount files"
}

# Command: Download directory
function Invoke-DirectoryCommand {
    $targetDirectory = ""
    $recursive = "false"
    $inPlace = "false"
    
    # Collect all non-flag arguments that could be part of the path
    $pathParts = @()
    $i = 0
    
    # Collect all non-flag arguments that could be part of the path
    while ($i -lt $args.Count -and -not $args[$i].StartsWith("--")) {
        $pathParts += $args[$i]
        $i++
    }
    
    if ($pathParts.Count -gt 0) {
        $targetDirectory = $pathParts -join " "
        $startIndex = $pathParts.Count
    } else {
        $startIndex = 0
    }
    
    # Parse optional flags
    while ($i -lt $args.Count) {
        $arg = $args[$i]
        switch ($arg) {
            "--recursive" {
                $recursive = "true"
                $i++
            }
            "--in-place" {
                $inPlace = "true"
                $i++
            }
            "--verbose" {
                $script:VERBOSE = $true
                Write-Verbose "Verbose mode enabled"
                $i++
            }
            "--help" {
                Show-Help
                exit 0
            }
            default {
                if ($arg.StartsWith("--")) {
                    Write-ErrorMsg "Unknown option: $arg"
                    Show-Help
                    exit 1
                } else {
                    Write-ErrorMsg "Unexpected positional argument: $arg"
                    Write-ErrorMsg "Directory path should be the first argument"
                    Show-Help
                    exit 1
                }
            }
        }
    }
    
    # Validate required arguments
    if (-not $targetDirectory) {
        Write-ErrorMsg "Missing required argument: directory path"
        Show-Help
        exit 1
    }
    
    # Check if directory exists
    if (-not (Test-Path $targetDirectory -PathType Container)) {
        Write-ErrorMsg "Directory not found: $targetDirectory"
        exit 1
    }
    
    # Convert to absolute path for consistent handling
    try {
        $targetDirectory = (Resolve-Path $targetDirectory).Path
    } catch {
        Write-ErrorMsg "Cannot resolve directory path: $targetDirectory"
        exit 1
    }
    
    Write-Verbose "Resolved target directory: $targetDirectory"
    
    # Find DVC files
    $dvcFiles = @()
    if ($recursive -eq "true") {
        Write-Verbose "Searching recursively for DVC files..."
        $dvcFiles = Get-ChildItem -Path $targetDirectory -Filter "*.dvc" -Recurse -File
        if ($VERBOSE) {
            $dvcFiles | ForEach-Object { Write-Verbose "Found DVC file: $($_.FullName)" }
        }
        Write-Info "Found $($dvcFiles.Count) DVC files in directory (recursive)"
    } else {
        Write-Verbose "Searching for DVC files in current level only..."
        $dvcFiles = Get-ChildItem -Path $targetDirectory -Filter "*.dvc" -File
        if ($VERBOSE) {
            $dvcFiles | ForEach-Object { Write-Verbose "Found DVC file: $($_.FullName)" }
        }
        Write-Info "Found $($dvcFiles.Count) DVC files in directory (current level only)"
    }
    
    if ($dvcFiles.Count -eq 0) {
        Write-Warning "No DVC files found in $targetDirectory"
        exit 0
    }
    
    # Determine output structure
    $baseOutputDir = ""
    if ($inPlace -eq "true") {
        Write-Info "Mode: In-place download"
    } else {
        $baseOutputDir = Split-Path $targetDirectory -Leaf
        Write-Info "Mode: Download to ./$baseOutputDir/"
        Write-Verbose "Base output directory: $baseOutputDir"
    }
    
    $successCount = 0
    $totalCount = $dvcFiles.Count
    
    # Process each file
    foreach ($dvcFile in $dvcFiles) {
        if (Download-DvcFile $dvcFile.FullName $inPlace $baseOutputDir $targetDirectory) {
            $successCount++
        }
        Write-Host ""
    }
    
    Write-Success "Batch download complete! Successfully downloaded $successCount/$totalCount files"
}

# Main function
function Main {
    # Check if rclone is available
    try {
        $rcloneInfo = Get-Command rclone -ErrorAction Stop
        Write-Verbose "rclone found: $($rcloneInfo.Source)"
        if ($VERBOSE) {
            Write-Verbose "rclone version:"
            try {
                $rcloneVersion = & rclone version 2>&1 | Select-Object -First 3
                $rcloneVersion | ForEach-Object { Write-Verbose "  $_" }
            } catch {
                Write-Verbose "Could not get rclone version"
            }
        }
    } catch {
        Write-ErrorMsg "rclone is not installed or not in PATH"
        exit 1
    }
    
    # Check for help or no arguments
    if ($Arguments.Count -eq 0 -or $Arguments[0] -eq "--help" -or $Arguments[0] -eq "-h") {
        Show-Help
        exit 0
    }
    
    # Parse command
    $command = $Arguments[0]
    if ($Arguments.Count -gt 1) {
        $remainingArgs = $Arguments[1..($Arguments.Count-1)]
        # Ensure it's always an array, even with single element
        if ($remainingArgs -isnot [array]) {
            $remainingArgs = @($remainingArgs)
        }
    } else {
        $remainingArgs = @()
    }
    
    switch ($command.ToLower()) {
        "files" {
            Invoke-FilesCommand @remainingArgs
        }
        "folder" {
            Invoke-DirectoryCommand @remainingArgs
        }
        default {
            Write-ErrorMsg "Unknown command: $command"
            Show-Help
            exit 1
        }
    }
}

# Run main function
Main
