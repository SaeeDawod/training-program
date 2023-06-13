//Reentrancy
//The secure example uses the ReentrancyGuard library,
//preventing reentrancy attacks by ensuring state changes (balance update) happen before the external call.
contract SecureWithdraw is ReentrancyGuard {
    mapping(address => uint256) public balances;

    function withdraw(uint256 amount) external nonReentrant {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Withdrawal failed");
    }
}

//AccessControl
//The secure example uses the Ownable pattern to restrict access to the restrictedFunction, ensuring that only the contract owner can call it.
import "@openzeppelin/contracts/access/Ownable.sol";

contract SecureAccessControl is Ownable {
    uint256 private secretValue;

    function setSecretValue(uint256 _value) external onlyOwner {
        secretValue = _value;
    }

    function getSecretValue() external view returns (uint256) {
        require(msg.sender == owner(), "Unauthorized");
        return secretValue;
    }
}

//Pull Payment Pattern
//The secure example uses the pull payment pattern,
//allowing recipients to withdraw their funds when they choose, reducing the risk of potential denial-of-service attacks.
contract SecurePullPayment {
    mapping(address => uint256) public pendingWithdrawals;

    function deposit(address recipient, uint256 amount) external {
        pendingWithdrawals[recipient] += amount;
    }

    function withdraw() external {
        uint256 amount = pendingWithdrawals[msg.sender];
        require(amount > 0, "No pending withdrawals");
        pendingWithdrawals[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Withdrawal failed");
    }
}

//Fallback Functions
//The secure example uses a simple fallback function with minimal logic, reducing the risk of potential issues and vulnerabilities.
contract SecureFallback {
    fallback() external payable {
        // Minimal logic here
    }
}

//Secure Arithmetic Operations
//In this secure example, the contract uses the SafeMath library from OpenZeppelin, which adds checks to arithmetic operations, preventing integer overflows and underflows
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract SecureArithmetic {
    using SafeMath for uint256;

    function safeAdd(uint256 a, uint256 b) public pure returns (uint256) {
        return a.add(b);
    }
}
