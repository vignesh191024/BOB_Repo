# Bob Sandbox Troubleshooting Guide

Common issues and solutions for the Bob Sandbox environment.

## Table of Contents

- [Setup Issues](#setup-issues)
- [Mode Issues](#mode-issues)
- [MCP Server Issues](#mcp-server-issues)
- [File Operation Issues](#file-operation-issues)
- [Script Issues](#script-issues)
- [General Issues](#general-issues)

---

## Setup Issues

### Issue: Custom modes not appearing in mode switcher

**Symptoms:**
- Mode switcher doesn't show Test, Debug, or Experimental modes
- Only default modes are visible

**Solutions:**

1. **Verify file exists:**
   ```powershell
   Test-Path bob-sandbox\.bob\custom_modes.yaml
   ```
   If false, the file is missing. Re-run init script or create manually.

2. **Check YAML syntax:**
   ```powershell
   Get-Content bob-sandbox\.bob\custom_modes.yaml
   ```
   Look for syntax errors (indentation, colons, dashes).

3. **Restart VS Code:**
   - Close all VS Code windows
   - Reopen the bob-sandbox folder
   - Check mode switcher again

4. **Check VS Code Output:**
   - View > Output
   - Select "Bob" from dropdown
   - Look for error messages about custom modes

5. **Verify workspace:**
   - Ensure bob-sandbox is opened as the workspace root
   - File > Open Folder > Select bob-sandbox directory

**Prevention:**
- Always open bob-sandbox as the workspace root
- Don't edit custom_modes.yaml while VS Code is running
- Validate YAML syntax before saving

---

### Issue: Init script fails to run

**Symptoms:**
- Script execution error
- "Cannot be loaded because running scripts is disabled"

**Solutions:**

1. **Check execution policy:**
   ```powershell
   Get-ExecutionPolicy
   ```

2. **Set execution policy:**
   ```powershell
   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
   ```

3. **Run with bypass:**
   ```powershell
   PowerShell -ExecutionPolicy Bypass -File .\scripts\init-sandbox.ps1
   ```

4. **Check permissions:**
   - Right-click script > Properties
   - Unblock if necessary
   - Ensure you have write permissions

**Prevention:**
- Set execution policy before running scripts
- Keep scripts in trusted locations

---

### Issue: Node.js not found

**Symptoms:**
- "node is not recognized as an internal or external command"
- MCP server installation fails

**Solutions:**

1. **Install Node.js:**
   - Download from https://nodejs.org/
   - Install LTS version (v18 or higher)
   - Restart terminal after installation

2. **Verify installation:**
   ```powershell
   node --version
   npm --version
   ```

3. **Add to PATH:**
   - Search "Environment Variables" in Windows
   - Edit PATH variable
   - Add Node.js installation directory
   - Restart terminal

**Prevention:**
- Install Node.js before setting up sandbox
- Use LTS version for stability

---

## Mode Issues

### Issue: Mode restrictions not working

**Symptoms:**
- Test mode allows editing files outside sandbox
- File restrictions not enforced

**Solutions:**

1. **Verify mode configuration:**
   ```yaml
   groups:
     - - edit
       - fileRegex: ^bob-sandbox/
         description: Files within bob-sandbox directory only
   ```

2. **Check current mode:**
   - Look at status bar
   - Verify you're in the correct mode

3. **Restart VS Code:**
   - Mode changes require restart to take effect

4. **Check file path format:**
   - Use forward slashes: `bob-sandbox/file.txt`
   - Not backslashes: `bob-sandbox\file.txt`

**Prevention:**
- Always verify current mode before operations
- Test restrictions after mode changes

---

### Issue: Cannot switch modes

**Symptoms:**
- Mode switcher doesn't respond
- Stuck in one mode

**Solutions:**

1. **Reload VS Code window:**
   - Ctrl+Shift+P > "Developer: Reload Window"

2. **Check for errors:**
   - View > Output > Bob
   - Look for mode-related errors

3. **Verify mode definitions:**
   - Ensure all required fields are present
   - Check for duplicate slugs

4. **Restart VS Code:**
   - Close all windows
   - Reopen workspace

**Prevention:**
- Don't edit custom_modes.yaml while VS Code is running
- Validate YAML before saving

---

### Issue: Mode-specific tools not available

**Symptoms:**
- Expected tools don't appear in mode
- Tool use fails with "not allowed" error

**Solutions:**

1. **Check mode configuration:**
   ```yaml
   groups:
     - read    # Required for read tools
     - edit    # Required for edit tools
     - command # Required for execute_command
     - browser # Required for browser_action
     - mcp     # Required for MCP tools
   ```

2. **Verify tool group:**
   - Each tool belongs to a specific group
   - Mode must include that group

3. **Switch to appropriate mode:**
   - Test mode: read, edit (restricted), command
   - Debug mode: read, edit, command, browser
   - Experimental mode: all groups including mcp

**Prevention:**
- Understand which tools belong to which groups
- Use appropriate mode for your task

---

## MCP Server Issues

### Issue: MCP server not starting

**Symptoms:**
- "MCP server failed to start" error
- Tools not available in Experimental mode

**Solutions:**

1. **Check server build:**
   ```powershell
   cd bob-sandbox\mcp-servers\calculator-server
   npm run build
   ```

2. **Test server manually:**
   ```powershell
   node build\index.js
   ```
   Should output: "Calculator MCP server running on stdio"

3. **Verify MCP settings:**
   - Check path in mcp_settings.json
   - Ensure path uses forward slashes
   - Verify command is "node"

4. **Check dependencies:**
   ```powershell
   npm install
   ```

5. **Review server logs:**
   - Check VS Code Output panel
   - Look for MCP-related errors

**Prevention:**
- Always build server after changes
- Test server manually before configuring
- Use absolute paths in MCP settings

---

### Issue: MCP tools not appearing

**Symptoms:**
- Server starts but tools not available
- Cannot use MCP tools in Experimental mode

**Solutions:**

1. **Verify mode:**
   - Must be in Experimental mode
   - MCP group must be in mode's groups list

2. **Check server configuration:**
   ```json
   {
     "mcpServers": {
       "calculator": {
         "command": "node",
         "args": ["C:/Users/VigneshB/BOB/bob-sandbox/mcp-servers/calculator-server/build/index.js"],
         "disabled": false
       }
     }
   }
   ```

3. **Restart VS Code:**
   - MCP servers load on startup
   - Changes require restart

4. **Check disabledTools:**
   - Ensure tools aren't in disabledTools array
   - Remove any unwanted restrictions

**Prevention:**
- Always use Experimental mode for MCP tools
- Verify server configuration before use
- Restart VS Code after MCP changes

---

### Issue: MCP server crashes

**Symptoms:**
- Server starts then stops
- Error messages in logs

**Solutions:**

1. **Check error logs:**
   - View > Output > Select MCP server
   - Read error message

2. **Common causes:**
   - Missing dependencies: `npm install`
   - Syntax errors: Check TypeScript compilation
   - Missing environment variables: Check env in MCP settings

3. **Test with simple operation:**
   ```
   Ask Bob: "Use calculator to add 1 and 1"
   ```

4. **Rebuild server:**
   ```powershell
   cd mcp-servers\calculator-server
   npm run build
   ```

**Prevention:**
- Test server manually before use
- Handle errors gracefully in server code
- Validate inputs in tool implementations

---

## File Operation Issues

### Issue: Cannot edit files in Test mode

**Symptoms:**
- "File editing not allowed" error
- Restrictions blocking legitimate operations

**Solutions:**

1. **Check file path:**
   - Must be within bob-sandbox/
   - Use relative path from workspace root

2. **Verify regex pattern:**
   ```yaml
   fileRegex: ^bob-sandbox/
   ```
   Matches files starting with "bob-sandbox/"

3. **Switch to Debug mode:**
   - If you need to edit files outside sandbox
   - Use Debug mode for unrestricted access

4. **Check file permissions:**
   - Ensure file isn't read-only
   - Verify you have write permissions

**Prevention:**
- Keep test files in sandbox directory
- Use Debug mode when needed
- Understand mode restrictions

---

### Issue: File not found errors

**Symptoms:**
- "File does not exist" error
- Cannot read or edit file

**Solutions:**

1. **Verify file path:**
   ```powershell
   Test-Path bob-sandbox\path\to\file.txt
   ```

2. **Check working directory:**
   - Paths are relative to workspace root
   - Use `list_files` to see structure

3. **Use correct path separator:**
   - Forward slashes: `bob-sandbox/file.txt`
   - Or backslashes: `bob-sandbox\file.txt`

4. **Create missing directories:**
   ```powershell
   New-Item -ItemType Directory -Force -Path bob-sandbox\path\to
   ```

**Prevention:**
- Use list_files to verify paths
- Create directories before files
- Use consistent path separators

---

## Script Issues

### Issue: Test runner fails

**Symptoms:**
- test-runner.ps1 doesn't execute
- No test results generated

**Solutions:**

1. **Check script exists:**
   ```powershell
   Test-Path .\scripts\test-runner.ps1
   ```

2. **Run with verbose output:**
   ```powershell
   .\scripts\test-runner.ps1 -Verbose
   ```

3. **Check test scenario files:**
   - Ensure test files exist
   - Verify markdown format

4. **Run manually:**
   - Execute test steps one by one
   - Identify failing step

**Prevention:**
- Create test scenarios before running
- Follow test file format
- Test scripts after changes

---

### Issue: Cleanup script removes too much

**Symptoms:**
- Important files deleted
- Configuration lost

**Solutions:**

1. **Restore from backup:**
   - Check if Git is initialized
   - Restore from version control

2. **Recreate configuration:**
   - Re-run init-sandbox.ps1
   - Manually recreate custom files

3. **Review cleanup script:**
   - Check what it deletes
   - Modify if too aggressive

**Prevention:**
- Use version control (Git)
- Review cleanup script before running
- Backup important files
- Test cleanup in safe environment first

---

## General Issues

### Issue: VS Code performance degradation

**Symptoms:**
- Slow response times
- High CPU usage
- Lag when switching modes

**Solutions:**

1. **Restart VS Code:**
   - Close all windows
   - Reopen workspace

2. **Clear VS Code cache:**
   - Close VS Code
   - Delete cache directory
   - Restart VS Code

3. **Disable unnecessary extensions:**
   - Extensions > Disable unused ones
   - Keep only essential extensions

4. **Check system resources:**
   - Close other applications
   - Free up memory
   - Check disk space

**Prevention:**
- Restart VS Code regularly
- Keep extensions minimal
- Monitor system resources

---

### Issue: Unexpected behavior after updates

**Symptoms:**
- Features stop working after update
- New errors appear

**Solutions:**

1. **Check changelog:**
   - Review Bob extension updates
   - Look for breaking changes

2. **Update dependencies:**
   ```powershell
   cd mcp-servers\calculator-server
   npm update
   npm run build
   ```

3. **Verify configurations:**
   - Check custom_modes.yaml format
   - Verify MCP settings structure

4. **Rollback if needed:**
   - Reinstall previous version
   - Report issue to developers

**Prevention:**
- Read update notes before updating
- Test in sandbox before production
- Keep backups of configurations

---

### Issue: Documentation out of sync

**Symptoms:**
- Instructions don't match actual behavior
- Examples don't work as described

**Solutions:**

1. **Check documentation version:**
   - Ensure docs match your setup
   - Look for version-specific notes

2. **Verify your setup:**
   - Compare with documented setup
   - Check for missing steps

3. **Update documentation:**
   - Contribute corrections
   - Document your findings

**Prevention:**
- Keep documentation updated
- Test examples before documenting
- Version documentation with code

---

## Getting Help

If you can't resolve an issue:

1. **Check Output panel:**
   - View > Output
   - Select "Bob" from dropdown
   - Look for detailed error messages

2. **Use Debug mode:**
   - Switch to Debug mode
   - Get enhanced error reporting
   - Investigate systematically

3. **Review logs:**
   - Check MCP server logs
   - Review VS Code logs
   - Look for patterns

4. **Create minimal reproduction:**
   - Isolate the issue
   - Document steps to reproduce
   - Test in clean environment

5. **Document the issue:**
   - What you were trying to do
   - What happened instead
   - Error messages
   - Steps to reproduce

---

## Quick Reference

### Common Commands

```powershell
# Check Node.js
node --version

# Check execution policy
Get-ExecutionPolicy

# Set execution policy
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned

# Test file exists
Test-Path path\to\file

# Build MCP server
cd mcp-servers\calculator-server
npm install
npm run build

# Test MCP server
node build\index.js

# Restart VS Code
Ctrl+Shift+P > "Developer: Reload Window"
```

### Common File Paths

```
Custom modes: bob-sandbox\.bob\custom_modes.yaml
MCP settings: C:\Users\VigneshB\.bob\settings\mcp_settings.json
Calculator server: bob-sandbox\mcp-servers\calculator-server\
Test scenarios: bob-sandbox\test-scenarios\
Documentation: bob-sandbox\docs\
Scripts: bob-sandbox\scripts\
```

---

**Still having issues? Use Debug mode to investigate further!** 🔍