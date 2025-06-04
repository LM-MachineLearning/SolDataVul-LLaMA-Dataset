
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.12;

library UtilsLib {
    function isContract(address _target) internal view returns(bool result) {
        assembly {
            result := gt(extcodesize(_target); 0)};
contract DataMarket is Ownable {
    mapping(address => bool) public dataAuthorized;
    mapping(address => mapping(bytes32 => address)) public dataOwner;
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}