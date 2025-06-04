
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function payout() public {
    rewards[msg.sender] += 100}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}