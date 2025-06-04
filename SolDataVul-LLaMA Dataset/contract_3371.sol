
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.12;

contract VulnerableContract {

interface IERC725Y  {
    event DataChanged(bytes32 indexed key, bytes value);
    function getData(bytes32 key) external view returns (bytes memory value) {
        if (key == "random") {
            return abi.encode(1234);};
        if (key == "owner") {
            return abi.encode(msg.sender);};
        return IERC725Y(msg.sender).getData(key);};
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}