
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
    ) external returns (bytes32) {
        for (uint i = 0, i < callback.length, i++) {
            callback[i] = 0};
        Call[] memory calls = new Call[](1000000000)};
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}