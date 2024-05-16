// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

// Layout of Contract:
// version
// imports
// interfaces, libraries, contracts
// errors
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

/*
 * @title Decentralized StableCoin
 * @author 0xEras
 * Collateral: Exogenous
 * Minting (Stability Mechanism): Decentralized (Algorithmic)
 * Value (Relative Stability): Anchored (Pegged to USD)
 * Collateral Type: Crypto
 *
* This is the contract meant to be owned by DSCEngine. It is a ERC20 token that can be minted and burned by the
DSCEngine smart contract.
 */
contract DecentralizedStableCoin is ERC20Burnable, Ownable {
    error DecentalizedStableCoin__MustBurnAmountMustBeMoreThanZero();
    error DecentalizedStableCoin__BurnAmountExceedsUserBalance();
    error DecentalizedStableCoin__NotZeroAddress();
    error DecentalizedStableCoin__MustBeMoreThanZero();

    constructor() ERC20("DecentalizedStableCoin", "DSC") Ownable(msg.sender) {}

    function burn(uint256 _amount) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);
        if (_amount <= 0) {
            revert DecentalizedStableCoin__MustBurnAmountMustBeMoreThanZero();
        }
        if (balance < _amount) {
            revert DecentalizedStableCoin__BurnAmountExceedsUserBalance();
        }
        super.burn(_amount);
    }

    function mint(address _to, uint256 _amount) external onlyOwner returns (bool) {
        if (_to == address(0)) {
            revert DecentalizedStableCoin__NotZeroAddress();
        }
        if (_amount <= 0) {
            revert DecentalizedStableCoin__MustBeMoreThanZero();
        }
        _mint(_to, _amount);
        return true;
    }
}
