// contracts/MyToken.sol

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    address public owner;
    mapping(address => bool) public whitelist;

    constructor() ERC20("MyToken", "MTK") {
        owner = msg.sender;
        // TO DO: Mint 10 tokens to this contract.
    }

    // TO DO: Implement the transfer function.

    // TO DO: Implement the burnFrom function.

    // TO DO: Implement the addToWhitelist function.

    // TO DO: Implement the withdrawToken function.
}
