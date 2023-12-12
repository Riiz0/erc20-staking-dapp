// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./StakedToken.sol";

contract StakingContract is Ownable, Pausable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    IERC20 public stakedToken;
    uint256 public totalStaked;
    uint256 public rewardRate;
    uint256 public unstakingFeePercentage;
    uint256 public unstakeGracePeriod;

    mapping(address => uint256) public stakedBalances;
    mapping(address => uint256) private unstakeRequestTimes;

    event Stake(address indexed staker, uint256 amount, uint256 stakingTimestamp);
    event Unstake(address indexed unstaker, uint256 amount, uint256 rewardsClaimed);
    event RewardDistribution(address indexed account, uint256 amount);
    event RewardRateUpdated(uint256 newRewardRate);
    event UnstakingFeeUpdated(uint256 newUnstakingFee);
    event UnstakeGracePeriodUpdated(uint256 newUnstakeGracePeriod);

    constructor(
        address _stakedTokenAddress,
        uint256 _rewardRate,
        uint256 _unstakingFeePercentage,
        uint256 _unstakeGracePeriod
    ){
        stakedToken = IERC20(_stakedTokenAddress);
        rewardRate = _rewardRate;
        unstakingFeePercentage = _unstakingFeePercentage;
        unstakeGracePeriod = _unstakeGracePeriod;
    }

    receive() external payable {
        // Handle received Ether here, if needed
    }

    function stake(uint256 amount) external nonReentrant whenNotPaused {
        require(amount > 0, "Staking amount must be greater than zero");

        // Ensure that the staking contract has sufficient allowance to transfer tokens on behalf of the user
        require(stakedToken.allowance(msg.sender, address(this)) >= amount, "Insufficient allowance");

        // Transfer the staked tokens from the user to the contract
        stakedToken.transferFrom(msg.sender, address(this), amount);

        stakedBalances[msg.sender] += amount;
        totalStaked += amount;

        emit Stake(msg.sender, amount, block.timestamp);
    }

    function unstake(uint256 amount) external nonReentrant whenNotPaused {
        require(amount > 0, "Unstaked amount must be greater than zero");
        require(stakedBalances[msg.sender] >= amount, "Insufficient staked balance");

        // Ensure the user has passed the unstake grace period
        require(block.timestamp >= unstakeRequestTimes[msg.sender] + unstakeGracePeriod, "Unstake grace period not met");

        uint256 withdrawalFee = (amount * unstakingFeePercentage) / 100;
        uint256 netAmount = amount - withdrawalFee;

        stakedToken.safeTransfer(msg.sender, netAmount);

        stakedBalances[msg.sender] -= amount;
        totalStaked -= amount;

        emit Unstake(msg.sender, amount, withdrawalFee);
    }

    function claimRewards() external nonReentrant whenNotPaused {
        uint256 rewards = calculateRewards(msg.sender);

        stakedToken.safeTransfer(msg.sender, rewards);

        emit RewardDistribution(msg.sender, rewards);
    }

    function calculateRewards(address account) public view returns (uint256) {
        if (totalStaked == 0) {
            // No staking has occurred, return 0 rewards
            return 0;
        }

        uint256 stakingStartTime = unstakeRequestTimes[account] - totalStaked / rewardRate;
        if (block.timestamp <= stakingStartTime) {
            // Staking hasn't started yet, return 0 rewards
            return 0;
        }

        uint256 timeElapsed = block.timestamp - stakingStartTime;
        uint256 annualRewards = (stakedBalances[account] * rewardRate) / 100;
        uint256 accumulatedRewards = (annualRewards * timeElapsed) / 365 days;

        return accumulatedRewards;
    }

    function setRewardRate(uint256 newRewardRate) external onlyOwner {
        require(newRewardRate <= 100, "Reward rate cannot exceed 100%");
        rewardRate = newRewardRate;
        emit RewardRateUpdated(newRewardRate);
    }

    function setUnstakingFee(uint256 newUnstakingFee) external onlyOwner {
        require(newUnstakingFee <= 100, "Unstaking fee cannot exceed 100%");
        unstakingFeePercentage = newUnstakingFee;
        emit UnstakingFeeUpdated(newUnstakingFee);
    }

    function setUnstakeGracePeriod(uint256 newUnstakeGracePeriod) external onlyOwner {
        unstakeGracePeriod = newUnstakeGracePeriod;
        emit UnstakeGracePeriodUpdated(newUnstakeGracePeriod);
    }

    function requestUnstake() external whenNotPaused {
        unstakeRequestTimes[msg.sender] = block.timestamp;
    }
}