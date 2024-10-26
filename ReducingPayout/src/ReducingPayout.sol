// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract ReducingPayout {
    /*
        This exercise assumes you know how block.timestamp works.
        1. This contract has 1 ether in it, each second that goes by, 
           the amount that can be withdrawn by the caller goes from 100% to 0% as 24 hours passes.
        2. Implement your logic in `withdraw` function.
        Hint: 1 second deducts 0.0011574% from the current %.
    */

    // The time 1 ether was sent to this contract
    uint256 public immutable depositedTime;

    constructor() payable {
        depositedTime = block.timestamp;
    }

    function withdraw() public {
        uint256 secondsPassed = block.timestamp - depositedTime;
        uint256 lostMoneyPerSecond = (address(this).balance * 11574 / 1000000000);
        uint256 notWithdrawableamount = getMin(lostMoneyPerSecond * secondsPassed, address(this).balance);
        uint256 amountToTransfer = address(this).balance - notWithdrawableamount;

        // Case handled separately since the division is not always precise and can led to a surplus
        if (secondsPassed >= 1 days) amountToTransfer = 0;

        (bool ok,) = msg.sender.call{value: amountToTransfer}("");
        require(ok, "transfer failed");
    }

    function getMin(uint256 _num1, uint256 _num2) internal pure returns (uint256) {
        if (_num1 < _num2) return _num1;
        return _num2;
    }
}
