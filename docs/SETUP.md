# Bob Sandbox Setup Guide

Complete setup instructions for the Bob Sandbox development environment.

## Prerequisites

Before setting up the sandbox, ensure you have:

- ✅ **VS Code** with Bob extension installed
- ✅ **Node.js** (v18 or higher) for MCP servers
- ✅ **PowerShell** (Windows) or Bash (macOS/Linux)
- ✅ **Git** (optional, for version control)

## Installation Steps

### Step 1: Navigate to Sandbox Directory

```powershell
cd c:/Users/VigneshB/BOB/bob-sandbox
```

### Step 2: Run Initialization Script

```powershell
.\scripts\init-sandbox.ps1
```

This script will:
1. Check for Node.js installation
2. Install MCP server dependencies
3. Build MCP server executables
4. Verify custom modes are loaded
5. Create sample test files
6. Display environment status

### Step 3: Open Sandbox in VS Code

```powershell
code .
```

Or use VS Code's "File > Open Folder" and select the `bob-sandbox` directory.

### Step 4: Verify Custom Modes

1. Open Bob's mode switcher (click the mode indicator in the status bar)
2. Verify you see three new modes:
   - 🧪 Test
   - 🐛 Debug
   - 🚀 Experimental

### Step 5: Configure MCP Servers (Optional)

If you want to use the MCP servers globally:

1. Open Bob's MCP settings file:
   ```
   C:\Users\VigneshB\.bob\settings\mcp_settings.json
   ```

2. Add the calculator server configuration:
   ```json
   {
     "mcpServers": {
       "calculator": {
         "command": "node",
         "args": ["C:/Users/VigneshB/BOB/bob-sandbox/mcp-servers/calculator-server/build/index.js"],
         "disabled": false,
         "alwaysAllow": [],
         "disabledTools": []
       }
     }
   }
   ```

3. Restart VS Code to load the MCP server

## Verification

### Verify Custom Modes

1. Switch to Test mode
2. Ask Bob: "What mode am I in?"
3. Verify Bob responds with Test mode details

### Verify File Restrictions

1. In Test mode, try to edit a file outside `bob-sandbox/`
2. Verify Bob refuses or warns about restrictions

### Verify MCP Server (if configured)

1. Switch to Experimental mode
2. Ask Bob: "Use the calculator to add 5 and 3"
3. Verify Bob uses the MCP tool

## Troubleshooting Setup Issues

### Issue: Custom modes not appearing

**Solution:**
1. Verify `.bob/custom_modes.yaml` exists in the sandbox directory
2. Check the file for YAML syntax errors
3. Restart VS Code
4. Check VS Code's Output panel (View > Output) for Bob extension logs

### Issue: MCP server fails to start

**Solution:**
1. Verify Node.js is installed: `node --version`
2. Check MCP server build: `cd mcp-servers/calculator-server && npm run build`
3. Test server manually: `node build/index.js`
4. Check MCP settings file for correct paths

### Issue: Init script fails

**Solution:**
1. Ensure you have write permissions in the directory
2. Check Node.js installation
3. Run script with elevated privileges if needed
4. Check PowerShell execution policy: `Get-ExecutionPolicy`
5. If restricted, run: `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned`

### Issue: Cannot execute PowerShell scripts

**Solution:**
```powershell
# Check current policy
Get-ExecutionPolicy

# Set policy to allow local scripts
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned

# Confirm change
Get-ExecutionPolicy
```

## Manual Setup (Alternative)

If the init script fails, you can set up manually:

### 1. Install MCP Server Dependencies

```powershell
cd mcp-servers/calculator-server
npm install
npm run build
```

### 2. Create Sample Test Files

Create test files in `test-scenarios/` directories following the examples in USAGE.md.

### 3. Verify Custom Modes

Open `.bob/custom_modes.yaml` and verify the YAML syntax is correct.

## Next Steps

After successful setup:

1. Read [USAGE.md](USAGE.md) for usage examples
2. Explore test scenarios in `test-scenarios/`
3. Try switching between different modes
4. Run sample tests with `.\scripts\test-runner.ps1`

## Uninstallation

To remove the sandbox:

1. Run cleanup script:
   ```powershell
   .\scripts\cleanup-sandbox.ps1
   ```

2. Remove MCP server from global settings (if configured)

3. Delete the sandbox directory:
   ```powershell
   cd ..
   Remove-Item -Recurse -Force bob-sandbox
   ```

## Advanced Configuration

### Custom Mode Modifications

Edit `.bob/custom_modes.yaml` to:
- Add new custom modes
- Modify existing mode capabilities
- Adjust file restrictions
- Change tool group permissions

After editing, restart VS Code to apply changes.

### MCP Server Development

To create additional MCP servers:

1. Navigate to `mcp-servers/`
2. Create new server: `npx @modelcontextprotocol/create-server my-server`
3. Implement tools and resources
4. Build: `npm run build`
5. Add to MCP settings

### Test Scenario Customization

Create custom test scenarios:

1. Choose appropriate directory (`mode-tests/`, `tool-tests/`, or `integration-tests/`)
2. Create markdown file with test description
3. Include prerequisites, steps, and expected outcomes
4. Run with test-runner script

## Support

For additional help:
- Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- Review Bob's main documentation
- Use Debug mode to investigate issues

---

**Setup complete! Ready to start testing.** 🎉