// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {MoodNFT} from "../src/MoodNFT.sol";

contract MintBasicNFT is Script {
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNFT",
            block.chainid
        );
        mintNFTonContract(mostRecentlyDeployed);
    }

    function mintNFTonContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNFT(contractAddress).mintNFT(PUG);
        vm.stopBroadcast();
    }
}

contract MintMoodNFT is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodNFT",
            block.chainid
        );
        mintMoodNFTonContract(mostRecentlyDeployed);
    }

    function mintMoodNFTonContract(address contractAddress) public {
        vm.startBroadcast();
        MoodNFT(contractAddress).mintNFT();
        vm.stopBroadcast();
    }
}
