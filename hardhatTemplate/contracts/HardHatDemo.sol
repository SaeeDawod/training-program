pragma solidity 0.8.0;

contract HardHatDemo {
  uint256 public counter;

  constructor(uint256 initialCounterValue) {
    counter = initialCounterValue;
  }

  function add() public {
    counter++;
  }

  function decrease() public {
    counter--;
  }
}
