// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract BankSystem {
    // Account Types
    enum AccountType { Savings, Current }

    // Account Struct
    struct Account {
        uint256 id;
        address owner;
        AccountType accountType;
        uint256 balance;
    }

    // Loan Struct
    struct Loan {
        uint256 id;
        uint256 accountId;
        uint256 amount;
        uint256 interestRate; // Interest rate in basis points (1 basis point = 0.01%)
        uint256 term; // Loan term in months
        uint256 remainingTerm;
        uint256 outstandingBalance;
    }

    // Mappings
    mapping(uint256 => Account) public accounts;
    mapping(uint256 => Loan) public loans;
    mapping(address => uint256) public accountOwners;

    // Interest rates for different account types
    uint256 public savingsInterestRate = 200; // 2% per annum
    uint256 public currentInterestRate = 100; // 1% per annum

    // Counters for account and loan IDs
    uint256 private accountIdCounter;
    uint256 private loanIdCounter;

    // Events
    event AccountCreated(uint256 accountId, address owner, AccountType accountType);
    event LoanCreated(uint256 loanId, uint256 accountId, uint256 amount, uint256 interestRate, uint256 term);
    event Deposit(uint256 accountId, uint256 amount);
    event Withdrawal(uint256 accountId, uint256 amount);

    // Modifiers
    modifier onlyAccountOwner(uint256 accountId) {
        require(msg.sender == accounts[accountId].owner, "Only the account owner can perform this action.");
        _;
    }

    // Account management functions
    function createAccount(AccountType accountType) public {
        accountIdCounter++;
        accounts[accountIdCounter] = Account(accountIdCounter, msg.sender, accountType, 0);
        accountOwners[msg.sender] = accountIdCounter;

        emit AccountCreated(accountIdCounter, msg.sender, accountType);
    }

    function deposit(uint256 accountId) public payable onlyAccountOwner(accountId) {
        accounts[accountId].balance += msg.value;
        emit Deposit(accountId, msg.value);
    }

    function withdraw(uint256 accountId, uint256 amount) public onlyAccountOwner(accountId) {
        require(accounts[accountId].balance >= amount, "Insufficient balance.");
        accounts[accountId].balance -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(accountId, amount);
    }

    function getAccountBalance(uint256 accountId) public view onlyAccountOwner(accountId) returns (uint256) {
        return accounts[accountId].balance;
    }

    // Loan management functions
    function createLoan(uint256 accountId, uint256 amount, uint256 interestRate, uint256 term) public onlyAccountOwner(accountId) {
        require(accounts[accountId].balance >= amount, "Insufficient balance for collateral.");
        loanIdCounter++;
        loans[loanIdCounter] = Loan(loanIdCounter, accountId, amount, interestRate, term, term, amount);

        emit LoanCreated(loanIdCounter, accountId, amount, interestRate, term);
    }

    function getLoanOutstandingBalance(uint256 loanId) public view returns (uint256) {
        return loans[loanId].outstandingBalance;
    }

    // This is just a simplified example of loan repayment. You would need to implement a more robust repayment mechanism.
    function repayLoan(uint256 loanId, uint256 amount) public onlyAccountOwner(loans[loanId].accountId) {
        Loan storage loan = loans[loanId];
        require(loan.outstandingBalance >= amount, "Repayment amount is greater than outstanding balance.");
        require(accounts[loan.accountId].balance >= amount, "Insufficient account balance for loan repayment.");

        // Update the loan's outstanding balance and remaining term
        loan.outstandingBalance -= amount;
        loan.remainingTerm--;

        // Transfer the repayment amount from the account balance
        accounts[loan.accountId].balance -= amount;

        // Implement a more robust repayment mechanism here, e.g. interest calculation, fees, etc.
    }

    // Interest calculation and crediting (simplified example)
    function creditInterest(uint256 accountId) public onlyAccountOwner(accountId) {
        Account storage account = accounts[accountId];

        uint256 interestRate;
        if (account.accountType == AccountType.Savings) {
            interestRate = savingsInterestRate;
        } else if (account.accountType == AccountType.Current) {
            interestRate = currentInterestRate;
        }

        // Calculate interest (assuming simple annual interest, divided by 12 for monthly interest)
        uint256 interest = (account.balance * interestRate) / (10000 * 12);

        // Credit interest to account
        account.balance += interest;
    }

    // Additional features such as updating interest rates, bank fees, and bank policies can be implemented here.
}
