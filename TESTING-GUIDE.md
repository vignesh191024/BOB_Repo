# Bob Sandbox Testing Guide

## 🎯 Overview

This guide will walk you through testing the Bob Sandbox environment, including the Calculator MCP Server and custom modes.

## 📋 Prerequisites

Before testing, ensure you have:
- ✅ Node.js installed (v18 or higher)
- ✅ Git installed
- ✅ VS Code with Bob extension
- ✅ Bob Sandbox repository cloned

## 🚀 Quick Start Testing

### Option 1: Run Automated Tests (Recommended)

The easiest way to test the calculator server:

```powershell
# Navigate to calculator server directory
cd bob-sandbox/mcp-servers/calculator-server

# Run the automated test suite
node test-client.js
```

**Expected Output:**
```
=== Calculator MCP Server Test Suite ===
Starting calculator server...
Connected to server

✓ Test 1: Addition
✓ Test 2: Subtraction
✓ Test 3: Multiplication
✓ Test 4: Division
✓ Test 5: Division by Zero
✓ Test 6: Power
✓ Test 7: Square Root
✓ Test 8: Negative Square Root
✓ Test 9: Calculation History

=== Test Summary ===
Total Tests: 9
Passed: 9
Failed: 0
Success Rate: 100.0%
```

### Option 2: Manual Server Testing

Test the server manually using the MCP protocol:

```powershell
# Start the calculator server
cd bob-sandbox/mcp-servers/calculator-server
node build/index.js
```

The server will run and wait for MCP protocol messages via stdin/stdout.

## 🧪 Testing Custom Modes

### Test Mode Testing

The Test mode is designed for safe experimentation within the bob-sandbox directory.

**To test Test mode:**

1. **Switch to Test Mode** (if available in your Bob configuration)
2. **Try file operations:**
   ```
   Ask Bob to:
   - Read files from anywhere
   - Edit files only within bob-sandbox/
   - Try to edit files outside bob-sandbox/ (should be restricted)
   ```

3. **Expected Behavior:**
   - ✅ Can read any file
   - ✅ Can edit files in bob-sandbox/
   - ❌ Cannot edit files outside bob-sandbox/
   - ✅ Can execute commands
   - ✅ Provides verbose feedback

### Debug Mode Testing

Debug mode provides full access for troubleshooting.

**To test Debug mode:**

1. Switch to Debug mode
2. Test full file system access
3. Test browser automation (if available)
4. Verify enhanced error reporting

### Experimental Mode Testing

Experimental mode includes MCP server access.

**To test Experimental mode:**

1. Switch to Experimental mode
2. Test MCP server integration
3. Test browser automation
4. Verify unrestricted tool access

## 🔧 Testing MCP Server Integration with Bob

### Step 1: Configure MCP Server in Bob

Add the calculator server to your Bob MCP configuration:

**Location:** VS Code Settings → Bob → MCP Servers

**Configuration:**
```json
{
  "mcpServers": {
    "calculator": {
      "command": "node",
      "args": ["C:/Users/VigneshB/BOB/bob-sandbox/mcp-servers/calculator-server/build/index.js"]
    }
  }
}
```

### Step 2: Test MCP Tools in Bob

Once configured, ask Bob to use calculator tools:

**Example Prompts:**

1. **Addition:**
   ```
   "Use the calculator to add 15, 25, and 30"
   ```

2. **Complex Calculation:**
   ```
   "Calculate 2 to the power of 10, then find the square root of the result"
   ```

3. **Error Handling:**
   ```
   "Try to divide 100 by 0 using the calculator"
   ```

4. **History Check:**
   ```
   "Show me the calculator history"
   ```

### Step 3: Verify Results

Check that:
- ✅ Bob can access calculator tools
- ✅ Calculations are accurate
- ✅ Error messages are clear
- ✅ History is maintained

## 📊 Running Test Scenarios

The sandbox includes predefined test scenarios:

### Mode Tests

```powershell
# Test mode switching
cd bob-sandbox/test-scenarios/mode-tests
# Follow instructions in test-mode-switching.md

# Test file restrictions
# Follow instructions in test-file-restrictions.md
```

### Tool Tests

```powershell
# Test file operations
cd bob-sandbox/test-scenarios/tool-tests
# Follow instructions in test-file-operations.md
```

### Integration Tests

