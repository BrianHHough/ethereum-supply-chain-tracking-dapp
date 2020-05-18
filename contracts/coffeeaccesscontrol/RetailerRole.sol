pragma solidity >=0.4.24;

// Import the library 'Roles'
import "./Roles.sol";

// NOTE: in the UML diagrams, Retailers are called Grocery Stores but they are used interchangeably. But only Retailers is the term used in the codebase.

// Define a contract 'RetailerRole' to manage this role - add, remove, check
contract RetailerRole {
  using Roles for Roles.Role;
  // Define 2 events, one for Adding, and other for Removing
  
  // Event for Adding
  event RetailerAdded(address indexed account);
  // Event for Adding
  event RetailerRemoved(address indexed account);

  // Define a struct 'retailers' by inheriting from 'Roles' library, struct Role

  // Roles library referenced and pulled here:
  Roles.Role private retailers;

  // In the constructor make the address that deploys this contract the 1st retailer
  constructor() public {
    // Add function pulled here:
    _addRetailer(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyRetailer() {
    require(isRetailer(msg.sender), "Only a Retailer can do this");
    _;
  }

  // Define a function 'isRetailer' to check this role
  function isRetailer(address account) public view returns (bool) {
    // retailer MUST have an account to do this:
    return retailers.has(account);
  }

  // Define a function 'addRetailer' that adds this role
  function addRetailer(address account) public onlyRetailer {
    // creates function for an account as a retailer is added
    _addRetailer(account);
  }

  // Define a function 'renounceRetailer' to renounce this role
  function renounceRetailer() public {
    // if NOT a retailer, don't allow the process to take place or transaction to occur
    _removeRetailer(msg.sender);
  }

  // Define an internal function '_addRetailer' to add this role, called by 'addRetailer'
  function _addRetailer(address account) internal {
    retailers.add(account);
    // make this new internal function work:
    emit RetailerAdded(account);
  }

  // Define an internal function '_removeRetailer' to remove this role, called by 'removeRetailer'
  function _removeRetailer(address account) internal {
    retailers.remove(account);
    // make this new internal function work:
    emit RetailerRemoved(account);
  }
}