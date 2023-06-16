import { ethers } from "hardhat";
import { Contract, Signer, ContractFactory } from "ethers";
import { expect } from "chai";

describe("HardHatDemo Contract", function() {
  let HardHatDemoContractFactory: ContractFactory;
  let hardHatDemoContractInstance: Contract;
  let owner: Signer;

  beforeEach(async function() {
    [owner] = await ethers.getSigners();
    HardHatDemoContractFactory = await ethers.getContractFactory("HardHatDemo");
    hardHatDemoContractInstance = await HardHatDemoContractFactory.deploy(0);
    await hardHatDemoContractInstance.deployed();
  });

  it("Should initialize counter correctly", async function() {
    expect((await hardHatDemoContractInstance.counter()).toNumber()).to.equal(0);
  });

  it("Should increment the counter", async function() {
    await hardHatDemoContractInstance.connect(owner).add();
    expect((await hardHatDemoContractInstance.counter()).toNumber()).to.equal(1);
  });

  it("Should decrement the counter", async function() {
    await hardHatDemoContractInstance.connect(owner).add();
    await hardHatDemoContractInstance.connect(owner).decrease();
    expect((await hardHatDemoContractInstance.counter()).toNumber()).to.equal(0);
  });
});
