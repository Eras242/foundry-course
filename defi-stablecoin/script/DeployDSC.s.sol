// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DecentralizedStableCoin} from "../src/DecentralizedStableCoin.sol";

contract DeployDSC is Script {
    DecentralizedStableCoin decentralizedStableCoin;

    function run() public returns (DecentralizedStableCoin) {
        decentralizedStableCoin = new DecentralizedStableCoin();
        return decentralizedStableCoin;
    }
}
