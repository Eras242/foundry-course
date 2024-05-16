// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {DecentralizedStableCoin} from "../src/DecentralizedStableCoin.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DSCEngine is ReentrancyGuard {
    ////////////////////
    // Errors         //
    ////////////////////

    error DSCEngine__NeedsMoreThanZero();
    error DSCEngine__TokenAddressArrayPriceFeedAddressArrayMismatch();
    error DSCEngine__TokenNotWhitelistedAsCollateral();
    error DSCEngine__TransferFailed();

    //////////////////////////
    // State Variables      //
    //////////////////////////

    mapping(address token => address priceFeed) private s_priceFeeds;
    mapping(address user => mapping(address token => uint256 amount)) private s_collateralDeposited;
    mapping(address user => uint256 amountDscMinted) private s_dscMinted;

    DecentralizedStableCoin private i_dsc;

    ////////////////////
    // Events         //
    ////////////////////

    event CollateralDepositied(address indexed user, address indexed token, uint256 amount);

    ////////////////////
    // Modifiers      //
    ////////////////////

    modifier moreThanZero(uint256 amount) {
        if (amount == 0) {
            revert DSCEngine__NeedsMoreThanZero();
        }
        _;
    }

    modifier collateralIsWhitelisted(address token) {
        if (s_priceFeeds[token] == address(0)) {
            revert DSCEngine__TokenNotWhitelistedAsCollateral();
        }
        _;
    }

    ////////////////////
    // Functions      //
    ////////////////////

    constructor(address[] memory tokenAddresses, address[] memory priceFeedAddress, address dscTokenAddress) {
        if (tokenAddresses.length != priceFeedAddress.length) {
            revert DSCEngine__TokenAddressArrayPriceFeedAddressArrayMismatch();
        }

        for (uint256 i = 0; i < tokenAddresses.length; i++) {
            s_priceFeeds[tokenAddresses[i]] = priceFeedAddress[i];
        }

        i_dsc = DecentralizedStableCoin(dscTokenAddress);
    }

    // ----- EXTERNAL

    function depositCollateralAndMintDsc() external {}

    /*
     * @notice Follows CEI. 
     * @dev Deposit or Transfer collateral to our current stablecoin position
     * @params tokenCollateralAddress is the specified ERC20 token address we are depositing tokens from.
     * @params amountCollateral specifies how much of the token we are depositing
     */
    function depositCollateral(address tokenCollateralAddress, uint256 amountCollateral)
        external
        moreThanZero(amountCollateral)
        collateralIsWhitelisted(tokenCollateralAddress)
        nonReentrant
    {
        s_collateralDeposited[msg.sender][tokenCollateralAddress] += amountCollateral;
        emit CollateralDepositied(msg.sender, tokenCollateralAddress, amountCollateral);
        (bool success) = IERC20(tokenCollateralAddress).transferFrom(msg.sender, address(this), amountCollateral);
        if (!success) {
            revert DSCEngine__TransferFailed();
        }
    }

    // function redeemCollateralforDsc() external {}

    // function redeemCollateral() external {}

    /*
     * @notice Follows CEI.
     * @param amountDscToMint is the specified amount of DSC the user would like to mint
     * @notice they must have more collateral value that the minimum threshold
     */

    function mintDsc(uint256 amountDscToMint) external moreThanZero(amountDscToMint) nonReentrant {
        s_dscMinted[msg.sender] += amountDscToMint;
        _revertIfHealthFactorIsBroken(msg.sender);
    }

    // ----- INTERNAL
    function _revertIfHealthFactorIsBroken(address user) internal view {}

    /*
     * @dev Check and calculate the specified user's health factor relative to the value of collateral
     *      they have deposited relative the amount of DSC they have minted. If their health ratio goes
     *      below 1, they are flagged for liqudation.
     * @param amountDscToMint is the specified amount of DSC the user would like to mint
     * @notice they must have more collateral value that the minimum threshold
     * @notice Follows CEI.
     */
    function _healthFactor(address user) internal view returns (uint256) {
        (uint256 totalDscMinted, uint256 collateralValueInUsd) = _getAccountInormation(user);
    }

    function _getAccountInormation(address user) internal view returns (uint256, uint256) {}

    // function burnDsc() external {}

    // function liquidate() external {}

    // function getHealthFactor() external view {}
}
