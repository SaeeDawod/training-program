import { DeployFunction } from 'hardhat-deploy/types';

const deploy: DeployFunction = async ({ deployments, getNamedAccounts }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  await deploy('NFT_Collection', {
    from: deployer,
    args: ['NFT Collection', 'NFT'],
    log: true,
  });
};

deploy.tags = ['NFT_Collection'];
export default deploy;
