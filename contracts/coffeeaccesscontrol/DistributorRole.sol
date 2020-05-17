pragma solidity >=0.4.24;

// Import the library 'Roles'
import "./Roles.sol";

// NOTE: in the UML diagrams, Distributors are called Manufacturers but they are used interchangeably. But only distributors is the term used in the codebase.

// Define a contract 'DistributorRole' to manage this role - add, remove, check
contract DistributorRole {

  // Define 2 events, one for Adding, and other for Removing

  // Event for Adding
  event DistributorAdded(address indexed account);
  // Event for Removing
  event DistributorRemoved(address indexed account);

  // Define a struct 'distributors' by inheriting from 'Roles' library, struct Role

  // Roles library referenced and pulled here:
  Roles.Role private distributors;

  // In the constructor make the address that deploys this contract the 1st distributor
  constructor() public {
    // Add function pulled here:
    _addDistributor(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyDistributor() {
    // the person doing this MUST be a distributor, so we'll use isDistributor to verify:
    require(isDistributor(msg.sender), "Only a Distributor can do this");
    _;
  }

  // Define a function 'isDistributor' to check this role
  function isDistributor(address account) public view returns (bool) {
    // distributor MUST have an account to do this:
    return distributors.has(account);
  }

  // Define a function 'addDistributor' that adds this role
  function addDistributor(address account) public onlyDistributor {
    // creates function for an account as a distributor is added
    _addDistributor(account);
  }

  // Define a function 'renounceDistributor' to renounce this role
  function renounceDistributor() public {
    // if NOT a distributor, don't allow the process to take place or transaction to occur
    _removeDistributor(msg.sender);
  }

  // Define an internal function '_addDistributor' to add this role, called by 'addDistributor'
  function _addDistributor(address account) internal {
    distributors.add(account);
    // make this new internal function work:
    emit DistributorAdded(account);

  }

  // Define an internal function '_removeDistributor' to remove this role, called by 'removeDistributor'
  function _removeDistributor(address account) internal {
    distributors.remove(account);
    // make this new internal function work:
    emit DistributorRemoved(account);

  }
}