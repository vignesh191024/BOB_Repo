# Bob Sandbox Test Runner
param(
    [ValidateSet("mode-tests", "tool-tests", "integration-tests", "all")]
    [string]$Category = "all"
)

$ErrorActionPreference = "Stop"

function Write-Success { param($msg) Write-Host "OK: $msg" -ForegroundColor Green }
function Write-Info { param($msg) Write-Host "INFO: $msg" -ForegroundColor Cyan }
function Write-Warn { param($msg) Write-Host "WARN: $msg" -ForegroundColor Yellow }

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SandboxRoot = Split-Path -Parent $ScriptDir
$TestScenariosDir = Join-Path $SandboxRoot "test-scenarios"

Write-Host "`nBob Sandbox Test Runner`n" -ForegroundColor Cyan

# Discover test files
$categories = if ($Category -eq "all") { @("mode-tests", "tool-tests", "integration-tests") } else { @($Category) }

$allTests = @()
foreach ($cat in $categories) {
    $catPath = Join-Path $TestScenariosDir $cat
    if (Test-Path $catPath) {
        $tests = Get-ChildItem -Path $catPath -Filter "test-*.md" -File
        if ($tests) {
            Write-Info "Found $($tests.Count) test(s) in $cat"
            foreach ($test in $tests) {
                $allTests += @{
                    Name = $test.BaseName
                    Path = $test.FullName
                    Category = $cat
                }
            }
        }
    }
}

if ($allTests.Count -eq 0) {
    Write-Warn "No test scenarios found"
    exit 0
}

Write-Success "Total tests discovered: $($allTests.Count)"

# Display tests
Write-Host "`nAvailable Tests:" -ForegroundColor Cyan
for ($i = 0; $i -lt $allTests.Count; $i++) {
    $test = $allTests[$i]
    Write-Host "  $($i + 1). [$($test.Category)] $($test.Name)" -ForegroundColor White
}

# Interactive menu
Write-Host "`nOptions:" -ForegroundColor Cyan
Write-Host "  1. Open a test file"
Write-Host "  2. View test list"
Write-Host "  3. Exit"

$choice = Read-Host "`nEnter choice (1-3)"

switch ($choice) {
    "1" {
        $testNum = Read-Host "Enter test number (1-$($allTests.Count))"
        $testIndex = [int]$testNum - 1
        
        if ($testIndex -ge 0 -and $testIndex -lt $allTests.Count) {
            $selectedTest = $allTests[$testIndex]
            Write-Info "Opening: $($selectedTest.Name)"
            code $selectedTest.Path
            Write-Success "Test file opened in VS Code"
        } else {
            Write-Warn "Invalid test number"
        }
    }
    
    "2" {
        Write-Host "`nTest List:" -ForegroundColor Cyan
        foreach ($test in $allTests) {
            Write-Host "  - [$($test.Category)] $($test.Name)"
            Write-Host "    Path: $($test.Path)" -ForegroundColor Gray
        }
    }
    
    "3" {
        Write-Info "Exiting"
        exit 0
    }
    
    default {
        Write-Warn "Invalid choice"
    }
}

Write-Host "`nTest Runner Complete`n" -ForegroundColor Green
Write-Host "Tips:"
Write-Host "- Open test files and follow steps manually"
Write-Host "- Document results in the test files"
Write-Host "- Use different modes to test restrictions`n"

exit 0