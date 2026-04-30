#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Initialize the Bob Sandbox development environment
.DESCRIPTION
    This script sets up the Bob Sandbox by:
    - Verifying prerequisites (Node.js)
    - Installing MCP server dependencies
    - Building MCP servers
    - Verifying custom modes
    - Creating sample test files
    - Displaying environment status
.EXAMPLE
    .\init-sandbox.ps1
.EXAMPLE
    .\init-sandbox.ps1 -Verbose
#>

[CmdletBinding()]
param()

# Script configuration
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

# Colors for output
function Write-Success { Write-Host "✓ $args" -ForegroundColor Green }
function Write-Info { Write-Host "ℹ $args" -ForegroundColor Cyan }
function Write-Warning { Write-Host "⚠ $args" -ForegroundColor Yellow }
function Write-Error { Write-Host "✗ $args" -ForegroundColor Red }
function Write-Header { Write-Host "`n=== $args ===" -ForegroundColor Magenta }

# Get script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SandboxRoot = Split-Path -Parent $ScriptDir

Write-Host "`n╔════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   Bob Sandbox Initialization Script       ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════╝`n" -ForegroundColor Cyan

# Step 1: Verify Prerequisites
Write-Header "Checking Prerequisites"

# Check Node.js
Write-Info "Checking Node.js installation..."
try {
    $nodeVersion = node --version 2>$null
    if ($nodeVersion) {
        Write-Success "Node.js found: $nodeVersion"
    } else {
        throw "Node.js not found"
    }
} catch {
    Write-Error "Node.js is not installed or not in PATH"
    Write-Info "Please install Node.js from https://nodejs.org/ (LTS version recommended)"
    exit 1
}

# Check npm
Write-Info "Checking npm installation..."
try {
    $npmVersion = npm --version 2>$null
    if ($npmVersion) {
        Write-Success "npm found: v$npmVersion"
    } else {
        throw "npm not found"
    }
} catch {
    Write-Error "npm is not installed or not in PATH"
    exit 1
}

# Step 2: Verify Directory Structure
Write-Header "Verifying Directory Structure"

$requiredDirs = @(
    ".bob",
    "mcp-servers",
    "test-scenarios/mode-tests",
    "test-scenarios/tool-tests",
    "test-scenarios/integration-tests",
    "docs",
    "scripts"
)

foreach ($dir in $requiredDirs) {
    $fullPath = Join-Path $SandboxRoot $dir
    if (Test-Path $fullPath) {
        Write-Success "Directory exists: $dir"
    } else {
        Write-Warning "Creating missing directory: $dir"
        New-Item -ItemType Directory -Force -Path $fullPath | Out-Null
        Write-Success "Created: $dir"
    }
}

# Step 3: Verify Custom Modes Configuration
Write-Header "Verifying Custom Modes"

$customModesPath = Join-Path $SandboxRoot ".bob/custom_modes.yaml"
if (Test-Path $customModesPath) {
    Write-Success "Custom modes configuration found"
    
    # Check for required modes
    $modesContent = Get-Content $customModesPath -Raw
    $requiredModes = @("test", "debug", "experimental")
    
    foreach ($mode in $requiredModes) {
        if ($modesContent -match "slug:\s+$mode") {
            Write-Success "Mode '$mode' configured"
        } else {
            Write-Warning "Mode '$mode' not found in configuration"
        }
    }
} else {
    Write-Error "Custom modes configuration not found at .bob/custom_modes.yaml"
    Write-Info "Please ensure the custom_modes.yaml file exists"
}

# Step 4: Setup MCP Servers
Write-Header "Setting Up MCP Servers"

$mcpServersDir = Join-Path $SandboxRoot "mcp-servers"
$calculatorServerDir = Join-Path $mcpServersDir "calculator-server"

if (Test-Path $calculatorServerDir) {
    Write-Info "Calculator server directory found"
    
    # Check if package.json exists
    $packageJsonPath = Join-Path $calculatorServerDir "package.json"
    if (Test-Path $packageJsonPath) {
        Write-Info "Installing calculator server dependencies..."
        Push-Location $calculatorServerDir
        try {
            npm install 2>&1 | Out-Null
            Write-Success "Dependencies installed"
            
            Write-Info "Building calculator server..."
            npm run build 2>&1 | Out-Null
            Write-Success "Calculator server built successfully"
            
            # Verify build output
            $buildPath = Join-Path $calculatorServerDir "build/index.js"
            if (Test-Path $buildPath) {
                Write-Success "Build output verified: build/index.js"
            } else {
                Write-Warning "Build output not found at expected location"
            }
        } catch {
            Write-Error "Failed to build calculator server: $_"
        } finally {
            Pop-Location
        }
    } else {
        Write-Warning "Calculator server not fully initialized (package.json missing)"
        Write-Info "Run: cd mcp-servers && npx @modelcontextprotocol/create-server calculator-server"
    }
} else {
    Write-Warning "Calculator server directory not found"
    Write-Info "To create it, run:"
    Write-Info "  cd $mcpServersDir"
    Write-Info "  npx @modelcontextprotocol/create-server calculator-server"
}

