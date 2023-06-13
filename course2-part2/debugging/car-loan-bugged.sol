pragma solidity ^0.8.0;

contract CarLoan {
    struct Loan {
        uint256 amount;
        uint256 interestRate;
        string collateral; // BUG 1: Wrong type for collateral, should be uint256
        bool approved;
        bool repaid;
    }

    mapping(address => Loan) public loans;
    uint256 public maxLoanAmount;
    uint256 public baseInterestRate;
    address public owner;
    bool public stopped = false;

    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner can call this function.");
        _;
    }

    modifier stopInEmergency { 
        require(!stopped, "The contract is currently stopped."); 
        _; 
    }

    constructor(uint256 _maxLoanAmount, uint256 _baseInterestRate) {
        maxLoanAmount = _maxLoanAmount;
        baseInterestRate = _baseInterestRate;
        owner = msg.sender; // The contract deployer becomes the owner.
    }

    function toggleContractActive() public onlyOwner { // Circuit breaker pattern for emergency stop
        stopped = !stopped;
    }

    function requestLoan(string memory _amount, uint256 _collateral) public stopInEmergency { // BUG 2: _amount should be uint256, not string
        require(loans[msg.sender].amount == 0, "Existing loan must be repaid first.");
        loans[msg.sender] = Loan(_amount, baseInterestRate, _collateral, false, false); // Bug 3: _amount should be uint256
    }

    function approveLoan(address _borrower) internal { // BUG 4: Changed visibility to internal
        Loan storage loan = loans[_borrower];
        require(loan.amount > 0, "Loan request not found.");
        require(uint256(keccak256(abi.encodePacked(loan.collateral))) > loan.amount * 2, "Insufficient collateral."); // Bug 5: Collateral is now a string, this doesn't make sense
        loan.approved = true;
    }

    function repayLoan() public payable stopInEmergency {
        Loan storage loan = loans[msg.value]; // BUG 6: Should be msg.sender, not msg.value
        require(loan.approved, "Loan not approved.");
        uint256 repaymentAmount = loan.amount + loan.interestRate; // BUG 7: Incorrect calculation of interest
        require(msg.value == repaymentAmount, "Incorrect repayment amount.");
        loan.repaid = true;
    }

    function drain() public onlyOwner { // BUG 8: This function allows the owner to withdraw all Ether from the contract, which can be an exploit if owner is malicious
        payable(owner).transfer(address(this).balance);
    }
}
