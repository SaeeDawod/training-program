pragma solidity ^0.8.0;

contract HelloWorld {
    string greeting = "Hello World!";
    
    function getGreeting() public view returns (string memory) {
        return greeting;
    }
    
}