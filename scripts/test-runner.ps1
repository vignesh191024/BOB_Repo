#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Run Bob Sandbox test scenarios
.DESCRIPTION
    This script helps run test scenarios by:
    - Listing available test scenarios
    - Running specific test categories
    - Generating test reports
    - Tracking test results
.PARAMETER Category
    Test category to run (mode-tests, tool-tests, integration-tests, or all)
.PARAMETER Verbose
    Show detailed output
.PARAMETER Report
    Generate a test report file
.EXAMPLE
    .\test-runner.ps1
.EXAMPLE
    .\test-runner.ps1 -Category mode-tests
.EXAMPLE
    .\test-runner.ps1 -Category all -Report
#>

[CmdletBinding()]
param(
    [ValidateSet("mode-tests", "tool-tests", "integration-tests", "all")]
    [string]$Category = "all",
    
    [switch]$Report
)

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
$TestScenariosDir = Join-Path $SandboxRoot "test-scenarios"

Write-Host "`n╔════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   Bob Sandbox Test Runner                  ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════╝`n" -ForegroundColor Cyan

# Function to get test files
function Get-TestFiles {
    param([string]$CategoryPath)
    
    if (Test-Path $CategoryPath) {
        return Get-ChildItem -Path $CategoryPath -Filter "test-*.md" -File
    }
    return @()
}

# Function to analyze test file
function Get-TestInfo {
    param([string]$FilePath)
    
    $content = Get-Content $FilePath -Raw
    
    # Extract test metadata
    $info = @{
        Path = $FilePath
        Name = [System.IO.Path]::GetFileNameWithoutExtension($FilePath)
        Purpose = ""
        StepCount = 0
        HasResults = $false
    }
    
    # Extract purpose
    if ($content -match "##\s+Purpose\s+([^\n]+)") {
        $info.Purpose = $matches[1].Trim()
    }
    
    # Count steps
    $info.StepCount = ([regex]::Matches($content, "###\s+Step\s+\d+")).Count
    
    # Check if test has been run (look for filled in results)
    $info.HasResults = $content -match "\*\*Actual Result:\*\*\s+[^\[_]"
    
    return $info
}

# Step 1: Discover Tests
Write-Header "Discovering Test Scenarios"

$categories = @()
if ($Category -eq "all") {
    $categories = @("mode-tests", "tool-tests", "integration-tests")
} else {
    $categories = @($Category)
}

$allTests = @()
foreach ($cat in $categories) {
    $catPath = Join-Path $TestScenariosDir $cat
    $tests = Get-TestFiles -CategoryPath $catPath
    
    if ($tests.Count -gt 0) {
        Write-Info "Found $($tests.Count) test(s) in $cat"
        foreach ($test in $tests) {
            $testInfo = Get-TestInfo -FilePath $test.FullName
            $testInfo.Category = $cat
            $allTests += $testInfo
        }
    } else {
        Write-Warning "No tests found in $cat"
    }
}

if ($allTests.Count -eq 0) {
    Write-Error "No test scenarios found"
    exit 1
}

Write-Success "Total tests discovered: $($allTests.Count)"

# Step 2: Display Test Summary
Write-Header "Test Summary"

Write-Host "`nAvailable Tests:" -ForegroundColor Cyan
foreach ($test in $allTests) {
    $status = if ($test.HasResults) { "✓ Completed" } else { "○ Not Run" }
    $statusColor = if ($test.HasResults) { "Green" } else { "Yellow" }
    
    Write-Host "`n  [$($test.Category)]" -ForegroundColor Magenta -NoNewline
    Write-Host " $($test.Name)" -ForegroundColor White
    Write-Host "    Purpose: $($test.Purpose)" -ForegroundColor Gray
    Write-Host "    Steps: $($test.StepCount)" -ForegroundColor Gray
    Write-Host "    Status: " -NoNewline
    Write-Host $status -ForegroundColor $statusColor
}

# Step 3: Test Execution Guide
Write-Header "Running Tests"

Write-Host @"

This test runner helps you organize and track test execution.
Tests must be run manually by following the steps in each test file.

To run a test:
1. Open the test file in VS Code
2. Follow the steps sequentially
3. Document results in the "Actual Result" sections
4. Save the file when complete

"@ -ForegroundColor White

# Step 4: Interactive Test Selection
Write-Host "Would you like to:" -ForegroundColor Cyan
Write-Host "  1. Open a specific test file" -ForegroundColor White
Write-Host "  2. View test statistics" -ForegroundColor White
Write-Host "  3. Generate test report" -ForegroundColor White
Write-Host "  4. Exit" -ForegroundColor White

