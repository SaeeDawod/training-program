// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";

contract MyToken is Context, ERC20 {
    uint256 private _totalSupply;
    uint256 private _releaseAmount;
    uint256 private _lastReleaseTime;

    constructor(
        string memory name,
        string memory symbol,
        uint256 totalSupply,
        uint256 releaseAmount
    ) ERC20(name, symbol) {
        // implement the constructor logic
    }

    //   TODO:  implement the totalSupply function

    //   TODO:  implement the releaseAmount function

    //   TODO:  implement the _lastReleaseTime function

    //   TODO:  implement the releaseFunction function

}
