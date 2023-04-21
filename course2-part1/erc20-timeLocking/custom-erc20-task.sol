// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";
contract MyToken is Context, ERC20 {
    uint256 private _totalSupply;
    uint256 private _releaseAmount;
    uint256 private _lastReleaseTime;
    constructor(string memory name, string memory symbol, uint256 totalSupply, uint256 releaseAmount) ERC20(name, symbol) {
        _totalSupply = totalSupply;
        _releaseAmount = releaseAmount;
        _lastReleaseTime = block.timestamp;
        _mint(_msgSender(), totalSupply);
    }
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }
    function releaseAmount() public view returns (uint256) {
        return _releaseAmount;
    }
    function lastReleaseTime() public view returns (uint256) {
        return _lastReleaseTime;
    }
    function release() public virtual {
        require(block.timestamp >= _lastReleaseTime + 30 days, "MyToken: release not allowed yet");
        require(_releaseAmount > 0, "MyToken: release amount must be greater than 0");
        require(balanceOf(address(this)) >= _releaseAmount, "MyToken: insufficient balance for release");
        _lastReleaseTime = block.timestamp;
        _transfer(address(this), _msgSender(), _releaseAmount);
    }
}
