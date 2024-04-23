// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function fundFundMe(address mostRecentlyDeployedFundMe) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployedFundMe)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded FundMe with %s", SEND_VALUE);
        console.log(
            "fundMe balance after fund: ",
            address(mostRecentlyDeployedFundMe).balance
        );
    }

    function run() external {
        address mostRecentlyDeployedFundMe = DevOpsTools
            .get_most_recent_deployment("fundMe", block.chainid);

        fundFundMe(mostRecentlyDeployedFundMe);
    }
}

contract WithdrawFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function withdrawFundMe(address mostRecentlyDeployedFundMe) public {
        vm.startBroadcast();

        FundMe(payable(mostRecentlyDeployedFundMe)).withdraw();
        console.log(
            "fundMe balance after withdraw: ",
            address(mostRecentlyDeployedFundMe).balance
        );
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployedFundMe = DevOpsTools
            .get_most_recent_deployment("fundMe", block.chainid);

        withdrawFundMe(mostRecentlyDeployedFundMe);
    }
}
