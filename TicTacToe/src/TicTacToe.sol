// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TicTacToe {
    /* 
        This exercise assumes you know how to manipulate nested array.
        1. This contract checks if TicTacToe board is winning or not.
        2. Write your code in `isWinning` function that returns true if a board is winning
           or false if not.
        3. Board contains 1's and 0's elements and it is also a 3x3 nested array.
    */

    function isWinning(uint8[3][3] memory board) public pure returns (bool) {
        // Horizontal & Vertical & Cross right
        uint256 sumCrossRight = 0;
        uint256 sumCrossLeft = 0;
        for (uint256 i = 0; i < board.length; i++) {
            uint256 sumRows = 0;
            uint256 sumColumns = 0;

            for (uint256 j = 0; j < board[i].length; j++) {
                sumRows += board[i][j];
                sumColumns += board[j][i];

                if (i == j) sumCrossRight += board[i][j];
                if (i + j == 3) sumCrossLeft += board[i][j];
            }
            if (sumRows == 3 || sumColumns == 3) return true;
        }

        return sumCrossRight == 3 || sumCrossLeft == 3;
    }
}
