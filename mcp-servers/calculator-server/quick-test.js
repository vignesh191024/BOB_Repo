#!/usr/bin/env node

import { spawn } from 'child_process';
import { Client } from '@modelcontextprotocol/sdk/client/index.js';
import { StdioClientTransport } from '@modelcontextprotocol/sdk/client/stdio.js';

async function testAddition() {
  console.log('🧮 Testing: Add 15 + 25 + 30\n');
  
  try {
    const client = new Client(
      {
        name: 'quick-test',
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

    // Call the add function with 15, 25, 30
    const result = await client.callTool({
      name: 'add',
      arguments: { numbers: [15, 25, 30] },
    });

    console.log('✓ Result:', result.content[0].text);
    console.log('\n✓ Calculation completed successfully!');
    
    process.exit(0);
  } catch (error) {
    console.error('✗ Error:', error.message);
    process.exit(1);
  }
}

testAddition();
