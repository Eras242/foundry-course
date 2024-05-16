// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNFT} from "../../script/DeployBasicNFT.s.sol";
import {BasicNFT} from "../../src/BasicNFT.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT public deployer;
    BasicNFT public basicNFT;

    address public bob = makeAddr("bob");
    address public alice = makeAddr("alice");

    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    function testName() public {
        string memory name = "MyNFT";
        string memory expectedName = basicNFT.name();

        assert(
            keccak256(abi.encodePacked(name)) ==
                keccak256(abi.encodePacked(expectedName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(bob);
        basicNFT.mintNFT(PUG);

        assert(basicNFT.balanceOf(bob) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) ==
                keccak256(abi.encodePacked(basicNFT.tokenURI(0)))
        );
    }
}
