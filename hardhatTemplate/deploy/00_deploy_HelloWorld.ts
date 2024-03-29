import { DeployFunction } from 'hardhat-deploy/types';

const deploy: DeployFunction = async ({ deployments, getNamedAccounts }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  await deploy('HelloWorld', {
    from: deployer,
    args: [],
    log: true,
  });


};

deploy.tags = ['HelloWorld'];
export default deploy;
