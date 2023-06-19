import { ethers } from "hardhat";
import chai from "chai";
import { solidity } from "ethereum-waffle";
import { CarRental } from "../typechain/CarRental";

chai.use(solidity);
const { expect } = chai;

describe("Car Rental", function () {
  let carRental: CarRental;

  beforeEach(async function () {
    // Deploying contract before each test
    const CarRentalFactory = await ethers.getContractFactory("CarRental");
    carRental = (await CarRentalFactory.deploy()) as CarRental;
    await carRental.deployed();
  });

  it("Should add a new car", async function () {
    await carRental.addCar("Test Car", ethers.utils.parseEther("1"));
    const car = await carRental.cars(0);
    expect(car.name).to.equal("Test Car");
    expect(car.deposit).to.equal(ethers.utils.parseEther("1"));
    expect(car.rented).to.equal(false);
  });

  it("Should rent a car", async function () {
    await carRental.addCar("Test Car", ethers.utils.parseEther("1"));
    await carRental.rentCar(0, 86400, { value: ethers.utils.parseEther("1") }); // Renting for 1 day
    const car = await carRental.cars(0);
    expect(car.rented).to.equal(true);
  });

  it("Should return a car", async function () {
    await carRental.addCar("Test Car", ethers.utils.parseEther("1"));
    await carRental.rentCar(0, 86400, { value: ethers.utils.parseEther("1") }); // Renting for 1 day
    await carRental.returnCar({ value: ethers.utils.parseEther("0") }); // No delay, so no penalty
    const car = await carRental.cars(0);
    expect(car.rented).to.equal(false);
  });
});
