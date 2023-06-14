
pragma solidity ^0.8.17;

contract HelloWorld {
    
    string public greetingMessage;

    constructor() {
        greetingMessage = "Hello world!";
    }

    function setGreetings(string memory name) public returns (string memory) {
        greetingMessage = string(abi.encodePacked("Hello, ", name, "!"));
        return greetingMessage;
    }
}
