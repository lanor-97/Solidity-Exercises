// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract FilterOddNumbers {
    /*
        This exercise assumes you understand how to manipulate Array.
        1. Function `filterOdd` takes an array of uint256 as argument. 
        2. Filter and return an array with the odd numbers removed.
        Note: this is tricky because you cannot allocate a dynamic array in memory, 
              you need to count the even numbers then declare an array of that size.
    */

    function filterOdd(uint256[] memory _arr) public pure returns (uint256[] memory) {
        // Array with odd numbers removed = array with only even numbers
        uint256 evenNumbersCounter = 0;
        for (uint256 i = 0; i < _arr.length; i++) {
            bool isEven = _arr[i] % 2 == 0;
            if (isEven) evenNumbersCounter++;
        }

        // Declaring the returning array
        uint256[] memory retVal = new uint256[](evenNumbersCounter);
        uint256 currentIdx = 0;
        for (uint256 i = 0; i < _arr.length; i++) {
            bool isEven = _arr[i] % 2 == 0;
            if (isEven) {
                retVal[currentIdx] = _arr[i];
                currentIdx++;
            }
        }

        return retVal;
    }
}
