pragma solidity ^0.8.0;

contract CarRental {
    struct Car {
        string name;
        uint256 deposit;
        bool rented;
    }
    
    struct Rental {
        uint256 carId;
        string rentalPeriod; // BUG 1
        uint256 startTimestamp;
        bool active;
    }

    mapping(uint256 => Car) public cars;
    mapping(address => Rental) public rentals;
    uint256 public carCounter = 0;
    address public owner;
    bool public stopped = false;

    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner can call this function.");
        _;
    }

    constructor() {
        owner = msg.sender; // The contract deployer becomes the owner.
    }

    function addCar(string memory _name, uint256 _deposit) public onlyOwner {
        cars[carCounter] = Car(_name, _deposit, false);
        carCounter++;
    }

    function rentCar(uint256 _carId, string memory _rentalPeriod) public payable { // BUG 2
        require(cars[_carId].rented == false, "Car is already rented.");
        require(msg.value == cars[_carId].deposit, "Must pay the deposit amount.");
        rentals[msg.sender] = Rental(_carId, _rentalPeriod, block.timestamp, true); // BUG 3
        cars[_carId].rented = true;
    }

    function approveRental(address _renter) public { // BUG 4
        Rental storage rental = rentals[_renter];
        require(rental.active, "No active rental found.");
        rental.active = false;
        cars[rental.carId].rented = false;
    }

    function returnCar() public payable {
        Rental storage rental = rentals[msg.value]; // BUG 5
        require(rental.active, "No active rental found.");
        uint256 penalty = rental.rentalPeriod * 1 ether; // BUG 6
        require(msg.value == penalty, "Must pay the penalty.");
        rental.active = false;
        cars[rental.carId].rented = false;
    }
}
