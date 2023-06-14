// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract SimpleBankSystem {
    struct Account {
        uint256 id;
        address owner;
        uint256 balance;
    }

    mapping(address => Account) public accounts;

    // Modifiers
    modifier onlyAccountOwner(address owner) {
        // TODO
        _;
    }

    // TODO: Implement the createAccount function

    // TODO: Implement the deposit function

    // TODO: Implement the withdraw function

    // TODO: Implement the getBalance function
}
