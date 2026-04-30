# Calculator MCP Server

A simple Model Context Protocol (MCP) server providing basic arithmetic operations for Bob Sandbox testing.

## Features

### Tools

- **add** - Add two or more numbers together
- **subtract** - Subtract one number from another
- **multiply** - Multiply two or more numbers together
- **divide** - Divide one number by another (with zero-division protection)
- **power** - Raise a number to a power
- **sqrt** - Calculate the square root of a number

### Resources

- **calculator://history** - Access recent calculation history (last 50 calculations)

## Installation

```bash
# Install dependencies
npm install

# Build the server
npm run build
```

## Usage

### As a Standalone Server

```bash
node build/index.js
```

### With Bob (MCP Configuration)

Add to your MCP settings file (`C:\Users\VigneshB\.bob\settings\mcp_settings.json`):

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

## Testing

### Test Addition

```
Ask Bob (in Experimental mode): "Use the calculator to add 15 and 27"
Expected: 15 + 27 = 42
```

### Test Division

```
Ask Bob: "Use the calculator to divide 144 by 12"
Expected: 144 ÷ 12 = 12
```

### Test Power

```
Ask Bob: "Use the calculator to calculate 2 to the power of 8"
Expected: 2^8 = 256
```

### Test Square Root

```
Ask Bob: "Use the calculator to find the square root of 81"
Expected: √81 = 9
```

### View History

```
Ask Bob: "Show me the calculator history resource"
Expected: JSON with recent calculations
```

## Error Handling

The server handles common errors:

- **Division by zero**: Returns error message
- **Negative square root**: Returns error message
- **Invalid operations**: Returns error message

## Development

### Watch Mode

```bash
npm run watch
```

### Project Structure

```
calculator-server/
├── src/
│   └── index.ts          # Main server implementation
├── build/                # Compiled JavaScript (generated)
├── package.json          # Dependencies and scripts
├── tsconfig.json         # TypeScript configuration
└── README.md            # This file
```

## Implementation Details

- Built with `@modelcontextprotocol/sdk`
- Uses stdio transport for communication
- Maintains calculation history (last 50 operations)
- Implements both tools and resources
- Includes comprehensive error handling

## License

MIT