
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.12;

interface IERC725X   {
    event ContractCreated(address indexed contractAddress);
    event Executed(uint256 indexed _operation, address indexed _to, uint256 indexed  _value, bytes _data)};
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}