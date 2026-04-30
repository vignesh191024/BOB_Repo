# Bob Sandbox Initialization Script
param()

$ErrorActionPreference = "Stop"

function Write-Success { param($msg) Write-Host "OK: $msg" -ForegroundColor Green }
function Write-Info { param($msg) Write-Host "INFO: $msg" -ForegroundColor Cyan }
function Write-Warn { param($msg) Write-Host "WARN: $msg" -ForegroundColor Yellow }

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SandboxRoot = Split-Path -Parent $ScriptDir

Write-Host "`nBob Sandbox Initialization`n" -ForegroundColor Cyan

# Check Node.js
Write-Info "Checking Node.js..."
$nodeVer = node --version 2>$null
if ($nodeVer) {
    Write-Success "Node.js found: $nodeVer"
} else {
    Write-Host "ERROR: Node.js not found" -ForegroundColor Red
    exit 1
}

# Check npm
Write-Info "Checking npm..."
$npmVer = npm --version 2>$null
if ($npmVer) {
    Write-Success "npm found: v$npmVer"
} else {
    Write-Host "ERROR: npm not found" -ForegroundColor Red
    exit 1
}

# Verify directories
Write-Info "Verifying directories..."
$dirs = @(".bob", "mcp-servers", "test-scenarios", "docs", "scripts")
foreach ($d in $dirs) {
    $path = Join-Path $SandboxRoot $d
    if (Test-Path $path) {
        Write-Success "Found: $d"
    } else {
        Write-Warn "Missing: $d"
    }
}

# Check custom modes
$modesFile = Join-Path $SandboxRoot ".bob\custom_modes.yaml"
if (Test-Path $modesFile) {
    Write-Success "Custom modes configuration found"
} else {
    Write-Warn "Custom modes configuration not found"
}

# Check MCP server
$calcServer = Join-Path $SandboxRoot "mcp-servers\calculator-server"
if (Test-Path $calcServer) {
    Write-Info "Calculator server found"
    $buildDir = Join-Path $calcServer "build"
    if (Test-Path $buildDir) {
        Write-Success "Calculator server already built"
    } else {
        $pkgJson = Join-Path $calcServer "package.json"
        if (Test-Path $pkgJson) {
            Write-Info "Installing dependencies..."
            Push-Location $calcServer
            try {
                npm install 2>&1 | Out-Null
                Write-Success "Dependencies installed"
                
                Write-Info "Building server..."
                npm run build 2>&1 | Out-Null
                Write-Success "Server built"
            } catch {
                Write-Warn "Build failed but continuing"
            }
            Pop-Location
        }
    }
} else {
    Write-Warn "Calculator server not found"
}

Write-Host "`nInitialization complete!`n" -ForegroundColor Green
Write-Host "Sandbox root: $SandboxRoot" -ForegroundColor Yellow
Write-Host "`nNext steps:"
Write-Host "1. Open VS Code: code $SandboxRoot"
Write-Host "2. Switch to Test mode in Bob"
Write-Host "3. Explore test scenarios`n"

exit 0