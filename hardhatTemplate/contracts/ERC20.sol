
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    address public owner;
    mapping(address => bool) public whitelist;

    constructor() ERC20("MyToken", "MTK") {
        owner = msg.sender;
        _mint(address(this), 10);
    }

    // Implement the transfer function.
    function transferTokens(address recipient, uint256 amount) public {
        _transfer(msg.sender, recipient, amount);
    }

    // Implement the burnFrom function.
    function burnFrom(address account, uint256 amount) public {
        require(msg.sender == owner, "Only the contract owner can burn tokens from any account.");
        _burn(account, amount);
    }

    // Implement the addToWhitelist function.
    function addToWhitelist(address account) public {
        require(msg.sender == owner, "Only the contract owner can add to the whitelist.");
        whitelist[account] = true;
    }

    // Implement the withdrawToken function.
    function withdrawToken() public {
        require(whitelist[msg.sender], "You must be whitelisted to withdraw a token.");
        _transfer(address(this), msg.sender, 1);
    }
}