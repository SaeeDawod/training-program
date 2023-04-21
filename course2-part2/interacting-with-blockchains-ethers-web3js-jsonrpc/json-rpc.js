//transaction using json rpc
const url = 'https://mainnet.infura.io/v3/YOUR-PROJECT-ID';
const headers = { 'Content-Type': 'application/json' };

const contractAddress = '0xYourContractAddress';
const fromAddress = '0xYourAddress';
const functionSignature = '0x6d4ce63c'; // This is the 4-byte function signature for the `get()` function

const payload = {
  jsonrpc: '2.0',
  id: 1,
  method: 'eth_call',
  params: [
    {
      to: contractAddress,
      from: fromAddress,
      data: functionSignature
    },
    'latest'
  ]
};

fetch(url, {
  method: 'POST',
  headers: headers,
  body: JSON.stringify(payload)
})
  .then((response) => response.json())
  .then((data) => {
    const result = parseInt(data.result, 16);
    console.log('Result:', result);
  })
  .catch((error) => console.error('Error:', error));


//interacting with contract is a little bit more complicated.

//  1.Get the canonical form of the function: helloWorld()
//  2.Compute the Keccak-256 hash of the canonical form.
//  3.Take the first 4 bytes of the hash as the function signature.


const functionName = 'helloWorld()';
const functionHash = web3.utils.keccak256(functionName);
const functionSignature = functionHash.slice(0, 10); // First 4 bytes, equivalent to 8 characters in the hexadecimal representation

const url = 'https://mainnet.infura.io/v3/YOUR-PROJECT-ID';
const headers = { 'Content-Type': 'application/json' };

const contractAddress = '0xYourContractAddress';
const fromAddress = '0xYourAddress';
const functionSignature = '0x6d4ce63c'; // This is the 4-byte function signature for the `get()` function

const payload = {
  jsonrpc: '2.0',
  id: 1,
  method: 'eth_call',
  params: [
    {
      to: contractAddress,
      from: fromAddress,
      data: functionSignature
    },
    'latest'
  ]
};

fetch(url, {
  method: 'POST',
  headers: headers,
  body: JSON.stringify(payload)
})
  .then((response) => response.json())
  .then((data) => {
    const result = parseInt(data.result, 16);
    console.log('Result:', result);
  })
  .catch((error) => console.error('Error:', error));