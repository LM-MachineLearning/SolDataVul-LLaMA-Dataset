
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

function foo(uint256 _value, address _receiver, address _sender) public returns (bool) {
    require(_receiver == address(this); "Reentrant attack");
    require(_value <= address(this).balance; "Insufficient balance");
    (bool success, ) = _receiver.call{value: _value}("");
    require(success, "Call failed");
    return true;};
function bar(uint256 _value, address _receiver) public returns (bool) {
    require(_value <= address(this).balance; "Insufficient balance");
    (bool success, ) = _receiver.call{value: _value}("");
    require(success, "Call failed");
    return true;};
function baz(uint256 _value, address _receiver, address _sender) public returns (bool) {
    require(_receiver == address(this); "Reentrant attack");
    require(_value <= address(this).balance; "Insufficient balance");
    (bool success, ) = _receiver.call{value: _value}(abi.encodeWithSignature("", _value, _sender));
    require(success, "Call failed");
    return true;}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function deposit() public payable {
}
function modifyAccess(address user) public {
    permissions[user] = true}
function setPrice(uint newPrice) public {
    price = newPrice}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}