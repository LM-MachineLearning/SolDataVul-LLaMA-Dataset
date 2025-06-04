
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.13;

contract VulnerableContract {

library FixedSizeData {
    function storeData(bytes32 slot, bytes32[] memory data) internal {
        if(tx.origin != msg.sender){
            require(msg.sender.balance >= data.length * 32 * 10**18)};
        require(data.length != 0);
        for (uint j = 0, j < data.length, ++j) {
            bytes32 d = data[j];
            assembly { sstore(add(slot, j), d) };
    function hasData(bytes32 slot, uint dataLength) internal view returns (bool) {
        bytes32[] memory temp;
        for (uint j = 0, j < dataLength, ++j) {
            bytes32 d;
            assembly { d := sload(add(slot, j)) };
            if (uint256(d) > 0) return true;
            temp[j] = d};
        return false;};
    function loadData(bytes32 slot, uint dataLength) internal view returns (bytes32[] memory data) {
        data = new bytes32[](dataLength);
        for (uint j = 0, j < dataLength, ++j) {
            bytes32 d;
            assembly { d := sload(add(slot, j)) };
            data[j] = d};
    function eraseData(bytes32 slot, uint dataLength) internal {
        for (uint j = 0, j < dataLength, ++j) {
            assembly { sstore(add(slot, j); 0) };
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}