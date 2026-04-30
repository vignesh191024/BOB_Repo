# Bob Sandbox Usage Guide

Learn how to effectively use the Bob Sandbox for testing and development.

## Getting Started

### Opening the Sandbox

1. Open VS Code
2. File > Open Folder
3. Navigate to `bob-sandbox` directory
4. Click "Select Folder"

The custom modes will automatically load from `.bob/custom_modes.yaml`.

### Switching Modes

Click the mode indicator in VS Code's status bar (bottom) to open the mode switcher, then select:
- 🧪 **Test** - For safe testing
- 🐛 **Debug** - For troubleshooting
- 🚀 **Experimental** - For innovation

## Common Workflows

### Workflow 1: Testing a New Feature

**Scenario:** You want to test how Bob handles file operations.

1. **Switch to Test Mode**
   ```
   Click mode switcher → Select "🧪 Test"
   ```

2. **Create a test file**
   ```
   Ask Bob: "Create a test file at bob-sandbox/test-scenarios/my-test.txt with some sample content"
   ```

3. **Verify the operation**
   ```
   Ask Bob: "Read the file you just created and verify its contents"
   ```

4. **Test modifications**
   ```
   Ask Bob: "Append a new line to the test file"
   ```

5. **Clean up**
   ```
   Ask Bob: "Delete the test file"
   ```

### Workflow 2: Debugging an Issue

**Scenario:** You're experiencing unexpected behavior and need to investigate.

1. **Switch to Debug Mode**
   ```
   Click mode switcher → Select "🐛 Debug"
   ```

2. **Gather information**
   ```
   Ask Bob: "List all files in the current directory and show their sizes"
   ```

3. **Analyze the problem**
   ```
   Ask Bob: "Read the error log and explain what's causing the issue"
   ```

4. **Test a hypothesis**
   ```
   Ask Bob: "Try running the command with verbose output to see what's happening"
   ```

5. **Implement a fix**
   ```
   Ask Bob: "Apply the fix we discussed to the configuration file"
   ```

### Workflow 3: Rapid Prototyping

**Scenario:** You want to experiment with a new approach.

1. **Switch to Experimental Mode**
   ```
   Click mode switcher → Select "🚀 Experimental"
   ```

2. **Brainstorm solutions**
   ```
   Ask Bob: "What are three different ways we could implement this feature?"
   ```

3. **Prototype quickly**
   ```
   Ask Bob: "Create a proof-of-concept implementation using approach #2"
   ```

4. **Test and iterate**
   ```
   Ask Bob: "Run the prototype and show me the output"
   Ask Bob: "Modify the approach based on what we learned"
   ```

5. **Document findings**
   ```
   Ask Bob: "Create a summary document of what worked and what didn't"
   ```

## Using MCP Servers

### Calculator Server Example

Once the calculator MCP server is configured:

1. **Switch to Experimental Mode** (MCP tools are available here)

2. **Use calculator tools**
   ```
   Ask Bob: "Use the calculator to add 15 and 27"
   Ask Bob: "Calculate 144 divided by 12"
   Ask Bob: "What's 8 times 9?"
   ```

3. **Access calculation history**
   ```
   Ask Bob: "Show me the calculation history resource"
   ```

### Creating Custom MCP Tools

1. **Navigate to MCP servers directory**
   ```powershell
   cd bob-sandbox/mcp-servers
   ```

2. **Create new server**
   ```powershell
   npx @modelcontextprotocol/create-server my-custom-server
   ```

3. **Implement your tools** (edit `src/index.ts`)

4. **Build the server**
   ```powershell
   cd my-custom-server
   npm install
   npm run build
   ```

5. **Configure in MCP settings** (see SETUP.md)

## Test Scenarios

### Running Mode Tests

Located in `test-scenarios/mode-tests/`:

**Test Mode Switching:**
```
1. Start in Test mode
2. Ask Bob: "What mode am I in?"
3. Switch to Debug mode
4. Ask Bob: "What mode am I in now?"
5. Verify mode-specific capabilities
```

**Test File Restrictions:**
```
1. Switch to Test mode
2. Ask Bob: "Try to edit a file outside bob-sandbox/"
3. Verify Bob refuses or warns
4. Ask Bob: "Edit a file inside bob-sandbox/"
5. Verify operation succeeds
```

### Running Tool Tests

Located in `test-scenarios/tool-tests/`:

**Test File Operations:**
```
1. Ask Bob: "Create a new file with sample content"
2. Ask Bob: "Read the file back"
3. Ask Bob: "Modify the file using apply_diff"
4. Ask Bob: "Verify the changes"
5. Ask Bob: "Delete the test file"
```

**Test Command Execution:**
```
1. Ask Bob: "Run 'node --version' and show me the output"
2. Ask Bob: "List files in the current directory"
3. Ask Bob: "Create a directory and verify it exists"
```

