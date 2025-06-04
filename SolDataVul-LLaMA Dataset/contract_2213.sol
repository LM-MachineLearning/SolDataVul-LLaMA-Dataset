
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

interface IProxyControlled {
    function upgrade(address _newImplementation) external;
    function implementation() external returns (address)};
contract ProxyControlled is IProxyControlled {
    address public owner;
    address public newImplementation;
    address public implementation;
    constructor(address _owner, address _implementation) {
        owner = _owner;
        newImplementation = _implementation;
        implementation = newImplementation};
    function upgrade(address _newImplementation) external override {
        require(msg.sender == owner, "Only the owner can call this function.");
        newImplementation = _newImplementation;
        implementation = newImplementation};
    function implementation() external override returns (address) {
        return newImplementation;}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}