# Step 5: Create Sample Test Files
Write-Header "Creating Sample Test Files"

$sampleFiles = @{
    "test-scenarios/README.md" = @"
# Test Scenarios

This directory contains test scenarios for the Bob Sandbox environment.

## Directory Structure

- **mode-tests/** - Tests for custom mode functionality
- **tool-tests/** - Tests for individual tool operations
- **integration-tests/** - End-to-end workflow tests

## Running Tests

1. Open the test scenario markdown file
2. Follow the steps outlined in the test
3. Document results in the "Actual Result" sections
4. Use the test-runner script for automated execution (when available)

## Creating New Tests

1. Choose the appropriate directory
2. Create a markdown file following the existing format
3. Include: Purpose, Prerequisites, Steps, Expected Results
4. Document thoroughly for future reference
"@
    "test-scenarios/mode-tests/README.md" = @"
# Mode Tests

Tests for verifying custom mode behavior and restrictions.

## Available Tests

- **test-mode-switching.md** - Verify mode switching works correctly
- **test-file-restrictions.md** - Verify Test mode file access restrictions

## Running Mode Tests

1. Start with Test mode
2. Follow test steps sequentially
3. Document mode-specific behavior
4. Verify restrictions are enforced
"@
    "test-scenarios/tool-tests/README.md" = @"
# Tool Tests

Tests for individual tool functionality.

## Available Tests

- **test-file-operations.md** - Test all file operation tools

## Running Tool Tests

1. Use Test or Debug mode
2. Test each tool independently
3. Verify expected behavior
4. Document any issues
"@
    "test-scenarios/integration-tests/README.md" = @"
# Integration Tests

End-to-end workflow tests combining multiple tools and modes.

## Available Tests

- **test-end-to-end-workflow.md** - Complete project workflow test

## Running Integration Tests

1. Allocate sufficient time (15-30 minutes)
2. Follow all phases sequentially
3. Switch modes as instructed
4. Document the complete workflow
"@
}

foreach ($file in $sampleFiles.Keys) {
    $filePath = Join-Path $SandboxRoot $file
    if (-not (Test-Path $filePath)) {
        Write-Info "Creating $file..."
        $sampleFiles[$file] | Out-File -FilePath $filePath -Encoding UTF8
        Write-Success "Created: $file"
    } else {
        Write-Info "Already exists: $file"
    }
}

# Step 6: Display Environment Status
Write-Header "Environment Status"

Write-Host "`nSandbox Root: " -NoNewline
Write-Host $SandboxRoot -ForegroundColor Yellow

Write-Host "`nCustom Modes:"
Write-Host "  🧪 Test Mode       - Safe testing with file restrictions" -ForegroundColor Green
Write-Host "  🐛 Debug Mode      - Full access for troubleshooting" -ForegroundColor Green
Write-Host "  🚀 Experimental    - Unrestricted innovation mode" -ForegroundColor Green

Write-Host "`nTest Scenarios:"
$testCount = (Get-ChildItem -Path (Join-Path $SandboxRoot "test-scenarios") -Recurse -Filter "*.md" | Where-Object { $_.Name -like "test-*" }).Count
Write-Host "  $testCount test scenarios available" -ForegroundColor Cyan

Write-Host "`nDocumentation:"
Write-Host "  📖 README.md           - Main documentation" -ForegroundColor Cyan
Write-Host "  📖 docs/SETUP.md       - Setup instructions" -ForegroundColor Cyan
Write-Host "  📖 docs/USAGE.md       - Usage guide" -ForegroundColor Cyan
Write-Host "  📖 docs/TROUBLESHOOTING.md - Troubleshooting guide" -ForegroundColor Cyan

# Step 7: Next Steps
Write-Header "Next Steps"

Write-Host @"

1. Open VS Code in the sandbox directory:
   code $SandboxRoot

2. Verify custom modes appear in the mode switcher

3. Try switching to Test mode and run a simple test

4. Review documentation in the docs/ directory

5. Explore test scenarios in test-scenarios/

6. (Optional) Configure MCP servers in Bob's settings

"@ -ForegroundColor White

Write-Host "╔════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║   Initialization Complete! ✓               ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════╝`n" -ForegroundColor Green

exit 0

# Made with Bob
