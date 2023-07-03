//sending transaction with ethers
import { JsonRpcProvider, utils } from 'ethers';

const provider = new JsonRpcProvider('https://settlemint.com-url/api-key');
const signer = provider.getSigner();
const transaction = {
  to: '0x742d35Cc6634C0532925a3b844Bc454e4438f44e',
  value: utils.parseEther('0.1')
};
const tx = await signer.sendTransaction(transaction);
console.log('Transaction Hash:', tx.hash);

//contract interaction 
import { JsonRpcProvider, Contract } from 'ethers';
import contractABI from './contractABI.json';

const provider = new JsonRpcProvider('https://settlemint.com-url/api-key');
const contractAddress = '0x9c02a4000b8Feb2b48D896B0DA64456b9B3a676D';
const contract = new Contract(contractAddress, contractABI, provider.getSigner());

const result = await contract.someFunction(args);


