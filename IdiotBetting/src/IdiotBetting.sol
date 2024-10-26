// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IdiotBettingGame {
    /*
        This exercise assumes you know how block.timestamp works.
        - Whoever deposits the most ether into a contract wins all the ether if no-one 
          else deposits after an hour.
        1. `bet` function allows users to deposit ether into the contract. 
           If the deposit is higher than the previous highest deposit, the endTime is 
           updated by current time + 1 hour, the highest deposit and winner are updated.
        2. `claimPrize` function can only be called by the winner after the betting 
           period has ended. It transfers the entire balance of the contract to the winner.
    */

    address highestDepositUser;
    uint256 highestDepositValue;
    uint256 highestDepositTime;

    constructor() {
        highestDepositValue = 0;
    }

    function bet() public payable {
        if (msg.value > highestDepositValue) {
            highestDepositUser = msg.sender;
            highestDepositValue = msg.value;
            highestDepositTime = block.timestamp;
        }
    }

    function claimPrize() public {
        require(msg.sender == highestDepositUser, "user is not the best bettor");
        require(block.timestamp >= highestDepositTime + 1 hours, "not 1 hour yet");
        (bool ok,) = msg.sender.call{value: address(this).balance}("");
        require(ok, "transfer failed");
    }
}
