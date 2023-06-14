// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract SimpleBankSystem {
    struct Account {
        uint256 id;
        address owner;
        uint256 balance;
    }

    uint256 private accountIdCounter;
    mapping(address => Account) public accounts;

    // Modifiers
    modifier onlyAccountOwner(address owner) {
        require(msg.sender == owner, "Only the account owner can perform this action.");
        _;
    }

    function createAccount() public {
        accountIdCounter++;
        accounts[msg.sender] = Account(accountIdCounter, msg.sender, 0);
    }

    function deposit() public payable onlyAccountOwner(msg.sender) {
        accounts[msg.sender].balance += msg.value;
    }

    function withdraw(uint256 amount) public onlyAccountOwner(msg.sender) {
        require(accounts[msg.sender].balance >= amount, "Insufficient balance.");
        accounts[msg.sender].balance -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getBalance() public view onlyAccountOwner(msg.sender) returns (uint256) {
        return accounts[msg.sender].balance;
    }
}
