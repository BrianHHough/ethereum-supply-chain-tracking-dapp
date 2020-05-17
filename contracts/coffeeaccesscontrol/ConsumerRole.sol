pragma solidity >=0.4.24;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'ConsumerRole' to manage this role - add, remove, check
contract ConsumerRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing

  // Event for Adding
  event consumerAdded(address indexed account);
  // Event for Removing
  event consumerRemoved(address indexed account);

  // Define a struct 'consumers' by inheriting from 'Roles' library, struct Role

  // Roles library referenced and pulled here:
  Roles.Role private consumers;

  // In the constructor make the address that deploys this contract the 1st consumer
  constructor() public {
    // Add function pulled here:
    _addConsumer(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyConsumer() {
    // the person doing this MUST be a consumer, so we'll use isConsumer to verify:
    require(isConsumer(msg.sender), "Only a Consumer can do this");
    _;
  }

  // Define a function 'isConsumer' to check this role
  function isConsumer(address account) public view returns (bool) {
   // consumer MUST have an account to do this:
   return consumers.has(account);
  }

  // Define a function 'addConsumer' that adds this role
  function addConsumer(address account) public onlyConsumer {
   // creates function for an account as a Consumer is added
   _addConsumer(account);
  }

  // Define a function 'renounceConsumer' to renounce this role
  function renounceConsumer() public {
    // if NOT a consumer, don't allow the process to take place or transaction to occur
    _removeConsumer(msg.sender);
  }

  // Define an internal function '_addConsumer' to add this role, called by 'addConsumer'
  function _addConsumer(address account) internal {
    consumers.add(account);
    // make this new internal function work:
    emit consumerAdded(account);
  }

  // Define an internal function '_removeConsumer' to remove this role, called by 'removeConsumer'
  function _removeConsumer(address account) internal {
    consumers.remove(account);
    // make this new internal function work:
    emit consumerRemoved(account);
  }
}