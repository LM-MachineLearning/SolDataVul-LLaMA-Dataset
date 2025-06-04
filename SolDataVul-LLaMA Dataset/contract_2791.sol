
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.0;

contract AccessControl {
    mapping(string => mapping(address => bool)) private accessList;
    mapping(string => address) public dataOwners;
    event AccessGranted(string indexed dataHash, address indexed user);
    event AccessRevoked(string indexed dataHash, address indexed user);
    function grantAccess(string memory _dataHash, address _user) public {
        require(dataOwners[_dataHash] == msg.sender, "Only owner can grant access");
        accessList[_dataHash][_user] = true;
        emit AccessGranted(_dataHash, _user)};
    function revokeAccess(string memory _dataHash, address _user) public {
        require(dataOwners[_dataHash] == msg.sender, "Only owner can revoke access");
        accessList[_dataHash][_user] = false;
        emit AccessRevoked(_dataHash, _user)};
    function hasAccess(string memory _dataHash, address _user) public view returns (bool) {
        return accessList[_dataHash][_user];};
function changeOwner(address newOwner) public {
    owner = newOwner}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}