
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {

function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}