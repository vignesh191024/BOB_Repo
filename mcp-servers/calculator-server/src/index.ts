#!/usr/bin/env node

/**
 * Calculator MCP Server
 * A simple MCP server providing basic arithmetic operations for Bob Sandbox testing
 */

import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
  ListResourcesRequestSchema,
  ReadResourceRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";

// Calculation history storage
interface CalculationRecord {
  operation: string;
  operands: number[];
  result: number;
  timestamp: string;
}

const calculationHistory: CalculationRecord[] = [];
const MAX_HISTORY = 50;

// Helper function to add to history
function addToHistory(operation: string, operands: number[], result: number): void {
  calculationHistory.unshift({
    operation,
    operands,
    result,
    timestamp: new Date().toISOString(),
  });
  
  // Keep only last MAX_HISTORY entries
  if (calculationHistory.length > MAX_HISTORY) {
    calculationHistory.pop();
  }
}

// Create server instance
const server = new Server(
  {
    name: "calculator-server",
    version: "0.1.0",
  },
  {
    capabilities: {
      tools: {},
      resources: {},
    },
  }
);

// List available tools
server.setRequestHandler(ListToolsRequestSchema, async () => {
  return {
    tools: [
      {
        name: "add",
        description: "Add two or more numbers together",
        inputSchema: {
          type: "object",
          properties: {
            numbers: {
              type: "array",
              items: { type: "number" },
              description: "Array of numbers to add",
              minItems: 2,
            },
          },
          required: ["numbers"],
        },
      },
      {
        name: "subtract",
        description: "Subtract the second number from the first",
        inputSchema: {
          type: "object",
          properties: {
            a: {
              type: "number",
              description: "The number to subtract from",
            },
            b: {
              type: "number",
              description: "The number to subtract",
            },
          },
          required: ["a", "b"],
        },
      },
      {
        name: "multiply",
        description: "Multiply two or more numbers together",
        inputSchema: {
          type: "object",
          properties: {
            numbers: {
              type: "array",
              items: { type: "number" },
              description: "Array of numbers to multiply",
              minItems: 2,
            },
          },
          required: ["numbers"],
        },
      },
      {
        name: "divide",
        description: "Divide the first number by the second",
        inputSchema: {
          type: "object",
          properties: {
            dividend: {
              type: "number",
              description: "The number to be divided",
            },
            divisor: {
              type: "number",
              description: "The number to divide by",
            },
          },
          required: ["dividend", "divisor"],
        },
      },
      {
        name: "power",
        description: "Raise a number to a power",
        inputSchema: {
          type: "object",
          properties: {
            base: {
              type: "number",
              description: "The base number",
            },
            exponent: {
              type: "number",
              description: "The exponent",
            },
          },
          required: ["base", "exponent"],
        },
      },
      {
        name: "sqrt",
        description: "Calculate the square root of a number",
        inputSchema: {
          type: "object",
          properties: {
            number: {
              type: "number",
              description: "The number to find the square root of",
              minimum: 0,
            },
          },
          required: ["number"],
        },
      },
    ],
  };
});

// Handle tool calls
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;

  try {
    switch (name) {
      case "add": {
        if (!args || !args.numbers) {
          throw new Error("Missing required argument: numbers");
        }
        const numbers = args.numbers as number[];
        const result = numbers.reduce((sum, num) => sum + num, 0);
        addToHistory("add", numbers, result);
        
        return {
          content: [
            {
              type: "text",
              text: `${numbers.join(" + ")} = ${result}`,
            },
          ],
        };
      }

      case "subtract": {
        const { a, b } = args as { a: number; b: number };
        const result = a - b;
        addToHistory("subtract", [a, b], result);
        
        return {
          content: [
            {
              type: "text",
              text: `${a} - ${b} = ${result}`,
            },
          ],
        };
      }

      case "multiply": {
        if (!args || !args.numbers) {
          throw new Error("Missing required argument: numbers");
        }
        const numbers = args.numbers as number[];
        const result = numbers.reduce((product, num) => product * num, 1);
        addToHistory("multiply", numbers, result);
        
        return {
          content: [
            {
              type: "text",
              text: `${numbers.join(" × ")} = ${result}`,
            },
          ],
        };
      }

      case "divide": {
        const { dividend, divisor } = args as { dividend: number; divisor: number };
        
        if (divisor === 0) {
          return {
            content: [
              {
                type: "text",
                text: "Error: Division by zero is not allowed",
              },
            ],
            isError: true,
          };
        }
        
        const result = dividend / divisor;
        addToHistory("divide", [dividend, divisor], result);
        
        return {
          content: [
            {
              type: "text",
              text: `${dividend} ÷ ${divisor} = ${result}`,
            },
          ],
        };
      }

      case "power": {
        const { base, exponent } = args as { base: number; exponent: number };
        const result = Math.pow(base, exponent);
        addToHistory("power", [base, exponent], result);
        
        return {
          content: [
            {
              type: "text",
              text: `${base}^${exponent} = ${result}`,
            },
          ],
        };
      }

      case "sqrt": {
        const { number } = args as { number: number };
        
        if (number < 0) {
          return {
            content: [
              {
                type: "text",
                text: "Error: Cannot calculate square root of negative number",
              },
            ],
            isError: true,
          };
        }
        
        const result = Math.sqrt(number);
        addToHistory("sqrt", [number], result);
        
        return {
          content: [
            {
              type: "text",
              text: `√${number} = ${result}`,
            },
          ],
        };
      }

      default:
        return {
          content: [
            {
              type: "text",
              text: `Unknown tool: ${name}`,
            },
          ],
          isError: true,
        };
    }
  } catch (error) {
    return {
      content: [
        {
          type: "text",
          text: `Error executing ${name}: ${error}`,
        },
      ],
      isError: true,
    };
  }
});

// List available resources
server.setRequestHandler(ListResourcesRequestSchema, async () => {
  return {
    resources: [
      {
        uri: "calculator://history",
        name: "Calculation History",
        description: "Recent calculation history",
        mimeType: "application/json",
      },
    ],
  };
});

// Read resources
server.setRequestHandler(ReadResourceRequestSchema, async (request) => {
  const { uri } = request.params;

  if (uri === "calculator://history") {
    return {
      contents: [
        {
          uri,
          mimeType: "application/json",
          text: JSON.stringify(
            {
              total: calculationHistory.length,
              calculations: calculationHistory,
            },
            null,
            2
          ),
        },
      ],
    };
  }

  throw new Error(`Unknown resource: ${uri}`);
});

// Start the server
async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  console.error("Calculator MCP server running on stdio");
}

main().catch((error) => {
  console.error("Fatal error:", error);
  process.exit(1);
});

// Made with Bob
