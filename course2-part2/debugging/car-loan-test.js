const { expect } = require("chai");

describe("CarLoan", function() {
    let carLoan;
    let owner;
    let borrower;

    beforeEach(async function() {
      const CarLoan = await ethers.getContractFactory("CarLoan");
      [owner, borrower, _] = await ethers.getSigners();
      carLoan = await CarLoan.connect(owner).deploy(ethers.utils.parseEther("1000000"), 5);
    });

    describe("requestLoan", function() {
        it("Should successfully request a loan", async function() {
            await carLoan.connect(borrower).requestLoan(ethers.utils.parseEther("1"), ethers.utils.parseEther("2"));
            const loan = await carLoan.loans(borrower.address);
            expect(loan.amount).to.equal(ethers.utils.parseEther("1"));
            expect(loan.interestRate).to.equal(5);
            expect(loan.collateral).to.equal(ethers.utils.parseEther("2"));
            expect(loan.approved).to.be.false;
            expect(loan.repaid).to.be.false;
        });

        it("Should not allow to request another loan before repaying the current one", async function() {
            await carLoan.connect(borrower).requestLoan(ethers.utils.parseEther("1"), ethers.utils.parseEther("2"));
            await expect(carLoan.connect(borrower).requestLoan(ethers.utils.parseEther("1"), ethers.utils.parseEther("2"))).to.be.revertedWith("Existing loan must be repaid first.");
        });
    });

    describe("approveLoan", function() {
        it("Should successfully approve a loan", async function() {
            await carLoan.connect(borrower).requestLoan(ethers.utils.parseEther("1"), ethers.utils.parseEther("2"));
            await carLoan.connect(owner).approveLoan(borrower.address);
            const loan = await carLoan.loans(borrower.address);
            expect(loan.approved).to.be.true;
        });
    });

    describe("repayLoan", function() {
        it("Should successfully repay a loan", async function() {
            await carLoan.connect(borrower).requestLoan(ethers.utils.parseEther("1"), ethers.utils.parseEther("2"));
            await carLoan.connect(owner).approveLoan(borrower.address);
            await carLoan.connect(borrower).repayLoan({ value: ethers.utils.parseEther("1.05") });
            const loan = await carLoan.loans(borrower.address);
            expect(loan.repaid).to.be.true;
        });

        it("Should not allow to repay an unapproved loan", async function() {
            await carLoan.connect(borrower).requestLoan(ethers.utils.parseEther("1"), ethers.utils.parseEther("2"));
            await expect(carLoan.connect(borrower).repayLoan({ value: ethers.utils.parseEther("1.05") })).to.be.revertedWith("Loan not approved.");
        });

        it("Should not allow to repay with incorrect amount", async function() {
            await carLoan.connect(borrower).requestLoan(ethers.utils.parseEther("1"), ethers.utils.parseEther("2"));
            await carLoan.connect(owner).approveLoan(borrower.address);
            await expect(carLoan.connect(borrower).repayLoan({ value: ethers.utils.parseEther("1") })).to.be.revertedWith("Incorrect repayment amount.");
        });
    });
});