```powershell
# Test end-to-end workflows
cd bob-sandbox/test-scenarios/integration-tests
# Follow instructions in test-end-to-end-workflow.md
```

## 🛠️ Using Sandbox Scripts

### Initialize Sandbox

```powershell
cd bob-sandbox
.\scripts\init-sandbox.ps1
```

**What it does:**
- Installs dependencies
- Builds MCP servers
- Verifies configuration
- Creates sample files

### Cleanup Sandbox

```powershell
cd bob-sandbox
.\scripts\cleanup-sandbox.ps1
```

**What it does:**
- Removes test artifacts
- Clears logs
- Resets test state
- Preserves configuration

### Run Test Suite

```powershell
cd bob-sandbox
.\scripts\test-runner.ps1
```

**What it does:**
- Runs all test scenarios
- Generates reports
- Identifies failures
- Provides summary

## 🔍 Troubleshooting Tests

### Calculator Server Won't Start

**Problem:** Server fails to start

**Solutions:**
1. Check Node.js version: `node --version` (need v18+)
2. Rebuild server: `cd bob-sandbox/mcp-servers/calculator-server && npm run build`
3. Check for port conflicts
4. Review error logs

### Tests Failing

**Problem:** Some tests fail

**Solutions:**
1. Check test output for specific errors
2. Verify server is built: `ls bob-sandbox/mcp-servers/calculator-server/build`
3. Reinstall dependencies: `npm install`
4. Check for file permission issues

### MCP Integration Not Working

**Problem:** Bob can't access calculator tools

**Solutions:**
1. Verify MCP configuration in VS Code settings
2. Check server path is correct
3. Restart VS Code
4. Check Bob extension logs
5. Verify server runs manually: `node build/index.js`

### Mode Switching Issues

**Problem:** Can't switch to custom modes

**Solutions:**
1. Verify `custom_modes.yaml` exists in `.bob/` directory
2. Check YAML syntax is valid
3. Restart VS Code
4. Check Bob extension version

## 📈 Test Results Interpretation

### Automated Test Output

```
✓ Green checkmark = Test passed
✗ Red X = Test failed
○ Yellow circle = Test skipped
```

### Success Criteria

**Calculator Server:**
- All 9 tests should pass (100% success rate)
- No errors in console output
- Server starts and stops cleanly

**Custom Modes:**
- Mode switching works smoothly
- File restrictions are enforced
- Tools are available as configured

**MCP Integration:**
- Bob can list calculator tools
- Tool calls return correct results
- Resources are accessible

## 🎓 Learning Exercises

### Exercise 1: Basic Calculator Usage

1. Start the test client
2. Observe all test outputs
3. Understand each operation
4. Review the test code

### Exercise 2: Custom Mode Exploration

1. Switch between different modes
2. Try operations in each mode
3. Note the differences
4. Document your findings

### Exercise 3: MCP Integration

1. Configure calculator in Bob
2. Use it for real calculations
3. Check calculation history
4. Try error scenarios

### Exercise 4: Extend the Server

1. Add a new operation (e.g., modulo)
2. Update the test client
3. Run tests to verify
4. Document the new feature

## 📚 Additional Resources

- **MCP Documentation:** https://modelcontextprotocol.io
- **Bob Documentation:** Check VS Code extension docs
- **Calculator Server Code:** `bob-sandbox/mcp-servers/calculator-server/src/index.ts`
- **Test Results:** `bob-sandbox/mcp-servers/calculator-server/test-results.md`

## 🆘 Getting Help

If you encounter issues:

1. Check `TROUBLESHOOTING.md` in docs/
2. Review test output carefully
3. Check server logs
4. Verify configuration files
5. Try cleanup and reinitialize

## ✅ Testing Checklist

Use this checklist to ensure complete testing:

- [ ] Automated tests run successfully (100% pass rate)
- [ ] Calculator server starts manually
- [ ] All arithmetic operations work
- [ ] Error handling functions correctly
- [ ] Calculation history is maintained
- [ ] Custom modes are accessible
- [ ] File restrictions work in Test mode
- [ ] MCP integration configured (if testing with Bob)
- [ ] Bob can use calculator tools (if testing with Bob)
- [ ] Test scenarios completed
- [ ] Documentation reviewed
- [ ] Cleanup script tested

---

**Happy Testing! 🎉**

For questions or issues, refer to the documentation in `bob-sandbox/docs/` or check the test results in `test-results.md`.