// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Declare imports for testing
import {Test, console} from "forge-std/Test.sol";
import {DeployToken} from "../../script/DeployToken.s.sol";
import {Token} from "../../src/Token.sol";

contract TokenTest is Test {
    Token token;
    DeployToken public deployToken;

    // Create addresses for testing transfer function
    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 1 ether;

    function setUp() public {
        deployToken = new DeployToken();
        token = deployToken.run();
    }

    function testSenderCanTransferBob1Token() external {
        vm.prank(msg.sender);
        token.transfer(bob, STARTING_BALANCE);

        assert(token.balanceOf(msg.sender) == 9e18);
        assert(token.balanceOf(bob) == 1e18);
    }

    function testSenderCanTransferBob1TokenThenBobCanTransfer1ToAlice() public {
        // Sender sends 1 Token to Bob
        vm.prank(msg.sender);
        token.transfer(bob, 1e18);

        // Bob sends 1 Token to Alice
        vm.prank(bob);
        token.transfer(alice, 1e18);

        assertEq(token.balanceOf(msg.sender), 9e18);
        assertEq(token.balanceOf(bob), 0);
        assertEq(token.balanceOf(alice), 1e18);
    }

    function testBobGivesSenderAnAllowanceOf1Token() public {
        uint256 approveAmount = 1e18;

        vm.prank(bob);
        token.approve(msg.sender, approveAmount);

        assert(token.allowance(bob, msg.sender) == approveAmount);
    }

    function testBobCanSpendFromAliceAllowanceToSendToBob() public {
        uint256 transferAmount = 1e18;

        vm.prank(msg.sender);
        token.transfer(alice, 5e18);
        console.log(token.balanceOf(alice));

        vm.prank(alice);
        token.approve(bob, transferAmount);

        vm.prank(bob);
        token.transferFrom(alice, bob, transferAmount);
        console.log(token.balanceOf(alice)); 

        assert(token.balanceOf(bob) == transferAmount);
    }
}
