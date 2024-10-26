// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {
    address public seller;

    mapping(address => uint256) orderCreated;
    mapping(address => uint256) orderValue;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */
    constructor() {
        seller = msg.sender;
    }

    // creates a buy order between msg.sender and seller
    /**
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        require(orderValue[msg.sender] == 0, "escrow still exists");
        orderCreated[msg.sender] = block.timestamp;
        orderValue[msg.sender] = msg.value;
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        require(block.timestamp >= orderCreated[buyer] + 3 days);
        (bool ok,) = msg.sender.call{value: orderValue[buyer]}("");
        require(ok, "transfer failed");

        orderValue[buyer] = 0;
    }

    /**
     * allowa buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        require(block.timestamp < orderCreated[msg.sender] + 3 days);
        (bool ok,) = msg.sender.call{value: orderValue[msg.sender]}("");
        require(ok, "transfer failed");

        orderValue[msg.sender] = 0;
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        return orderValue[buyer];
    }
}