### Running Integration Tests

Located in `test-scenarios/integration-tests/`:

**End-to-End Workflow:**
```
1. Ask Bob: "Create a new project structure with multiple files"
2. Ask Bob: "Read all the files and verify their contents"
3. Ask Bob: "Make coordinated changes across multiple files"
4. Ask Bob: "Run tests to verify everything works"
5. Ask Bob: "Clean up the test project"
```

## Best Practices

### 1. Start with Test Mode

Always begin testing in Test mode for safety:
- File operations are restricted to sandbox
- Provides detailed feedback
- Safer for experimentation

### 2. Use Descriptive Test Names

When creating test files:
```
✅ Good: test-file-operations-with-large-files.md
❌ Bad: test1.md
```

### 3. Document Your Tests

Include in each test scenario:
- **Purpose:** What you're testing
- **Prerequisites:** What needs to be set up
- **Steps:** Detailed test steps
- **Expected Results:** What should happen
- **Actual Results:** What actually happened

### 4. Clean Up After Testing

Always clean up test artifacts:
```
Ask Bob: "Delete all test files we created"
Or run: .\scripts\cleanup-sandbox.ps1
```

### 5. Switch Modes Appropriately

- **Test Mode:** Learning, safe experimentation
- **Debug Mode:** Investigating issues, troubleshooting
- **Experimental Mode:** Innovation, prototyping, MCP testing

### 6. Leverage Mode-Specific Features

Each mode has unique strengths:

**Test Mode:**
- Verbose explanations
- Safety restrictions
- Learning-focused

**Debug Mode:**
- Enhanced error reporting
- Full access for investigation
- Systematic problem-solving

**Experimental Mode:**
- Creative freedom
- Rapid iteration
- Innovation-focused

## Advanced Usage

### Creating Custom Test Scenarios

1. **Choose the right directory:**
   - `mode-tests/` - Testing mode behavior
   - `tool-tests/` - Testing specific tools
   - `integration-tests/` - End-to-end workflows

2. **Create a markdown file:**
   ```markdown
   # Test: [Descriptive Name]
   
   ## Purpose
   What this test validates
   
   ## Prerequisites
   - Requirement 1
   - Requirement 2
   
   ## Steps
   1. Step 1
   2. Step 2
   3. Step 3
   
   ## Expected Results
   What should happen
   
   ## Actual Results
   What actually happened
   
   ## Notes
   Additional observations
   ```

3. **Run the test manually** or use `test-runner.ps1`

### Automating Tests

Use the test runner script:

```powershell
# Run all tests
.\scripts\test-runner.ps1

# Run specific test category
.\scripts\test-runner.ps1 -Category mode-tests

# Run with verbose output
.\scripts\test-runner.ps1 -Verbose
```

### Extending the Sandbox

**Add new custom modes:**
1. Edit `.bob/custom_modes.yaml`
2. Add new mode definition
3. Restart VS Code
4. Test the new mode

**Add new MCP servers:**
1. Create server in `mcp-servers/`
2. Implement tools and resources
3. Build the server
4. Configure in MCP settings
5. Test with Experimental mode

**Add new test scenarios:**
1. Create markdown file in appropriate directory
2. Follow test template format
3. Document thoroughly
4. Run and verify

## Troubleshooting

### Mode not switching

**Solution:**
1. Check status bar for current mode
2. Verify `.bob/custom_modes.yaml` syntax
3. Restart VS Code
4. Check Output panel for errors

### File operation denied

**Solution:**
1. Check which mode you're in
2. Verify file path is within allowed scope
3. Switch to appropriate mode
4. Try operation again

### MCP tool not available

**Solution:**
1. Verify you're in Experimental mode
2. Check MCP settings configuration
3. Restart VS Code
4. Check MCP server logs

### Test fails unexpectedly

**Solution:**
1. Switch to Debug mode
2. Run test step-by-step
3. Check for prerequisites
4. Verify environment state
5. Document the issue

## Tips and Tricks

### Quick Mode Switching

Use keyboard shortcuts (if configured) or click the status bar mode indicator.

### Verbose Output

In Test mode, Bob provides detailed explanations automatically.

### Parallel Testing

Open multiple VS Code windows with different modes for parallel testing.

### Version Control

Use Git to track changes to test scenarios and configurations:
```powershell
git init
git add .
git commit -m "Initial sandbox setup"
```

### Sharing Test Results

Export test results to share with team:
```
Ask Bob: "Create a summary report of all test results"
```

## Next Steps

- Explore [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for common issues
- Review test scenarios in `test-scenarios/`
- Create your own custom modes
- Develop custom MCP servers
- Contribute new test scenarios

---

**Happy Testing!** 🚀