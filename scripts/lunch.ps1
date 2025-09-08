# DVC Download CLI Tool - PowerShell Version
# A PowerShell script to download DVC-tracked files from Google Drive storage

param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Arguments
)

# Configuration
$RCLONE_REMOTE = "gdrive-lunch-stem:lunch-stem-dvc-data/files/md5"
$TEMP_FOLDER = "./temp_folder"
$VERBOSE = $false

# Error handling
$ErrorActionPreference = "Stop"

# Colors for output (redirected to stderr)
function Write-Info {
    param([string]$Message)
    [Console]::Error.WriteLine("[INFO] $Message")
}

function Write-Success {
    param([string]$Message)
    [Console]::Error.WriteLine("[SUCCESS] $Message")
}

function Write-Warning {
    param([string]$Message)
    [Console]::Error.WriteLine("[WARNING] $Message")
}

function Write-ErrorMsg {
    param([string]$Message)
    [Console]::Error.WriteLine("[ERROR] $Message")
}

function Write-Verbose {
    param([string]$Message)
    if ($VERBOSE) {
        [Console]::Error.WriteLine("[VERBOSE] $Message")
    }
}

# Help function
function Show-Help {
    @"
LunchSTEM CLI - PowerShell Version

USAGE:
    lunch files <file1> [file2] [file3] ... [options]
    lunch folder <directory_path> [options]

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
    
    if (Test-Path $DvcFile) {
        $fileInfo = Get-Item $DvcFile
        Write-Verbose "DVC file size: $($fileInfo.Length) bytes"
        Write-Verbose "File permissions: $($fileInfo.Mode)"
    } else {
        Write-ErrorMsg "DVC file not found: $DvcFile"
        $resolvedPath = try { Resolve-Path $DvcFile -ErrorAction Stop } catch { "invalid path" }
        Write-Verbose "Attempted file path: $resolvedPath"
        return $null
    }
    
    Write-Verbose "DVC file exists, reading content..."
    
    try {
        $content = Get-Content $DvcFile -Raw -ErrorAction Stop
        
        if ($VERBOSE) {
            Write-Verbose "DVC file first 10 lines:"
            (Get-Content $DvcFile -ErrorAction Stop) | Select-Object -First 10 | ForEach-Object { 
                Write-Verbose "  $_" 
            }
        }
        
        # Extract MD5 hash with detailed debugging
        Write-Verbose "Searching for MD5 pattern in DVC file content..."
        Write-Verbose "Content length: $($content.Length) characters"
        
        if ($content -match 'md5:\s*([a-f0-9]+)') {
            $hash = $matches[1]
            Write-Verbose "Successfully extracted MD5 hash: $hash"
            Write-Verbose "MD5 hash length: $($hash.Length) characters"
            
            # Validate MD5 format
            if ($hash -match '^[a-f0-9]{32}$') {
                Write-Verbose "MD5 hash format validation: PASSED"
            } else {
                Write-Warning "MD5 hash format validation: FAILED (expected 32 hex characters)"
            }
            
            return $hash
        } else {
            Write-ErrorMsg "Could not find MD5 hash in $DvcFile"
            Write-Verbose "MD5 pattern match failed"
            
            if ($VERBOSE) {
                Write-Verbose "Full DVC file content for debugging:"
                $content -split "`n" | ForEach-Object { Write-Verbose "  $_" }
                
                Write-Verbose "Searching for any 'md5' occurrences:"
                $md5Lines = Get-Content $DvcFile | Select-String -Pattern "md5" -AllMatches
                if ($md5Lines) {
                    $md5Lines | ForEach-Object { Write-Verbose "  Line $($_.LineNumber): $($_.Line)" }
                } else {
                    Write-Verbose "No 'md5' found in file"
                }
            }
            return $null
        }
    } catch {
        Write-ErrorMsg "Error reading DVC file: $DvcFile - $($_.Exception.Message)"
        Write-Verbose "Exception details: $($_.Exception.GetType().Name)"
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
    
    Write-Verbose "=== Starting Download-DvcFile function ==="
    Write-Verbose "Input parameters:"
    Write-Verbose "  DvcFile: '$DvcFile'"
    Write-Verbose "  InPlace: '$InPlace'"
    Write-Verbose "  BaseOutputDir: '$BaseOutputDir'"
    Write-Verbose "  TargetDir: '$TargetDir'"
    
    # Convert to absolute path for consistent handling
    $originalDvcFile = $DvcFile
    try {
        $DvcFile = (Resolve-Path $DvcFile -ErrorAction Stop).Path
        Write-Verbose "Path resolution:"
        Write-Verbose "  Original path: '$originalDvcFile'"
        Write-Verbose "  Resolved path: '$DvcFile'"
    } catch {
        Write-ErrorMsg "DVC file not found: $originalDvcFile"
        Write-Verbose "  Path resolution failed: $($_.Exception.Message)"
        return $false
    }
    
    Write-Info "Processing: $(Split-Path $DvcFile -Leaf)"
    Write-Verbose "Absolute path: $DvcFile"
    Write-Verbose "In-place mode: $InPlace"
    Write-Verbose "Base output dir: $BaseOutputDir"
    
    # Get MD5 hash
    Write-Verbose "Calling Get-MD5Hash function..."
    $md5Hash = Get-MD5Hash $DvcFile
    Write-Verbose "Get-MD5Hash result:"
    Write-Verbose "  MD5 hash: '$md5Hash'"
    
    if (-not $md5Hash) {
        Write-ErrorMsg "Failed to extract MD5 hash from DVC file"
        return $false
    }
    
    # Calculate output file path
    $baseFilename = [System.IO.Path]::GetFileNameWithoutExtension((Split-Path $DvcFile -Leaf))
    
    Write-Verbose "Filename processing:"
    Write-Verbose "  DVC file basename: '$(Split-Path $DvcFile -Leaf)'"
    Write-Verbose "  Base filename (without .dvc): '$baseFilename'"
    
    Write-Verbose "Determining output file path..."
    
    if ($InPlace -eq "true") {
        # Download in the same directory as the .dvc file
        $dvcDir = Split-Path $DvcFile -Parent
        $outputFile = Join-Path $dvcDir $baseFilename
        
        Write-Verbose "In-place mode selected:"
        Write-Verbose "  DVC directory: '$dvcDir'"
        Write-Verbose "  Output file: '$outputFile'"
        
    } elseif ($BaseOutputDir) {
        # For directory downloads with structure preservation
        $dvcDir = Split-Path $DvcFile -Parent
        
        Write-Verbose "Directory mode selected:"
        Write-Verbose "  DVC directory: '$dvcDir'"
        Write-Verbose "  Target directory (original): '$TargetDir'"
        
        if ($TargetDir) {
            $originalTargetDir = $TargetDir
            try {
                $TargetDir = (Resolve-Path $TargetDir -ErrorAction Stop).Path
                Write-Verbose "  Target directory resolution:"
                Write-Verbose "    Original: '$originalTargetDir'"
                Write-Verbose "    Resolved: '$TargetDir'"
            } catch {
                Write-ErrorMsg "Cannot resolve target directory: $originalTargetDir"
                Write-Verbose "  Target directory resolution failed: $($_.Exception.Message)"
                return $false
            }
        }
        
        if ($dvcDir -eq $TargetDir) {
            # File is in root target directory
            $outputFile = Join-Path $BaseOutputDir $baseFilename
            Write-Verbose "  Root directory mode detected"
            Write-Verbose "  Creating directory: '$BaseOutputDir'"
            
            if (-not (Test-Path $BaseOutputDir)) {
                try {
                    New-Item -ItemType Directory -Path $BaseOutputDir -Force -ErrorAction Stop | Out-Null
                    Write-Verbose "  Directory created successfully"
                } catch {
                    Write-ErrorMsg "Failed to create output directory: $BaseOutputDir"
                    Write-Verbose "  Directory creation failed: $($_.Exception.Message)"
                    return $false
                }
            }
        } else {
            # File is in subdirectory, preserve structure
            Write-Verbose "  Subdirectory mode detected"
            
            # PowerShell-compatible way to get relative path
            $relativePath = $dvcDir.Substring($TargetDir.Length).TrimStart('\', '/')
            Write-Verbose "  Relative path calculation:"
            Write-Verbose "    DVC dir: '$dvcDir'"
            Write-Verbose "    Target dir: '$TargetDir'"
            Write-Verbose "    Relative path: '$relativePath'"
            
            $targetSubDir = Join-Path $BaseOutputDir $relativePath
            $outputFile = Join-Path $targetSubDir $baseFilename
            
            Write-Verbose "  Creating subdirectory: '$targetSubDir'"
            if (-not (Test-Path $targetSubDir)) {
                try {
                    New-Item -ItemType Directory -Path $targetSubDir -Force -ErrorAction Stop | Out-Null
                    Write-Verbose "  Subdirectory created successfully"
                } catch {
                    Write-ErrorMsg "Failed to create output subdirectory: $targetSubDir"
                    Write-Verbose "  Subdirectory creation failed: $($_.Exception.Message)"
                    return $false
                }
            }
        }
    } else {
        # Simple download to current directory
        $outputFile = $baseFilename
        
        # Handle filename collisions by adding a unique suffix
        $counter = 1
        while ((Test-Path $outputFile) -and ($outputFile -ne $baseFilename -or $counter -eq 1)) {
            if ($counter -eq 1) {
                # First collision detected, check if existing file is from a different DVC file
                $existingMightBeDifferent = $true
            }
            
            # Create unique filename
            $fileExtension = [System.IO.Path]::GetExtension($baseFilename)
            $fileNameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($baseFilename)
            
            if ($fileExtension) {
                $outputFile = "${fileNameWithoutExt}_${counter}${fileExtension}"
            } else {
                $outputFile = "${baseFilename}_${counter}"
            }
            $counter++
            
            if ($counter -gt 100) {
                Write-ErrorMsg "Too many filename conflicts for $baseFilename"
                return $false
            }
        }
        
        if ($outputFile -ne $baseFilename) {
            Write-Info "  Filename collision resolved: $baseFilename -> $outputFile"
        }
        
        Write-Verbose "Simple mode selected:"
        Write-Verbose "  Downloading to current directory"
        Write-Verbose "  Current working directory: '$(Get-Location)'"
    }
    
    Write-Verbose "Final output file path: '$outputFile'"
    
    Write-Info "  MD5: $md5Hash"
    Write-Info "  Output: $outputFile"
    
    # Check if file already exists (this should be rare now due to collision handling above)
    Write-Verbose "Checking if output file already exists..."
    if (Test-Path $outputFile) {
        $existingFile = Get-Item $outputFile
        if ($outputFile -eq $baseFilename) {
            # Original filename exists - this is a true skip case
            Write-Warning "  Skipping: $outputFile already exists"
        } else {
            # This shouldn't happen due to our collision handling above, but just in case
            Write-Warning "  Skipping: $outputFile already exists (unexpected)"
        }
        Write-Verbose "  Existing file details:"
        Write-Verbose "    Path: $($existingFile.FullName)"
        Write-Verbose "    Size: $($existingFile.Length) bytes"
        Write-Verbose "    Modified: $($existingFile.LastWriteTime)"
        return $true
    }
    
    # Create temp directory
    Write-Verbose "Setting up temporary directory..."
    Write-Verbose "  Temp folder path: '$TEMP_FOLDER'"
    Write-Verbose "  Creating temp directory..."
    
    if (-not (Test-Path $TEMP_FOLDER)) {
        try {
            New-Item -ItemType Directory -Path $TEMP_FOLDER -Force -ErrorAction Stop | Out-Null
            Write-Verbose "  Temp directory created successfully"
        } catch {
            Write-ErrorMsg "Failed to create temporary directory: $TEMP_FOLDER"
            Write-Verbose "  Temp directory creation failed: $($_.Exception.Message)"
            return $false
        }
    }
    
    $tempRealPath = try { (Resolve-Path $TEMP_FOLDER).Path } catch { $TEMP_FOLDER }
    Write-Verbose "  Temp directory exists: '$tempRealPath'"
    if (Test-Path $TEMP_FOLDER) {
        $tempDir = Get-Item $TEMP_FOLDER
        Write-Verbose "  Temp directory permissions: $($tempDir.Mode)"
    }
    
    # Calculate rclone path
    Write-Verbose "Calculating rclone path from MD5 hash..."
    $hashPrefix = $md5Hash.Substring(0, 2)
    $hashSuffix = $md5Hash.Substring(2)
    $rclonePath = "$RCLONE_REMOTE/$hashPrefix/$hashSuffix"
    
    Write-Verbose "  MD5 hash breakdown:"
    Write-Verbose "    Full MD5: '$md5Hash'"
    Write-Verbose "    Hash prefix (first 2 chars): '$hashPrefix'"
    Write-Verbose "    Hash suffix (remaining chars): '$hashSuffix'"
    Write-Verbose "    Hash suffix length: $($hashSuffix.Length) characters"
    
    Write-Info "  Downloading from: $rclonePath"
    Write-Verbose "  Full rclone details:"
    Write-Verbose "    Remote: '$RCLONE_REMOTE'"
    Write-Verbose "    Full path: '$rclonePath'"
    Write-Verbose "    Destination: '$TEMP_FOLDER'"
    
    # Pre-flight checks
    Write-Verbose "Pre-flight checks:"
    try {
        $rcloneCmd = Get-Command rclone -ErrorAction Stop
        Write-Verbose "  rclone executable: $($rcloneCmd.Source)"
    } catch {
        Write-Verbose "  rclone executable: not found"
    }
    
    Write-Verbose "  rclone config check:"
    if ($VERBOSE) {
        try {
            $configOutput = & rclone config show 2>&1 | Select-Object -First 5
            if ($configOutput) {
                $configOutput | ForEach-Object { Write-Verbose "    $_" }
            } else {
                Write-Verbose "    No config output"
            }
        } catch {
            Write-Verbose "    Could not show rclone config: $($_.Exception.Message)"
        }
    }
    
    try {
        # Download file using rclone with enhanced debugging
        Write-Verbose "Starting rclone download..."
        $rcloneStartTime = Get-Date
        Write-Verbose "  Download start time: $rcloneStartTime"
        
        $rcloneSuccess = $false
        
        if ($VERBOSE) {
            Write-Verbose "Running rclone with verbose output:"
            Write-Verbose "Command: rclone copy `"$rclonePath`" `"$TEMP_FOLDER`" --progress --verbose"
            
            # Capture both stdout and stderr for detailed analysis
            $rcloneOutput = & rclone copy $rclonePath $TEMP_FOLDER --progress --verbose 2>&1
            $rcloneExitCode = $LASTEXITCODE
            
            Write-Verbose "rclone exit code: $rcloneExitCode"
            Write-Verbose "rclone output length: $($rcloneOutput.Count) lines"
            
            if ($rcloneOutput) {
                Write-Verbose "rclone full output:"
                $rcloneOutput | ForEach-Object { Write-Verbose "  $_" }
            } else {
                Write-Verbose "rclone produced no output"
            }
            
            if ($rcloneExitCode -eq 0) {
                $rcloneSuccess = $true
                Write-Verbose "rclone command completed successfully"
            } else {
                $rcloneSuccess = $false
                Write-Verbose "rclone command failed with exit code: $rcloneExitCode"
            }
        } else {
            Write-Verbose "Running rclone in quiet mode:"
            Write-Verbose "Command: rclone copy `"$rclonePath`" `"$TEMP_FOLDER`""
            
            $null = & rclone copy $rclonePath $TEMP_FOLDER 2>&1
            $rcloneExitCode = $LASTEXITCODE
            
            Write-Verbose "rclone exit code: $rcloneExitCode"
            
            if ($rcloneExitCode -eq 0) {
                $rcloneSuccess = $true
            } else {
                $rcloneSuccess = $false
            }
        }
        
        $rcloneEndTime = Get-Date
        $rcloneDuration = ($rcloneEndTime - $rcloneStartTime).TotalSeconds
        Write-Verbose "  Download end time: $rcloneEndTime"
        Write-Verbose "  Download duration: $([math]::Round($rcloneDuration, 2)) seconds"
        
        # Post-download file handling
        Write-Verbose "Post-download analysis..."
        Write-Verbose "  rclone_success: '$rcloneSuccess'"
        
        if ($rcloneSuccess) {
            # Analyze temp directory contents
            Write-Verbose "Analyzing temporary directory contents..."
            Write-Verbose "  Temp directory: '$TEMP_FOLDER'"
            
            if (Test-Path $TEMP_FOLDER) {
                try {
                    $tempContents = Get-ChildItem $TEMP_FOLDER -ErrorAction Stop
                    Write-Verbose "  Temp directory listing:"
                    $tempContents | ForEach-Object { 
                        Write-Verbose "    $($_.Mode) $($_.Length) $($_.LastWriteTime) $($_.Name)" 
                    }
                    
                    $fileCount = ($tempContents | Where-Object { -not $_.PSIsContainer }).Count
                    Write-Verbose "  Files in temp directory: $fileCount"
                } catch {
                    Write-Verbose "  Could not list temp directory contents: $($_.Exception.Message)"
                }
            } else {
                Write-Verbose "  Temp directory does not exist after rclone command"
            }
            
            # Look for the expected downloaded file
            $downloadedFile = Join-Path $TEMP_FOLDER $hashSuffix
            Write-Verbose "  Looking for downloaded file: '$downloadedFile'"
            Write-Verbose "  Expected filename: '$hashSuffix'"
            
            if (Test-Path $downloadedFile) {
                Write-Verbose "  Downloaded file found!"
                
                # Analyze the downloaded file
                $downloadedFileInfo = Get-Item $downloadedFile
                Write-Verbose "  Downloaded file details:"
                Write-Verbose "    Path: '$($downloadedFileInfo.FullName)'"
                Write-Verbose "    Size: $($downloadedFileInfo.Length) bytes"
                Write-Verbose "    Permissions: $($downloadedFileInfo.Mode)"
                Write-Verbose "    Modified: $($downloadedFileInfo.LastWriteTime)"
                
                # Prepare for file move
                Write-Verbose "  Moving file to final location..."
                Write-Verbose "    Source: '$downloadedFile'"
                Write-Verbose "    Destination: '$outputFile'"
                
                # Check if destination directory exists
                $outputDir = Split-Path $outputFile -Parent
                Write-Verbose "    Destination directory: '$outputDir'"
                
                if ($outputDir -and (-not (Test-Path $outputDir))) {
                    Write-Verbose "    Destination directory does not exist, creating..."
                    try {
                        New-Item -ItemType Directory -Path $outputDir -Force -ErrorAction Stop | Out-Null
                        Write-Verbose "    Destination directory created successfully"
                    } catch {
                        Write-ErrorMsg "  Failed to create destination directory: $outputDir"
                        Write-Verbose "    Directory creation failed: $($_.Exception.Message)"
                        return $false
                    }
                }
                
                # Perform the move
                try {
                    Move-Item $downloadedFile $outputFile -ErrorAction Stop
                    Write-Verbose "    File moved successfully"
                    
                    Write-Success "  Downloaded: $outputFile"
                    
                    # Verify final file
                    if (Test-Path $outputFile) {
                        $finalFile = Get-Item $outputFile
                        Write-Verbose "  Final file verification:"
                        Write-Verbose "    Path: $($finalFile.FullName)"
                        Write-Verbose "    Size: $($finalFile.Length) bytes"
                        Write-Verbose "    Size match: $(if ($downloadedFileInfo.Length -eq $finalFile.Length) { 'YES' } else { 'NO' })"
                    } else {
                        Write-ErrorMsg "  Final file verification failed - file not found at destination"
                        return $false
                    }
                    
                    $success = $true
                } catch {
                    Write-ErrorMsg "  Failed to move file to final location: $($_.Exception.Message)"
                    Write-Verbose "    Move operation failed: $($_.Exception.GetType().Name)"
                    return $false
                }
            } else {
                Write-ErrorMsg "  Error: No file downloaded"
                Write-Verbose "  Expected file not found: '$downloadedFile'"
                
                # Enhanced debugging for missing file
                Write-Verbose "  Debugging missing download:"
                
                # Check if any files were downloaded
                try {
                    $downloadedFiles = Get-ChildItem $TEMP_FOLDER -File -ErrorAction Stop
                    if ($downloadedFiles) {
                        Write-Verbose "  Found other files in temp directory:"
                        $downloadedFiles | ForEach-Object {
                            Write-Verbose "    $($_.Name) ($($_.Length) bytes)"
                        }
                    } else {
                        Write-Verbose "  No files found in temp directory"
                    }
                } catch {
                    Write-Verbose "  Could not list temp directory files: $($_.Exception.Message)"
                }
                
                # Check if the expected hash_suffix exists with different pattern
                Write-Verbose "  Searching for files matching hash_suffix pattern..."
                try {
                    $matchingFiles = Get-ChildItem $TEMP_FOLDER -File | Where-Object { $_.Name -like "*$hashSuffix*" }
                    if ($matchingFiles) {
                        Write-Verbose "  Found files matching hash pattern:"
                        $matchingFiles | ForEach-Object { Write-Verbose "    $($_.Name)" }
                    } else {
                        Write-Verbose "  No files matching hash pattern found"
                    }
                } catch {
                    Write-Verbose "  Could not search for matching files: $($_.Exception.Message)"
                }
                
                $success = $false
            }
        } else {
            Write-ErrorMsg "  Error: Failed to download from rclone"
            Write-Verbose "  rclone command failed"
            
            # Additional debugging for rclone failure
            Write-Verbose "  Debugging rclone failure:"
            Write-Verbose "    Command attempted: rclone copy `"$rclonePath`" `"$TEMP_FOLDER`""
            Write-Verbose "    Remote path: $rclonePath"
            Write-Verbose "    Destination: $TEMP_FOLDER"
            
            # Test rclone connectivity
            if ($VERBOSE) {
                Write-Verbose "  Testing rclone connectivity..."
                try {
                    $rcloneLsOutput = & rclone ls $RCLONE_REMOTE --max-depth 1 2>&1 | Select-Object -First 5
                    if ($LASTEXITCODE -eq 0 -and $rcloneLsOutput) {
                        Write-Verbose "  rclone remote is accessible"
                        Write-Verbose "  Sample remote contents:"
                        $rcloneLsOutput | ForEach-Object { Write-Verbose "    $_" }
                    } else {
                        Write-Verbose "  rclone remote is not accessible or has issues"
                        if ($rcloneLsOutput) {
                            Write-Verbose "  rclone ls error output:"
                            $rcloneLsOutput | ForEach-Object { Write-Verbose "    $_" }
                        }
                    }
                } catch {
                    Write-Verbose "  rclone connectivity test failed: $($_.Exception.Message)"
                }
            }
            
            $success = $false
        }
    } catch {
        Write-ErrorMsg "  Error: Exception during download - $($_.Exception.Message)"
        Write-Verbose "  Exception type: $($_.Exception.GetType().Name)"
        Write-Verbose "  Exception details: $($_.Exception.ToString())"
        $success = $false
    }
    
    # Clean up temp folder
    Write-Verbose "Cleaning up temporary directory..."
    if (Test-Path $TEMP_FOLDER) {
        try {
            Remove-Item $TEMP_FOLDER -Recurse -Force -ErrorAction Stop
            Write-Verbose "  Temp directory cleaned up successfully"
        } catch {
            Write-Warning "  Failed to clean up temp directory: $($_.Exception.Message)"
            Write-Verbose "  Cleanup failed: $($_.Exception.GetType().Name)"
        }
    } else {
        Write-Verbose "  Temp directory does not exist, no cleanup needed"
    }
    
    Write-Verbose "=== Download-DvcFile function completed ==="
    Write-Verbose "  Result: $(if ($success) { 'SUCCESS' } else { 'FAILED' })"
    
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
        [Console]::Error.WriteLine("")
    }
    
    # Report results based on success rate
    if ($successCount -eq $totalCount) {
        Write-Success "Download complete! Successfully downloaded $successCount/$totalCount files"
    } elseif ($successCount -gt 0) {
        Write-Warning "Download partially complete! Successfully downloaded $successCount/$totalCount files"
        exit 1
    } else {
        Write-ErrorMsg "Download failed! Successfully downloaded $successCount/$totalCount files"
        exit 1
    }
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
        [Console]::Error.WriteLine("")
    }
    
    # Report results based on success rate
    if ($successCount -eq $totalCount) {
        Write-Success "Batch download complete! Successfully downloaded $successCount/$totalCount files"
    } elseif ($successCount -gt 0) {
        Write-Warning "Batch download partially complete! Successfully downloaded $successCount/$totalCount files"
        exit 1
    } else {
        Write-ErrorMsg "Batch download failed! Successfully downloaded $successCount/$totalCount files"
        exit 1
    }
}

