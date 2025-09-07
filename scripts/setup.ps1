# Run this script in windows powershell to set up the environment for using lunch.sh CLI.
# It adds the script directory to the PATH for the current session and provides instructions for making it

# Usage:
# .\setup.ps1

# Bypass execution policy for the current session
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

# Get the directory where this setup script is located
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Add dvc-download.ps1 script to PATH for easy access
$env:Path += ";$scriptDir"

# Check if the lunch.ps1 script exists
$lunchScript = Join-Path $scriptDir "lunch.ps1"
if (Test-Path $lunchScript) {
    Write-Host "Found lunch.ps1 script" -ForegroundColor Green
} else {
    Write-Warning "lunch.ps1 script not found in $scriptDir"
}

# Check if the script directory is already in the user's PATH permanently
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$scriptDir*") {
    Write-Host ""
    Write-Host "To make this PATH change permanent, you can:" -ForegroundColor Yellow
    Write-Host "1. Run this command as Administrator:" -ForegroundColor Cyan
    Write-Host "   [Environment]::SetEnvironmentVariable('Path', `$env:Path + ';$scriptDir', 'User')" -ForegroundColor Gray
    Write-Host ""
    Write-Host "2. Or manually add to your Windows PATH environment variable:" -ForegroundColor Cyan
    Write-Host "   $scriptDir" -ForegroundColor Gray
} else {
    Write-Host "Script directory already found in permanent PATH" -ForegroundColor Green
}

Write-Host ""
Write-Host "Setup complete! Script directory added to PATH: $scriptDir" -ForegroundColor Green
Write-Host "You can now run 'lunch.ps1' from anywhere in this session just by typing lunch" -ForegroundColor Green
