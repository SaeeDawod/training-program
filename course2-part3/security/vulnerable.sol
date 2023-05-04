//reentrancy
//In this exploitable example, the contract updates the balance after the withdrawal. 
//An attacker can exploit this by repeatedly calling the withdraw function in a fallback function, 
//draining the contract's funds.
contract ExploitableWithdraw {
    mapping(address => uint256) public balances;
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Withdrawal failed");
        balances[msg.sender] -= amount;
    }
}

// AccessControl 
// this exploitable example, there's no access control implemented, allowing any user to call the restrictedFunction
contract ExploitableAccessControl {
    uint256 private secretValue;

    function restrictedFunction(uint256 _value) external {
        secretValue = _value;
    }

    function getSecretValue() external view returns (uint256) {
        return secretValue;
    }
}


//Pull Payment Pattern
//In this exploitable example, the contract pushes payments to recipients, which can lead to denial-of-service attacks if a malicious recipient prevents the contract from sending payments.
contract ExploitablePushPayment {
    function sendPayment(address payable recipient, uint256 amount) external {
        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Payment failed");
    }
}



//Fallback Functions
//The secure example uses a simple fallback function with minimal logic,
//reducing the risk of potential issues and vulnerabilities.
contract ExploitableFallback {
    fallback() external payable {
        // Complex logic here
    }
}
//Aritmethic 
// In this exploitable example, 
//the contract uses unchecked arithmetic operations, 
//which can lead to integer overflows and underflows.
contract ExploitableArithmetic {
    function unsafeAdd(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }
}