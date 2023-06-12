// contracts/MyToken.sol

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") {
        // Mint the initial supply to msg.sender.
        _mint(msg.sender, initialSupply);
    }

    // Implement the transfer function.
    // This function allows a user to transfer a specified amount of tokens to another user.
    function transferTokens(address recipient, uint256 amount) public {
        _transfer(msg.sender, recipient, amount);
    }

    // Implement the burn function.
    // This function allows a user to burn (destroy) a specified amount of their own tokens.
    function burnTokens(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Implement the burnFrom function.
    // This function allows an approved spender to burn a specified amount of tokens on behalf of the token owner.
    function burnFromTokens(address account, uint256 amount) public {
        require(msg.sender == account || allowance(account, msg.sender) >= amount, "ERC20: burn amount exceeds allowance");
        _burn(account, amount);
    }
}
