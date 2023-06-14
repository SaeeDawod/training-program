// deploy/01_deploy_hardhat_demo.js
const { deploy } = require("hardhat-deploy");

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deployer } = await getNamedAccounts();
  const { deploy } = deployments;

  await deploy("HardHatDemo", {
    from: deployer,
    args: [10], // Specify the initial counter value here
    log: true,
  });
};

module.exports.tags = ["HardHatDemo"];
