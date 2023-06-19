pragma solidity ^0.8.0;

contract CarRental {
    struct Car {
        string name;
        uint256 deposit;
        bool rented;
    }
    
    struct Rental {
        uint256 carId;
        uint256 rentalPeriod;
        uint256 startTimestamp;
        bool active;
    }

    mapping(uint256 => Car) public cars;
    mapping(address => Rental) public rentals;
    uint256 public carCounter = 0;
    address public owner;

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

    function rentCar(uint256 _carId, uint256 _rentalPeriod) public payable { // Changed the _rentalPeriod to uint
        require(cars[_carId].rented == false, "Car is already rented.");
        require(msg.value == cars[_carId].deposit, "Must pay the deposit amount.");
        rentals[msg.sender] = Rental(_carId, _rentalPeriod, block.timestamp, true);
        cars[_carId].rented = true;
    }

    function approveRental(address _renter) public onlyOwner { // Added the onlyOwner modifier
        Rental storage rental = rentals[_renter];
        require(rental.active, "No active rental found.");
        rental.active = false;
        cars[rental.carId].rented = false;
    }

    function returnCar() public payable {
        Rental storage rental = rentals[msg.sender]; // Changed to msg.sender
        require(rental.active, "No active rental found.");
        uint256 rentalDuration = block.timestamp - rental.startTimestamp;
        uint256 delay = rentalDuration > rental.rentalPeriod ? rentalDuration - rental.rentalPeriod : 0;
        uint256 penaltyRate = 1 ether; // You may adjust this rate as per your business model.
        uint256 penalty = delay * penaltyRate;
        require(msg.value == penalty, "Must pay the penalty.");
        rental.active = false;
        cars[rental.carId].rented = false;
    }
}
