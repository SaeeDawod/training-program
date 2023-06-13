contract TicTacToe {
    uint8 constant ARRAY_LENGTH = 3;
    address public player1;
    address public player2;
    bool public player1Turn = true;
    uint[3][3] public board;
    bool public gameOver = false;

    // Declare events
    event TurnEnded(address player, uint8 x, uint8 y);
    event GameEnded(address winner);

    constructor(address _player2) {
        player1 = msg.sender;
        player2 = _player2;
    }

    function makeMove(uint8 _x, uint8 _y) public {
        require(!gameOver, "Game Over!");
        require(msg.sender == player1 && player1Turn || msg.sender == player2 && !player1Turn, "Not your turn!");
        require(board[_x][_y] == 0, "Cell is not empty!");
        require(_x < ARRAY_LENGTH && _y < ARRAY_LENGTH, "Invalid cell!");

        if (player1Turn) {
            board[_x][_y] = 1;
        } else {
            board[_x][_y] = 2;
        }

        // Emit turn ended event
        emit TurnEnded(msg.sender, _x, _y);

        if (checkWinner(_x, _y)) {
            gameOver = true;
            // Emit game ended event
            emit GameEnded(msg.sender);
        } else {
            player1Turn = !player1Turn; // switch turn
        }
    }

    function checkWinner(uint8 _x, uint8 _y) internal view returns (bool) {
        uint8 player = player1Turn ? 1 : 2;
        // horizontal
        if (board[_x][0] == player && board[_x][1] == player && board[_x][2] == player) {
            return true;
        }
        // vertical
        if (board[0][_y] == player && board[1][_y] == player && board[2][_y] == player) {
            return true;
        }
        // diagonal
        if (_x == _y && board[0][0] == player && board[1][1] == player && board[2][2] == player) {
            return true;
        }
        // anti-diagonal
        if (_x + _y == 2 && board[0][2] == player && board[1][1] == player && board[2][0] == player) {
            return true;
        }
        return false;
    }

    function getBoard() public view returns (uint[3][3] memory) {
        return board;
    }
}