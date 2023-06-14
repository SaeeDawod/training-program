import { DeployFunction } from 'hardhat-deploy/types';

const deploy: DeployFunction = async ({ deployments, getNamedAccounts }) => {
    const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  await deploy('TicTacToe', {
    from: deployer,
    args: ['0x70997970C51812dc3A010C7d01b50e0d17dc79C8'],
    log: true,
  });
};

deploy.tags = ['TicTacToe'];
export default deploy;
