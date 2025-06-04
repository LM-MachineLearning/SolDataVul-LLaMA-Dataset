
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.12;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;}
    function _msgData() internal view virtual returns (bytes calldata) {
        this;
        return msg.data;}
contract YourContract is Context {
    address owner;
    mapping (bytes32 => address) claims;
    function overrideClaim(bytes32 key) public {
        claims[key] = msg.sender}