$choice = Read-Host "`nEnter choice (1-4)"

switch ($choice) {
    "1" {
        # Open specific test
        Write-Host "`nAvailable tests:" -ForegroundColor Cyan
        for ($i = 0; $i -lt $allTests.Count; $i++) {
            Write-Host "  $($i + 1). [$($allTests[$i].Category)] $($allTests[$i].Name)" -ForegroundColor White
        }
        
        $testNum = Read-Host "`nEnter test number (1-$($allTests.Count))"
        $testIndex = [int]$testNum - 1
        
        if ($testIndex -ge 0 -and $testIndex -lt $allTests.Count) {
            $selectedTest = $allTests[$testIndex]
            Write-Info "Opening: $($selectedTest.Name)"
            
            # Open in VS Code
            code $selectedTest.Path
            Write-Success "Test file opened in VS Code"
        } else {
            Write-Error "Invalid test number"
        }
    }
    
    "2" {
        # View statistics
        Write-Header "Test Statistics"
        
        $totalTests = $allTests.Count
        $completedTests = ($allTests | Where-Object { $_.HasResults }).Count
        $pendingTests = $totalTests - $completedTests
        $completionRate = if ($totalTests -gt 0) { [math]::Round(($completedTests / $totalTests) * 100, 1) } else { 0 }
        
        Write-Host "`nOverall Statistics:" -ForegroundColor Cyan
        Write-Host "  Total Tests: $totalTests" -ForegroundColor White
        Write-Host "  Completed: " -NoNewline
        Write-Host $completedTests -ForegroundColor Green
        Write-Host "  Pending: " -NoNewline
        Write-Host $pendingTests -ForegroundColor Yellow
        Write-Host "  Completion Rate: " -NoNewline
        Write-Host "$completionRate%" -ForegroundColor $(if ($completionRate -ge 80) { "Green" } elseif ($completionRate -ge 50) { "Yellow" } else { "Red" })
        
        Write-Host "`nBy Category:" -ForegroundColor Cyan
        foreach ($cat in $categories) {
            $catTests = $allTests | Where-Object { $_.Category -eq $cat }
            $catCompleted = ($catTests | Where-Object { $_.HasResults }).Count
            $catTotal = $catTests.Count
            
            if ($catTotal -gt 0) {
                Write-Host "  $cat`: $catCompleted/$catTotal completed" -ForegroundColor White
            }
        }
    }
    
    "3" {
        # Generate report
        Write-Header "Generating Test Report"
        
        $reportPath = Join-Path $SandboxRoot "test-report-$(Get-Date -Format 'yyyyMMdd-HHmmss').md"
        
        $reportContent = @"
# Bob Sandbox Test Report

**Generated:** $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

## Summary

- **Total Tests:** $($allTests.Count)
- **Completed:** $(($allTests | Where-Object { $_.HasResults }).Count)
- **Pending:** $(($allTests | Where-Object { -not $_.HasResults }).Count)

## Test Results

"@
        
        foreach ($cat in $categories) {
            $catTests = $allTests | Where-Object { $_.Category -eq $cat }
            if ($catTests.Count -gt 0) {
                $reportContent += "`n### $cat`n`n"
                
                foreach ($test in $catTests) {
                    $status = if ($test.HasResults) { "✓ Completed" } else { "○ Pending" }
                    $reportContent += "- **$($test.Name)** - $status`n"
                    $reportContent += "  - Purpose: $($test.Purpose)`n"
                    $reportContent += "  - Steps: $($test.StepCount)`n"
                    $reportContent += "  - File: ``$($test.Path)```n`n"
                }
            }
        }
        
        $reportContent += @"

## Next Steps

1. Complete pending tests
2. Review and analyze results
3. Document any issues found
4. Update test scenarios based on findings

---

*Report generated by Bob Sandbox Test Runner*
"@
        
        $reportContent | Out-File -FilePath $reportPath -Encoding UTF8
        Write-Success "Report generated: $reportPath"
        
        # Open report
        code $reportPath
        Write-Info "Report opened in VS Code"
    }
    
    "4" {
        Write-Info "Exiting test runner"
        exit 0
    }
    
    default {
        Write-Warning "Invalid choice"
    }
}

# Step 5: Final Message
Write-Header "Test Runner Complete"

Write-Host @"

Tips for effective testing:
- Run tests in order (mode → tool → integration)
- Document all results thoroughly
- Note any unexpected behavior
- Use Debug mode to investigate issues
- Run cleanup script between test sessions

"@ -ForegroundColor White

Write-Host "╔════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║   Happy Testing! ✓                         ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════╝`n" -ForegroundColor Green

exit 0

# Made with Bob
