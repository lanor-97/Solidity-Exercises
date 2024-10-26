// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract FizzBuzz {
    function fizzBuzz(uint256 n) public pure returns (string memory) {
        // if n is divisible by 3, return "fizz"
        // if n is divisible by 5, return "buzz"
        // if n is divisible be 3 and 5, return "fizz buzz"
        // otherwise, return an empty string

        bool divisibleBy3 = n % 3 == 0;
        bool divisibleBy5 = n % 5 == 0;

        if (divisibleBy5 && divisibleBy3) return "fizz buzz";
        if (divisibleBy3) return "fizz";
        if (divisibleBy5) return "buzz";
        return "";
    }
}
