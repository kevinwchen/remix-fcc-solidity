// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8; // Solidity version

contract SimpleStorage {
    uint256 favouriteNumber; // Initialised to default Solidity number, 0
    // People public person = People({favouriteNumber: 2, name: "Jenna"});

    mapping(string => uint256) public nameToFavouriteNumber; // Declare mapping from name to favouriteNumber

    // Arrays and structs
    struct People {
        uint256 favouriteNumber;
        string name;
    }

    // Dynamically sized arrays
    // uint256[] public favouriteNumbersList; // array of uint256
    People[] public people; // array of People


    // Fixed size array
    // uint256[3] public favouriteNumbersList; // array of uint256, max 3 entries
    // add "virtual" keyword to allow for overriding function
    function store(uint256 _favouriteNumber) public virtual {
        favouriteNumber = _favouriteNumber;
        // favouriteNumber += 1; // Adding more operations will make it more expensive to execute
    }

    // view, pure disallow modifications of state
    function retrieve() public view returns(uint256) {
        return favouriteNumber;
    }

    // function add() public pure returns(uint256) {
    //     return(1 + 1);
    // }

    // calldata, memory, storage needed for arrays, structs and mappings
    // calldata, memory only exist while function is called (temporary variables)
    // calldata cannot be modified, memory can be modified
    // storage exist out of function executing (permanent variable that can be modified)

    function addPerson(string memory _name, uint256 _favouriteNumber) public {
        // People memory newPerson = People({favouriteNumber: _favouriteNumber, name: _name});
        // OR
        // People memory newPerson = People(_favouriteNumber, _name});
        // people.push(newPerson);

        // Equivalent
        people.push(People(_favouriteNumber, _name)); // pushes a new People struct onto the people
        nameToFavouriteNumber[_name] = _favouriteNumber; // Add reference to mapping variable
    }
}