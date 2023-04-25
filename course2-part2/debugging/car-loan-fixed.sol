pragma solidity ^0.8.0;


//1. Bug 1: Updated the collateral check condition in the approveLoan function.
//2. Bug 2: Updated the interest rate calculation formula in the repayLoan function.
//3. Bug 3: Added a validation check for the requested loan amount against the maximum loan amount in the requestLoan function.


contract CarLoan {
    struct Loan {
        uint256 amount;
        uint256 interestRate;
        uint256 collateral;
        bool approved;
        bool repaid;
    }

    mapping(address => Loan) public loans;
    uint256 public maxLoanAmount = 100 ether;
    uint256 public baseInterestRate = 5;

    function requestLoan(uint256 _amount, uint256 _collateral) public {
        require(loans[msg.sender].amount == 0, "Existing loan must be repaid first.");
        require(_amount <= maxLoanAmount, "Loan amount exceeds the maximum limit."); // Fix for Bug 3
        loans[msg.sender] = Loan(_amount, baseInterestRate, _collateral, false, false);
    }

    function approveLoan(address _borrower) public {
        Loan storage loan = loans[_borrower];
        require(loan.amount > 0, "Loan request not found.");
        require(loan.collateral > loan.amount * (100 + loan.interestRate) / 100, "Insufficient collateral."); // Fix for Bug 1
        loan.approved = true;
    }

      function repayLoan() public payable {
        Loan storage loan = loans[msg.sender];
        require(loan.approved, "Loan not approved.");
        uint256 repaymentAmount = loan.amount * (100 + loan.interestRate) / 100; // Fix for Bug 2
        require(msg.value == repaymentAmount, "Incorrect repayment amount.");
        loan.repaid = true;
    }
}
