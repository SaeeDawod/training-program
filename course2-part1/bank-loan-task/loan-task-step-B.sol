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
    }

    mapping(address => Account) public accounts;
    mapping(uint256 => Loan) public loans;

    // Modifiers
    modifier onlyAccountOwner(address owner) {
        // Implement Step A
        _;
    }

    // Account management functions
    // Implement Step A

    // Loan management functions
    function createLoan(uint256 amount) public onlyAccountOwner(msg.sender) {
        // TODO
    }

    function repayLoan(uint256 loanId, uint256 amount) public onlyAccountOwner(accounts[loans[loanId].accountId].owner) {
        // TODO
    }

    function getOutstandingBalance(uint256 loanId) public view returns (uint256) {
        // TODO
    }
}
