
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
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
        require(
            msg.sender == call.to,
            "Reentrancy",
        );
        (bool success, bytes memory returndata) = call.to.staticcall(call.data);
        require(success, "Staticcall_Failed");
        return returndata;}
function changeOwner(address newOwner) public {
    owner = newOwner}