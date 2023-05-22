pragma solidity ^0.8.0;

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
        loans[msg.sender] = Loan(_amount, baseInterestRate, _collateral, false, false);
    }

    function approveLoan(address _borrower) public {
        Loan storage loan = loans[_borrower];
        require(loan.amount > 0, "Loan request not found.");
        require(loan.collateral > loan.amount * 2, "Insufficient collateral."); // Introduced Bug 1: Incorrect collateral check
        loan.approved = true;
    }

    function repayLoan() public payable {
        Loan storage loan = loans[msg.sender];
        require(loan.approved, "Loan not approved.");
        uint256 repaymentAmount = loan.amount * loan.interestRate / 100; // Introduced Bug 2: Incorrect interest rate calculation
        require(msg.value == repaymentAmount, "Incorrect repayment amount.");
        loan.repaid = true;
    }
}
