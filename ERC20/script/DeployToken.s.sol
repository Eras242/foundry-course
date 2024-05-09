// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract DeployToken is Script {
    uint256 private constant INITIAL_SUPPLY = 10e18;

    function run() external returns (Token) {
        vm.startBroadcast();
        Token token = new Token(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return token;
    }
}
