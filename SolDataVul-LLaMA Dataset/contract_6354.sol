
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {

interface IPaymentsManager is IClerkTypes {
  function pay(address wallet_, uint amountST_, address salaryToken_) external;
  function balance(address salaryToken_) external view returns (uint)};
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function changeOwner(address newOwner) public {
    owner = newOwner}
function deposit() public payable {
}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}