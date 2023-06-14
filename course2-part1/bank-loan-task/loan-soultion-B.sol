// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract SimpleBankSystem {
    struct Account {
        uint256 id;
        address owner;
        uint256 balance;
    }

    struct Loan {
        uint256 id;
        uint256 accountId;
        uint256 amount;
        uint256 outstandingBalance;
        address owner; 
    }

    uint256 private accountIdCounter;
    uint256 private loanIdCounter;
    mapping(address => Account) public accounts;
    mapping(uint256 => Loan) public loans;

    // Modifiers
    modifier onlyAccountOwner(address owner) {
        require(msg.sender == owner, "Only the account owner can perform this action.");
        _;
    }

    // Account management functions
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

    // Loan management functions
  function createLoan(uint256 amount) public onlyAccountOwner(msg.sender) {
        require(accounts[msg.sender].balance >= amount, "Insufficient balance.");
        loanIdCounter++;
        loans[loanIdCounter] = Loan(loanIdCounter, accounts[msg.sender].id, amount, amount, msg.sender);
        accounts[msg.sender].balance -= amount;
    }


function repayLoan(uint256 loanId, uint256 amount) public onlyAccountOwner(accounts[loans[loanId].owner].owner) {
    require(accounts[msg.sender].balance >= amount, "Insufficient balance.");
    require(loans[loanId].outstandingBalance >= amount, "Loan amount is less than amount to repay.");
    loans[loanId].outstandingBalance -= amount;
    accounts[msg.sender].balance -= amount;
}


    function getOutstandingBalance(uint256 loanId) public view returns (uint256) {
        return loans[loanId].outstandingBalance;
    }
}
