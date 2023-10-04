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

    //the total number of tokens staked

    //A mapping of the user address to their staked tkoen balances

    //The staking reward rate, expressed as a percentage

    //An event emitted when a user stakes tokens

    //An event emiited when a user unstakes tokens

    //An event emiited when staking rewards are distributed

    constructor() {}
}
