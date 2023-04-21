//transaction using web3.js

import Web3 from 'web3';

const web3 = new Web3('https://mainnet.infura.io/v3/YOUR-PROJECT-ID');
const accounts = await web3.eth.getAccounts();
const transaction = {
  from: accounts[0],
  to: '0x742d35Cc6634C0532925a3b844Bc454e4438f44e',
  value: web3.utils.toWei('0.1', 'ether')
};
const tx = await web3.eth.sendTransaction(transaction);
console.log('Transaction Hash:', tx.transactionHash);


//interacting with contract using web3 js 

import Web3 from 'web3';
import contractABI from './contractABI.json';

const web3 = new Web3('https://mainnet.infura.io/v3/YOUR-PROJECT-ID');
const contractAddress = '0x9c02a4000b8Feb2b48D896B0DA64456b9B3a676D';
const contract = new web3.eth.Contract(contractABI, contractAddress);

const result = await contract.methods.someFunction(args).call();
