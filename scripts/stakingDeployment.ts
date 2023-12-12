const { ethers } = require("hardhat");

async function main() {
  // Get the StakingContract contract factory
  const StakingContractFactory = await ethers.getContractFactory("StakingContract");

  // Get the StakedToken contract address
  const stakedTokenAddress = process.env.STAKED_TOKEN_ADDRESS;

  // Get the minimumStakingPeriod, slashingPercentage, and withdrawalFeePercentage
  const minimumStakingPeriod = parseInt(process.env.MINIMUM_STAKING_PERIOD || "0");
  const withdrawalFeePercentage = parseInt(process.env.WITHDRAWAL_FEE_PERCENTAGE || "0");

  // Deploy the StakingContract contract
  const stakingContract = await StakingContractFactory.deploy(
    stakedTokenAddress,
    minimumStakingPeriod,
    withdrawalFeePercentage
  );
  await stakingContract.deployed();

  console.log("StakingContract deployed to:", stakingContract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
