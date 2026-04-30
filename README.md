# Bob Sandbox Development Environment

A comprehensive testing and development environment for Bob AI Assistant, featuring custom modes, MCP servers, test scenarios, and automation scripts.

## 🎯 Purpose

This sandbox provides an isolated environment for:
- Testing new Bob features safely
- Experimenting with custom modes
- Developing and testing MCP servers
- Validating tool functionality
- Learning Bob's capabilities
- Debugging issues in isolation

## 📁 Structure

```
bob-sandbox/
├── .bob/
│   └── custom_modes.yaml          # Workspace-specific custom modes
├── mcp-servers/
│   ├── calculator-server/         # Sample calculator MCP server
│   └── mock-api-server/           # Mock API server for testing
├── test-scenarios/
│   ├── mode-tests/                # Test cases for custom modes
│   ├── tool-tests/                # Test cases for tools
│   └── integration-tests/         # End-to-end test scenarios
├── docs/
│   ├── SETUP.md                   # Setup instructions
│   ├── USAGE.md                   # Usage guide
│   └── TROUBLESHOOTING.md         # Common issues and solutions
├── scripts/
│   ├── init-sandbox.ps1           # Initialize sandbox environment
│   ├── cleanup-sandbox.ps1        # Clean up test artifacts
│   └── test-runner.ps1            # Run test scenarios
└── README.md                      # This file
```

## 🚀 Quick Start

### 1. Initialize the Sandbox

```powershell
cd bob-sandbox
.\scripts\init-sandbox.ps1
```

This will:
- Install MCP server dependencies
- Verify custom modes are loaded
- Create sample test files
- Display available modes and tools

### 2. Open in VS Code

Open the `bob-sandbox` directory as your workspace in VS Code. The custom modes defined in `.bob/custom_modes.yaml` will automatically be available.

### 3. Start Testing

Use Bob's mode switcher to select one of the sandbox modes:
- 🧪 **Test Mode** - Safe testing with restricted file access
- 🐛 **Debug Mode** - Full access for troubleshooting
- 🚀 **Experimental Mode** - Unrestricted innovation

## 🎭 Custom Modes

### Test Mode (`test`)
**Purpose:** Safe experimentation and feature testing

**Capabilities:**
- Read files anywhere
- Edit files only within `bob-sandbox/`
- Execute commands
- Verbose logging and detailed feedback

**Use When:**
- Testing new features
- Validating tool behavior
- Learning how Bob works
- Experimenting safely

### Debug Mode (`debug`)
**Purpose:** Troubleshooting and debugging

**Capabilities:**
- Full read/write access
- Command execution
- Browser automation
- Enhanced error reporting

**Use When:**
- Investigating errors
- Debugging complex issues
- Analyzing stack traces
- Testing fixes

### Experimental Mode (`experimental`)
**Purpose:** Innovation and rapid prototyping

**Capabilities:**
- Unrestricted tool access
- MCP server integration
- Browser automation
- Full file system access

**Use When:**
- Prototyping new solutions
- Exploring creative approaches
- Testing unconventional ideas
- Learning new technologies

## 🔧 MCP Servers

### Calculator Server
A simple MCP server demonstrating basic arithmetic operations.

**Tools:**
- `add` - Add two numbers
- `subtract` - Subtract two numbers
- `multiply` - Multiply two numbers
- `divide` - Divide two numbers

**Resources:**
- `calculation_history` - View recent calculations

### Mock API Server
A simulated REST API for testing integrations.

**Tools:**
- `fetch_data` - Retrieve mock data
- `post_data` - Create new entries
- `update_data` - Modify existing entries

**Resources:**
- `mock_database` - Access mock database entries

## 📝 Test Scenarios

### Mode Tests
Located in `test-scenarios/mode-tests/`

- `test-mode-switching.md` - Verify mode transitions
- `test-mode-restrictions.md` - Validate file access restrictions
- `test-mode-capabilities.md` - Test mode-specific features

### Tool Tests
Located in `test-scenarios/tool-tests/`

- `test-file-operations.md` - Read, write, edit operations
- `test-command-execution.md` - Command execution tests
- `test-browser-actions.md` - Browser automation tests
- `test-mcp-integration.md` - MCP server communication

### Integration Tests
Located in `test-scenarios/integration-tests/`

- `test-end-to-end-workflow.md` - Complete workflow tests
- `test-error-handling.md` - Error recovery scenarios
- `test-multi-tool-operations.md` - Complex multi-step tasks

## 🛠️ Scripts

### init-sandbox.ps1
Initializes the sandbox environment:
- Installs Node.js dependencies for MCP servers
- Builds MCP server executables
- Verifies custom modes are loaded
- Creates sample test files
- Displays environment status

### cleanup-sandbox.ps1
Cleans up test artifacts:
- Removes generated test files
- Clears MCP server logs
- Resets test state
- Preserves configuration files

### test-runner.ps1
Executes test scenarios:
- Runs all test scenarios
- Generates test reports
- Identifies failures
- Provides summary statistics

## 📚 Documentation

- **[SETUP.md](docs/SETUP.md)** - Detailed setup instructions
- **[USAGE.md](docs/USAGE.md)** - Usage examples and workflows
- **[TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)** - Common issues and solutions

## 🔒 Safety Features

1. **File Restrictions** - Test mode limits edits to sandbox directory
2. **Isolated Environment** - All tests run in dedicated workspace
3. **Reversible Changes** - Cleanup scripts restore original state
4. **Clear Boundaries** - Explicit mode capabilities and limitations

## 💡 Best Practices

1. **Always use Test mode first** when trying new features
2. **Document your experiments** in test scenario files
3. **Run cleanup scripts** after testing sessions
4. **Switch to Debug mode** only when troubleshooting
5. **Use Experimental mode** for innovation sprints only

## 🤝 Contributing

To add new test scenarios:
1. Create a markdown file in the appropriate test directory
2. Follow the existing test format
3. Include expected outcomes
4. Document any prerequisites

To add new MCP servers:
1. Create server in `mcp-servers/` directory
2. Follow MCP SDK conventions
3. Add configuration to MCP settings
4. Document tools and resources

## 📄 License

This sandbox is part of the Bob AI Assistant development environment.

## 🆘 Support

For issues or questions:
1. Check [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)
2. Review test scenarios for examples
3. Use Debug mode to investigate issues
4. Consult Bob's main documentation

---

**Happy Testing! 🎉**