import { DeployFunction } from 'hardhat-deploy/types';

const deploy: DeployFunction = async ({ deployments, getNamedAccounts }) => {
    const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  await deploy('HardHatDemo', {
    from: deployer,
    args: [10],
    log: true,
  });
};

deploy.tags = ['HardHatDemo'];
export default deploy;
