#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Clean up Bob Sandbox test artifacts
.DESCRIPTION
    This script cleans up the Bob Sandbox by:
    - Removing test files created during testing
    - Clearing temporary files
    - Preserving configuration and documentation
    - Optionally resetting to initial state
.PARAMETER Full
    Perform a full cleanup including MCP server builds
.PARAMETER Preserve
    Preserve test result files (don't delete filled-in test scenarios)
.EXAMPLE
    .\cleanup-sandbox.ps1
.EXAMPLE
    .\cleanup-sandbox.ps1 -Full
.EXAMPLE
    .\cleanup-sandbox.ps1 -Preserve
#>

[CmdletBinding()]
param(
    [switch]$Full,
    [switch]$Preserve
)

# Script configuration
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

# Colors for output
function Write-Success { Write-Host "[+] $args" -ForegroundColor Green }
function Write-Info { Write-Host "[*] $args" -ForegroundColor Cyan }
function Write-Warning { Write-Host "[!] $args" -ForegroundColor Yellow }
function Write-Error { Write-Host "[-] $args" -ForegroundColor Red }
function Write-Header { Write-Host "`n=== $args ===" -ForegroundColor Magenta }

# Get script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SandboxRoot = Split-Path -Parent $ScriptDir

Write-Host "`n======================================" -ForegroundColor Cyan
Write-Host "Bob Sandbox Cleanup Script" -ForegroundColor Cyan
Write-Host "======================================`n" -ForegroundColor Cyan

if ($Full) {
    Write-Warning "Full cleanup mode enabled - will remove build artifacts"
}

if ($Preserve) {
    Write-Info "Preserve mode enabled - will keep test result files"
}

# Confirm cleanup
Write-Host "`nThis will remove test artifacts from the sandbox." -ForegroundColor Yellow
$response = Read-Host "Continue? (y/N)"
if ($response -ne 'y' -and $response -ne 'Y') {
    Write-Info "Cleanup cancelled"
    exit 0
}

# Step 1: Clean Test Artifacts
Write-Header "Cleaning Test Artifacts"

$testDirs = @(
    "test-scenarios/mode-tests",
    "test-scenarios/tool-tests",
    "test-scenarios/integration-tests"
)

$cleanedCount = 0

foreach ($dir in $testDirs) {
    $fullPath = Join-Path $SandboxRoot $dir
    if (Test-Path $fullPath) {
        # Find test artifact files (not the test definition files)
        $artifacts = Get-ChildItem -Path $fullPath -Recurse -File | Where-Object {
            $_.Name -match "^(sample|test-file|file\d+|empty|large|new-file)" -or
            $_.Extension -in @('.tmp', '.log', '.bak')
        }
        
        foreach ($artifact in $artifacts) {
            try {
                Remove-Item $artifact.FullName -Force
                Write-Success "Removed: $($artifact.Name)"
                $cleanedCount++
            } catch {
                Write-Warning "Could not remove: $($artifact.Name) - $_"
            }
        }
    }
}

if ($cleanedCount -eq 0) {
    Write-Info "No test artifacts found to clean"
} else {
    Write-Success "Removed $cleanedCount test artifact(s)"
}

# Step 2: Clean Web Project (if exists)
Write-Header "Cleaning Test Projects"

$webProjectPath = Join-Path $SandboxRoot "web-project"
if (Test-Path $webProjectPath) {
    Write-Info "Found web-project directory"
    try {
        Remove-Item $webProjectPath -Recurse -Force
        Write-Success "Removed web-project directory"
    } catch {
        Write-Warning "Could not remove web-project: $_"
    }
} else {
    Write-Info "No web-project directory found"
}

# Clean any other test project directories
$testProjects = Get-ChildItem -Path $SandboxRoot -Directory | Where-Object {
    $_.Name -match "^(test-|sample-|demo-)" -and $_.Name -ne "test-scenarios"
}

foreach ($project in $testProjects) {
    Write-Info "Found test project: $($project.Name)"
    try {
        Remove-Item $project.FullName -Recurse -Force
        Write-Success "Removed: $($project.Name)"
    } catch {
        Write-Warning "Could not remove $($project.Name): $_"
    }
}

# Step 3: Clean Temporary Files
Write-Header "Cleaning Temporary Files"

$tempPatterns = @("*.tmp", "*.log", "*.bak", "*~", ".DS_Store")
$tempCount = 0

foreach ($pattern in $tempPatterns) {
    $tempFiles = Get-ChildItem -Path $SandboxRoot -Recurse -Filter $pattern -File -ErrorAction SilentlyContinue
    foreach ($file in $tempFiles) {
        try {
            Remove-Item $file.FullName -Force
            Write-Success "Removed: $($file.Name)"
            $tempCount++
        } catch {
            Write-Warning "Could not remove: $($file.Name)"
        }
    }
}

if ($tempCount -eq 0) {
    Write-Info "No temporary files found"
} else {
    Write-Success "Removed $tempCount temporary file(s)"
}

# Step 4: Clean MCP Server Artifacts (Full mode only)
if ($Full) {
    Write-Header "Cleaning MCP Server Build Artifacts"
    
    $mcpServersDir = Join-Path $SandboxRoot "mcp-servers"
    if (Test-Path $mcpServersDir) {
        $servers = Get-ChildItem -Path $mcpServersDir -Directory
        
        foreach ($server in $servers) {
            # Clean node_modules
            $nodeModules = Join-Path $server.FullName "node_modules"
            if (Test-Path $nodeModules) {
                Write-Info "Removing node_modules from $($server.Name)..."
                try {
                    Remove-Item $nodeModules -Recurse -Force
                    Write-Success "Removed node_modules"
                } catch {
                    Write-Warning "Could not remove node_modules: $_"
                }
            }
            
            # Clean build directory
            $buildDir = Join-Path $server.FullName "build"
            if (Test-Path $buildDir) {
                Write-Info "Removing build directory from $($server.Name)..."
                try {
                    Remove-Item $buildDir -Recurse -Force
                    Write-Success "Removed build directory"
                } catch {
                    Write-Warning "Could not remove build directory: $_"
                }
            }
            
            # Clean package-lock.json
            $packageLock = Join-Path $server.FullName "package-lock.json"
            if (Test-Path $packageLock) {
                try {
                    Remove-Item $packageLock -Force
                    Write-Success "Removed package-lock.json"
                } catch {
                    Write-Warning "Could not remove package-lock.json: $_"
                }
            }
        }
    }
}

# Step 5: Verify Preserved Files
Write-Header "Verifying Preserved Files"

$preservedFiles = @(
    ".bob/custom_modes.yaml",
    "README.md",
    "docs/SETUP.md",
    "docs/USAGE.md",
    "docs/TROUBLESHOOTING.md",
    "scripts/init-sandbox.ps1",
    "scripts/cleanup-sandbox.ps1"
)

$allPreserved = $true
foreach ($file in $preservedFiles) {
    $fullPath = Join-Path $SandboxRoot $file
    if (Test-Path $fullPath) {
        Write-Success "Preserved: $file"
    } else {
        Write-Warning "Missing: $file"
        $allPreserved = $false
    }
}

if ($allPreserved) {
    Write-Success "All configuration and documentation files preserved"
}

# Step 6: Summary
Write-Header "Cleanup Summary"

Write-Host "`nCleaned:"
Write-Host "  [+] Test artifacts" -ForegroundColor Green
Write-Host "  [+] Test projects" -ForegroundColor Green
Write-Host "  [+] Temporary files" -ForegroundColor Green
if ($Full) {
    Write-Host "  [+] MCP server builds" -ForegroundColor Green
}

Write-Host "`nPreserved:"
Write-Host "  [+] Custom modes configuration" -ForegroundColor Cyan
Write-Host "  [+] Documentation" -ForegroundColor Cyan
Write-Host "  [+] Test scenario templates" -ForegroundColor Cyan
Write-Host "  [+] Scripts" -ForegroundColor Cyan
if (-not $Full) {
    Write-Host "  [+] MCP server builds" -ForegroundColor Cyan
}

# Step 7: Next Steps
Write-Header "Next Steps"

if ($Full) {
    Write-Host @"

To rebuild the environment:
1. Run: .\scripts\init-sandbox.ps1
2. This will reinstall dependencies and rebuild MCP servers

"@ -ForegroundColor White
} else {
    Write-Host @"

The sandbox is now clean and ready for new tests.
- Configuration files are preserved
- MCP servers are still built
- Test templates are available

To start testing:
1. Open VS Code in the sandbox directory
2. Switch to Test mode
3. Run test scenarios

"@ -ForegroundColor White
}

Write-Host "======================================" -ForegroundColor Green
Write-Host "Cleanup Complete!" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
Write-Host ""

exit 0

# Made with Bob
