import { DeployFunction } from 'hardhat-deploy/types';

const deploy: DeployFunction = async ({ deployments, getNamedAccounts }) => {
    const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  await deploy('MyToken', {
    from: deployer,
    args: [],
    log: true,
  });
};

deploy.tags = ['MyToken'];
export default deploy;
