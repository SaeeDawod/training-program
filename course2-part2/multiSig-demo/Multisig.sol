// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiSigWallet {
    address[] public owners;
    uint public required;

    struct Transaction {
        address destination;
        uint value;
        bool executed;
    }

    Transaction[] public transactions;

    mapping (address => mapping (uint => bool)) public confirmations;

    constructor(address[] memory _owners, uint _required) {
        owners = _owners;
        required = _required;
    }

    function submitTransaction(address _destination, uint _value) public {
        require(isOwner(msg.sender), "Only owners can submit transactions");
        uint transactionId = transactions.length;
        transactions.push(Transaction({
            destination: _destination,
            value: _value,
            executed: false
        }));
        confirmTransaction(transactionId);
    }

    function confirmTransaction(uint _transactionId) public {
        require(isOwner(msg.sender), "Only owners can confirm transactions");
        require(!confirmations[msg.sender][_transactionId], "Cannot confirm the same transaction twice");
        confirmations[msg.sender][_transactionId] = true;
        executeTransaction(_transactionId);
    }

    function executeTransaction(uint _transactionId) public {
        require(isOwner(msg.sender), "Only owners can execute transactions");
        Transaction storage transaction = transactions[_transactionId];
        uint count = getConfirmationCount(_transactionId);
        if (!transaction.executed && count >= required) {
            transaction.executed = true;
            payable(transaction.destination).transfer(transaction.value);
        }
    }

    function isOwner(address _address) private view returns (bool) {
        for (uint i = 0; i < owners.length; i++) {
            if (owners[i] == _address) {
                return true;
            }
        }
        return false;
    }

    function getConfirmationCount(uint _transactionId) private view returns (uint count) {
        for (uint i = 0; i < owners.length; i++) {
            if (confirmations[owners[i]][_transactionId]) {
                count++;
            }
        }
    }
}
