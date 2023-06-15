import { HardhatUserConfig } from 'hardhat/types';
import '@nomiclabs/hardhat-ethers';
import 'hardhat-deploy';
import 'hardhat-deploy-ethers';
require('./tasks/decrement-counter');
require('./tasks/increment-counter');

const config: HardhatUserConfig = {
  solidity: '0.8.17',
  paths: {
    artifacts: './artifacts',
    deploy: './deploy',
    deployments: './deployments',
  },
  networks: {
    hardhat: {
      accounts: {
        mnemonic: "test test test test test test test test test test test junk",
      },
    },
  },  namedAccounts: {
    deployer: {
      default: 0,
    },
  },
};

export default config;
