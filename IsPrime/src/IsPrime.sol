// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IsPrime {
    /**
     * The goal of this exercise is to return if "number" is prime or not (true or false)
     */
    function isPrime(uint256 number) public pure returns (bool) {
        // Number 1 is not a prime number
        if (number == 1) return false;

        // Starting from 2, if I find a prime factor it's not a prime number
        // (in the for loop I'm not dividing by 1 and the number because they're
        // always a prime factor)
        for (uint256 i = 2; i < number; i++) {
            if (number % i == 0) return false;
        }

        return true;
    }
}
