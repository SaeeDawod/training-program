import { task, types } from 'hardhat/config';

// tasks/decrement-counter.js
task("decrement-counter", "Decrements the counter in the HardHatDemo contract")
  .setAction(async (taskArgs, hre) => {
    const { ethers } = hre;
    const HardHatDemo = await ethers.getContractFactory("HardHatDemo");
    const hardHatDemo = await HardHatDemo.deploy(10);

    await hardHatDemo.deployed();

    await hardHatDemo.decrease();

    const counterValue = await hardHatDemo.counter();
    console.log("Updated counter value:", counterValue.toString());
  });
