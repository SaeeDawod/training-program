// contracts/MyToken.sol

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") {
        // TO DO: Mint the initial supply to msg.sender.
        // Hint: Use the _mint() function provided by the ERC20 contract.
        // The _mint() function requires two parameters: the recipient of the tokens and the amount.
    }

    // TO DO: Implement the transfer function.
    // This function should allow a user to transfer a specified amount of tokens to another user.
    // Hint: Use the _transfer() function provided by the ERC20 contract.
    // The _transfer() function requires three parameters: the sender, the recipient, and the amount.
    function transferTokens(address recipient, uint256 amount) public {
        // your code here
    }

    // TO DO: Implement the burn function.
    // This function should allow a user to burn (destroy) a specified amount of their own tokens.
    // Hint: Use the _burn() function provided by the ERC20 contract.
    // The _burn() function requires two parameters: the burner's address and the amount to burn.
    function burnTokens(uint256 amount) public {
        // your code here
    }

    // TO DO: Implement the burnFrom function.
    // This function should allow an approved spender to burn a specified amount of tokens on behalf of the token owner.
    // Hint: Use the _burn() function provided by the ERC20 contract.
    // The _burn() function requires two parameters: the owner's address and the amount to burn.
    function burnFromTokens(address account, uint256 amount) public {
        // your code here
    }
}