# Main function
function Main {
    Write-Verbose "=== Starting Main function ==="
    Write-Verbose "Checking rclone availability..."
    
    # Check if rclone is available
    try {
        $rcloneInfo = Get-Command rclone -ErrorAction Stop
        Write-Verbose "rclone found: $($rcloneInfo.Source)"
        
        if ($VERBOSE) {
            Write-Verbose "rclone version information:"
            try {
                $rcloneVersion = & rclone version 2>&1 | Select-Object -First 5
                $rcloneVersion | ForEach-Object { Write-Verbose "  $_" }
            } catch {
                Write-Verbose "Could not get rclone version: $($_.Exception.Message)"
            }
            
            # Test rclone config
            Write-Verbose "Testing rclone configuration..."
            try {
                $configTest = & rclone config show 2>&1
                if ($LASTEXITCODE -eq 0) {
                    Write-Verbose "rclone config is readable"
                    if ($configTest) {
                        Write-Verbose "Available remotes:"
                        ($configTest | Select-String '^\[') | ForEach-Object { Write-Verbose "  $($_.Line)" }
                    } else {
                        Write-Verbose "No remotes configured"
                    }
                } else {
                    Write-Verbose "rclone config has issues (exit code: $LASTEXITCODE)"
                }
            } catch {
                Write-Verbose "rclone config test failed: $($_.Exception.Message)"
            }
        }
    } catch {
        Write-ErrorMsg "rclone is not installed or not in PATH"
        Write-Verbose "PATH: $env:PATH"
        Write-Verbose "Searched for rclone in PATH directories"
        exit 1
    }
    
    # Check for help or no arguments
    Write-Verbose "Parsing command line arguments..."
    Write-Verbose "Number of arguments: $($Arguments.Count)"
    if ($VERBOSE -and $Arguments.Count -gt 0) {
        Write-Verbose "Arguments provided:"
        for ($i = 0; $i -lt $Arguments.Count; $i++) {
            Write-Verbose "  [$i]: '$($Arguments[$i])'"
        }
    }
    
    if ($Arguments.Count -eq 0 -or $Arguments[0] -eq "--help" -or $Arguments[0] -eq "-h") {
        Write-Verbose "Help requested or no arguments provided"
        Show-Help
        exit 0
    }
    
    # Parse command
    $command = $Arguments[0]
    Write-Verbose "Command: '$command'"
    
    if ($Arguments.Count -gt 1) {
        $remainingArgs = $Arguments[1..($Arguments.Count-1)]
        # Ensure it's always an array, even with single element
        if ($remainingArgs -isnot [array]) {
            $remainingArgs = @($remainingArgs)
        }
    } else {
        $remainingArgs = @()
    }
    
    Write-Verbose "Remaining arguments after command:"
    if ($VERBOSE -and $remainingArgs.Count -gt 0) {
        for ($i = 0; $i -lt $remainingArgs.Count; $i++) {
            Write-Verbose "  [$i]: '$($remainingArgs[$i])'"
        }
    } elseif ($remainingArgs.Count -eq 0) {
        Write-Verbose "  (no remaining arguments)"
    }
    
    switch ($command.ToLower()) {
        "files" {
            Write-Verbose "Executing 'files' command"
            Invoke-FilesCommand @remainingArgs
        }
        "folder" {
            Write-Verbose "Executing 'folder' command"
            Invoke-DirectoryCommand @remainingArgs
        }
        default {
            Write-ErrorMsg "Unknown command: $command"
            Write-Verbose "Available commands: files, folder"
            Show-Help
            exit 1
        }
    }
}

# Run main function
Main
