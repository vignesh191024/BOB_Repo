#!/usr/bin/env node

import { Client } from '@modelcontextprotocol/sdk/client/index.js';
import { StdioClientTransport } from '@modelcontextprotocol/sdk/client/stdio.js';

async function chainedCalculation() {
  console.log('🧮 Testing: 2^10, then √(result)\n');
  
  try {
    const client = new Client(
      {
        name: 'chain-test',
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

    // Step 1: Calculate 2^10
    console.log('Step 1: Calculate 2^10');
    const powerResult = await client.callTool({
      name: 'power',
      arguments: { base: 2, exponent: 10 },
    });
    console.log('  ✓', powerResult.content[0].text);

    // Extract the result (1024) from "2^10 = 1024"
    const resultMatch = powerResult.content[0].text.match(/= (\d+)/);
    const powerValue = parseInt(resultMatch[1]);
    
    // Step 2: Calculate √(result)
    console.log('\nStep 2: Calculate √(' + powerValue + ')');
    const sqrtResult = await client.callTool({
      name: 'sqrt',
      arguments: { number: powerValue },
    });
    console.log('  ✓', sqrtResult.content[0].text);
    
    console.log('\n✓ Chained calculation completed successfully!');
    
    process.exit(0);
  } catch (error) {
    console.error('✗ Error:', error.message);
    process.exit(1);
  }
}

chainedCalculation();
