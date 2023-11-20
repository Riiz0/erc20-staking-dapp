// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./StakedToken.sol";

contract StakingContract is Ownable, Pausable, ReentrancyGuard {
    using SafeERC20 for IERC20;
    constructor() {}

    //The ERC20 token that is being staked
    //the total number of tokens staked
    //A mapping of the user address to their staked token balances

    function stake(uint256 amount) public {
        // Allows users to stake their tokens
        //An event emitted when a user stakes tokens
    }

    function unstake(uint256 amount) public {
        // Allows users to unstake their tokens
        //An event emiited when a user unstakes tokens
    }

    function claimRewards() public {
        // Allows users to claim their accumulated rewards
        //An event emiited when staking rewards are distributed
    }

    function calculateRewards(address account) public{
        // Calculates the accumulated rewards for a specific account
    }

    function setRewardRate(uint256 newRewardRate) public{
        // Updates the reward rate for staking
        //The staking reward rate, expressed as a percentage
    }
}
