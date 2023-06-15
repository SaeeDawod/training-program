import { task, types } from 'hardhat/config';

// tasks/increment-counter.js
task("increment-counter", "Increments the counter in the HardHatDemo contract")
  .setAction(async (taskArgs, hre) => {
    const { ethers } = hre;
    const HardHatDemo = await ethers.getContractFactory("HardHatDemo");
    const hardHatDemo = await HardHatDemo.deploy(10);

    await hardHatDemo.deployed();

    await hardHatDemo.add();

    const counterValue = await hardHatDemo.counter();
    console.log("Updated counter value:", counterValue.toString());
  });
