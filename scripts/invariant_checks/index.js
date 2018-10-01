#!/usr/bin/env node

const Client = require('kubernetes-client').Client;
const config = require('kubernetes-client').config;
const program = require('commander');
const chalk = require('chalk');

const client = new Client({ config: config.fromKubeconfig() });

const package = require('./package.json')
const checks = require('./checks')


program
  .version(package.version)
  .option('--all', 'Run all checks [default]')
  .option('-f, --fix', 'autofix any failed checks')
  .parse(process.argv);

async function main() {
  try {
    await client.loadSpec();
    Object.entries(checks).forEach(async ([key, val]) => {
      console.log(`🔎 starting check: ${key}`);
      let passed = await val.check(client);
      console.log(`▶ ${key}: \t${passed ? chalk.green('✅ PASS') : chalk.red('❎ FAIL')}`)
      if (program.fix && !passed && val.fix) {
        console.log(`🛠 FIXING: ${key}`)
        val.fix(client);
      }
    });


  } catch (ex) {
    console.log(ex)
  }
}

main()
