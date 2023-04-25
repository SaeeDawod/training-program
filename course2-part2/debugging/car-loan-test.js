const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("CarLoan", function () {
  let CarLoan;
  let carLoan;
  let owner, borrower, addr1, addr2;

  beforeEach(async function () {
    CarLoan = await ethers.getContractFactory("CarLoan");
    [owner, borrower, addr1, addr2] = await ethers.getSigners();
    carLoan = await CarLoan.deploy();
  });

  it("Should request, approve, and repay a loan successfully", async function () {
    const loanAmount = ethers.utils.parseEther("10");
    const collateral = ethers.utils.parseEther("15");

    // Request a loan
    await carLoan.connect(borrower).requestLoan(loanAmount, collateral);
    const requestedLoan = await carLoan.loans(borrower.address);
    expect(requestedLoan.amount).to.equal(loanAmount);
    expect(requestedLoan.collateral).to.equal(collateral);
    expect(requestedLoan.approved).to.equal(false);

    // Approve the loan
    await carLoan.connect(owner).approveLoan(borrower.address);
    const approvedLoan = await carLoan.loans(borrower.address);
    expect(approvedLoan.approved).to.equal(true);

    // Repay the loan
    const repaymentAmount = loanAmount.add(loanAmount.mul(requestedLoan.interestRate).div(100));
    await carLoan.connect(borrower).repayLoan({ value: repaymentAmount });
    const repaidLoan = await carLoan.loans(borrower.address);
    expect(repaidLoan.repaid).to.equal(true);
  });
});
