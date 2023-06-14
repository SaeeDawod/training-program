const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  const HardHatDemo = await ethers.getContractFactory("contract name");
  const contract = await HardHatDemo.connect(deployer).deploy(args amount);

  console.log(contract);
  

  await contract.decrease();

  console.log("New count:", (await contract.counter()).toString());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
