#!/usr/bin/env node

/**
 * Simple test client for Calculator MCP Server
 * Tests all calculator operations and validates responses
 */

import { spawn } from 'child_process';
import { Client } from '@modelcontextprotocol/sdk/client/index.js';
import { StdioClientTransport } from '@modelcontextprotocol/sdk/client/stdio.js';

// ANSI color codes for output
const colors = {
  reset: '\x1b[0m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  cyan: '\x1b[36m',
};

function log(message, color = 'reset') {
  console.log(`${colors[color]}${message}${colors.reset}`);
}

function logTest(testName, status, details = '') {
  const symbol = status === 'PASS' ? '✓' : status === 'FAIL' ? '✗' : '○';
  const color = status === 'PASS' ? 'green' : status === 'FAIL' ? 'red' : 'yellow';
  log(`${symbol} ${testName}`, color);
  if (details) {
    console.log(`  ${details}`);
  }
}

async function runTests() {
  log('\n=== Calculator MCP Server Test Suite ===\n', 'cyan');
  
  let passCount = 0;
  let failCount = 0;
  
  try {
    // Create client and connect
    log('Starting calculator server...', 'blue');
    const client = new Client(
      {
        name: 'test-client',
        version: '1.0.0',
      },
      {
        capabilities: {},
      }
    );

    const transport = new StdioClientTransport({
      command: 'node',
      args: ['build/index.js'],
    });

    await client.connect(transport);
    log('Connected to server\n', 'green');

    // Test 1: Addition
    try {
      const result = await client.callTool({
        name: 'add',
        arguments: { numbers: [10, 20, 30] },
      });
      const expected = '10 + 20 + 30 = 60';
      if (result.content[0].text === expected) {
        logTest('Test 1: Addition', 'PASS', `Result: ${result.content[0].text}`);
        passCount++;
      } else {
        logTest('Test 1: Addition', 'FAIL', `Expected: ${expected}, Got: ${result.content[0].text}`);
        failCount++;
      }
    } catch (error) {
      logTest('Test 1: Addition', 'FAIL', `Error: ${error.message}`);
      failCount++;
    }

    // Test 2: Subtraction
    try {
      const result = await client.callTool({
        name: 'subtract',
        arguments: { a: 100, b: 35 },
      });
      const expected = '100 - 35 = 65';
      if (result.content[0].text === expected) {
        logTest('Test 2: Subtraction', 'PASS', `Result: ${result.content[0].text}`);
        passCount++;
      } else {
        logTest('Test 2: Subtraction', 'FAIL', `Expected: ${expected}, Got: ${result.content[0].text}`);
        failCount++;
      }
    } catch (error) {
      logTest('Test 2: Subtraction', 'FAIL', `Error: ${error.message}`);
      failCount++;
    }

    // Test 3: Multiplication
    try {
      const result = await client.callTool({
        name: 'multiply',
        arguments: { numbers: [5, 4, 3] },
      });
      const expected = '5 × 4 × 3 = 60';
      if (result.content[0].text === expected) {
        logTest('Test 3: Multiplication', 'PASS', `Result: ${result.content[0].text}`);
        passCount++;
      } else {
        logTest('Test 3: Multiplication', 'FAIL', `Expected: ${expected}, Got: ${result.content[0].text}`);
        failCount++;
      }
    } catch (error) {
      logTest('Test 3: Multiplication', 'FAIL', `Error: ${error.message}`);
      failCount++;
    }

    // Test 4: Division
    try {
      const result = await client.callTool({
        name: 'divide',
        arguments: { dividend: 100, divisor: 4 },
      });
      const expected = '100 ÷ 4 = 25';
      if (result.content[0].text === expected) {
        logTest('Test 4: Division', 'PASS', `Result: ${result.content[0].text}`);
        passCount++;
      } else {
        logTest('Test 4: Division', 'FAIL', `Expected: ${expected}, Got: ${result.content[0].text}`);
        failCount++;
      }
    } catch (error) {
      logTest('Test 4: Division', 'FAIL', `Error: ${error.message}`);
      failCount++;
    }

    // Test 5: Division by Zero (should handle gracefully)
    try {
      const result = await client.callTool({
        name: 'divide',
        arguments: { dividend: 10, divisor: 0 },
      });
      if (result.content[0].text.includes('Division by zero')) {
        logTest('Test 5: Division by Zero', 'PASS', `Error handled: ${result.content[0].text}`);
        passCount++;
      } else {
        logTest('Test 5: Division by Zero', 'FAIL', `Expected error message, got: ${result.content[0].text}`);
        failCount++;
      }
    } catch (error) {
      logTest('Test 5: Division by Zero', 'FAIL', `Unexpected error: ${error.message}`);
      failCount++;
    }

    // Test 6: Power
    try {
      const result = await client.callTool({
        name: 'power',
        arguments: { base: 2, exponent: 8 },
      });
      const expected = '2^8 = 256';
      if (result.content[0].text === expected) {
        logTest('Test 6: Power', 'PASS', `Result: ${result.content[0].text}`);
        passCount++;
      } else {
        logTest('Test 6: Power', 'FAIL', `Expected: ${expected}, Got: ${result.content[0].text}`);
        failCount++;
      }
    } catch (error) {
      logTest('Test 6: Power', 'FAIL', `Error: ${error.message}`);
      failCount++;
    }

    // Test 7: Square Root
    try {
      const result = await client.callTool({
        name: 'sqrt',
        arguments: { number: 144 },
      });
      const expected = '√144 = 12';
      if (result.content[0].text === expected) {
        logTest('Test 7: Square Root', 'PASS', `Result: ${result.content[0].text}`);
        passCount++;
      } else {
        logTest('Test 7: Square Root', 'FAIL', `Expected: ${expected}, Got: ${result.content[0].text}`);
        failCount++;
      }
    } catch (error) {
      logTest('Test 7: Square Root', 'FAIL', `Error: ${error.message}`);
      failCount++;
    }

    // Test 8: Square Root of Negative (should handle gracefully)
    try {
      const result = await client.callTool({
        name: 'sqrt',
        arguments: { number: -25 },
      });
      if (result.content[0].text.includes('negative number')) {
        logTest('Test 8: Negative Square Root', 'PASS', `Error handled: ${result.content[0].text}`);
        passCount++;
      } else {
        logTest('Test 8: Negative Square Root', 'FAIL', `Expected error message, got: ${result.content[0].text}`);
        failCount++;
      }
    } catch (error) {
      logTest('Test 8: Negative Square Root', 'FAIL', `Unexpected error: ${error.message}`);
      failCount++;
    }

    // Test 9: Calculation History Resource
    try {
      const result = await client.readResource({
        uri: 'calculator://history',
      });
      const historyData = JSON.parse(result.contents[0].text);
      if (historyData.calculations && Array.isArray(historyData.calculations)) {
        logTest('Test 9: Calculation History', 'PASS', `History contains ${historyData.total} calculations`);
        passCount++;
      } else {
        logTest('Test 9: Calculation History', 'FAIL', 'Invalid history format');
        failCount++;
      }
    } catch (error) {
      logTest('Test 9: Calculation History', 'FAIL', `Error: ${error.message}`);
      failCount++;
    }

    // Summary
    log('\n=== Test Summary ===', 'cyan');
    log(`Total Tests: ${passCount + failCount}`, 'blue');
    log(`Passed: ${passCount}`, 'green');
    log(`Failed: ${failCount}`, 'red');
    log(`Success Rate: ${((passCount / (passCount + failCount)) * 100).toFixed(1)}%\n`, 'yellow');

    // Cleanup
    await client.close();
    
    process.exit(failCount > 0 ? 1 : 0);
    
  } catch (error) {
    log(`\nFatal Error: ${error.message}`, 'red');
    console.error(error);
    process.exit(1);
  }
}

// Run tests
runTests();

// Made with Bob
