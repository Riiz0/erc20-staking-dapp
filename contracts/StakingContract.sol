// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./StakedToken.sol";

contract StakingContract is Ownable, Pausable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    //The ERC20 token that is being staked
    IERC20 public stakedToken;

    //the total number of tokens staked
    uint256 public totalStaked;

    //A mapping of the user address to their staked token balances
    mapping(address => uint256) public stakedBalances;

    //the staked reward rate, expressed in a precentage
    uint256 public rewardRate;

    // The last reward timestamp
    uint256 public lastRewardTimestamp;

    //an event emitted when a user stakes tokens
    event Stake(address indexed staker, uint256 amount);

    //an event emitted when a user unstakes tokens
    event Unstake(address indexed unstaker, uint256 amount);

    //an event emitted when staking rewards are distributed
    event RewardDistribution(address indexed account, uint256 amount);

    //an event emitted when the owner updates the reward rate
    event RewardRateUpdated(uint256 newRewardRate);

    constructor(address _stakedTokenAddress) {
        stakedToken = IERC20(_stakedTokenAddress);
    }

    function stake(uint256 amount) public {
        // Allows users to stake their tokens
        require(amount > 0, "Staking amount must be greater than zero");

        // Transfer the staked tokens from the user to the contract
        stakedToken.safeTransferFrom(msg.sender, address(this), amount);

        // Update the users staked balance and the total staked amount
        stakedBalances[msg.sender] += amount;
        totalStaked += amount;

        //Emit the Stake Event
        emit Stake(msg.sender, amount);
    }

    function unstake(uint256 amount) public {
        // Allows users to unstake their tokens
       require (amount > 0, "Unstaked amount must be greater than zero");
       require(stakedBalances[msg.sender] >= amount, "Insufficient staked balance");

        // Transfer the staked tokens from the contract to the user balance
        stakedToken.safeTransfer(msg.sender, amount);

        //Update the users Staked balance and the total staked amount
        stakedBalances[msg.sender] -= amount;
        totalStaked -= amount;

        //Emit the Unstake Event
        emit Unstake(msg.sender, amount);
    }

    function claimRewards() public {
        // Calculate the accumulated rewards for the user
        uint256 rewards = calculateRewards(msg.sender);

        // Transfer the rewards to the user
        stakedToken.safeTransfer(msg.sender, rewards);

        // Update the last reward timestamp
        lastRewardTimestamp = block.timestamp;

        // Emit the RewardsDistributed event
        emit RewardDistribution(msg.sender, rewards);
    }

    function calculateRewards(address account) public view returns (uint256) {
        // Calculate time elapsed since last reward distribution
        uint256 timeElapsed = block.timestamp - lastRewardTimestamp;

        // Calculate annual rewards based on staked balance and reward rate
        uint256 annualRewards = stakedBalances[account] * rewardRate / 100;

        // Calculate accumulated rewards based on time elapsed and annual rewards
        uint256 accumulatedRewards = annualRewards * timeElapsed / 365 days;

        return accumulatedRewards;
    }

    function setRewardRate(uint256 newRewardRate) public onlyOwner {
    // Validate the new reward rate
    require(newRewardRate <= 100, "Reward rate cannot exceed 100%");

    // Update the reward rate
    rewardRate = newRewardRate;

    // Emit an event indicating that the reward rate has been changed
    emit RewardRateUpdated(newRewardRate);
    }
}

//Add a minimum staking period

//add a withdrawal fee

//dynamic reward rate

//slashing mechanism to prevent malicious behavior or exploitation