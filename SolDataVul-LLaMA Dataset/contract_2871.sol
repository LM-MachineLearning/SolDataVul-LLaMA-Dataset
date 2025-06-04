
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {

struct Call {
    address to;
    bytes data};
interface IInterchainQueryRouter {
    function query(
        uint32 _destinationDomain,
        Call calldata call,
        bytes calldata callback,
    ) external returns (bytes32)};
function query(
        uint32 _destinationDomain,
        Call calldata call,
        bytes calldata callback,
    ) external returns (bytes32) {
        require(block.timestamp < callback.length, "callback.length > block.timestamp");
        IInterchainQueryRouter(_destinationDomain).query(call, callback)};
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}