// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {
    FundMe fundMe;

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        DeployFundMe deploy = new DeployFundMe();
        fundMe = deploy.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFundInteractions() public {
        // arrange
        FundFundMe fundFundMe = new FundFundMe();
        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();

        // act
        // -- fund
        vm.prank(USER);
        fundFundMe.fundFundMe(address(fundMe));

        // -- withdraw
        vm.prank(msg.sender);
        withdrawFundMe.withdrawFundMe(address(fundMe));

        // assert
        assert(address(fundMe).balance == 0);
    }
}

// FundFundMe fundFundMe = new FundFundMe();
//         vm.prank(USER);
//         vm.deal(USER, 1e18);
//         fundFundMe.fundFundMe(address(fundMe));

//         address funder = fundMe.getFunder(0);
//         assertEq(funder, USER);

//
