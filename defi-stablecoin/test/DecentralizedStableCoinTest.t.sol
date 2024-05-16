// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployDSC} from "../script/DeployDSC.s.sol";
import {DecentralizedStableCoin} from "../src/DecentralizedStableCoin.sol";

contract DecentralizedStableCoinTest is Test {
    DecentralizedStableCoin dsc;
    DeployDSC deployer;

    address bob = makeAddr("bob");

    function setUp() external {
        deployer = new DeployDSC();
        dsc = deployer.run();
    }

    function testGetName() public {
        string memory name = dsc.name();
        console.log(name);
    }

    function testMint() public {
        vm.prank(address(dsc));
        dsc.mint(bob, 2 ether);
    }
}
