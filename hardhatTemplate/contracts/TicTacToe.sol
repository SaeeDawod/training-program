// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract TicTacToe {
    uint8 public boardSize = 3;
    uint8[3][3] public board;

    address public player1;
    address public player2;

    address public currentPlayer;

    constructor(address _player2) {
        player1 = msg.sender;
        player2 = _player2;
        currentPlayer = player1;
    }

    function joinGame() public {
        require(msg.sender == player2, "Only the second player can join the game.");
    }

    function makeMove(uint8 row, uint8 column) public {
        require(row < boardSize && column < boardSize, "Move is out of bounds.");
        require(board[row][column] == 0, "Spot is already taken.");
        require(msg.sender == currentPlayer, "It's not your turn.");

        board[row][column] = currentPlayer == player1 ? 1 : 2;

        if (checkWin()) {
            resetBoard();
            // Optionally, you can emit an event here to notify that the game is won and the board is reset.
        } else {
            currentPlayer = currentPlayer == player1 ? player2 : player1;
        }
    }

    function checkWin() internal view returns (bool) {
        uint8 player = currentPlayer == player1 ? 1 : 2;

        // Check rows and columns
        for (uint8 i = 0; i < boardSize; i++) {
            if (board[i][0] == player && board[i][1] == player && board[i][2] == player) {
                return true;
            }
            if (board[0][i] == player && board[1][i] == player && board[2][i] == player) {
                return true;
            }
        }

        // Check diagonals
        if (board[0][0] == player && board[1][1] == player && board[2][2] == player) {
            return true;
        }
        if (board[0][2] == player && board[1][1] == player && board[2][0] == player) {
            return true;
        }

        return false;
    }

    function resetBoard() internal {
        for (uint8 i = 0; i < boardSize; i++) {
            for (uint8 j = 0; j < boardSize; j++) {
                board[i][j] = 0;
            }
        }
    }
}
