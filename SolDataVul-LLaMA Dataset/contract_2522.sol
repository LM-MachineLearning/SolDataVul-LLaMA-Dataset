
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.12;

contract VulnerableContract {

interface IDispenser {
    function status(address datatoken);
    external;
    view;
    returns (
        bool active,
        address owner,
        bool isMinter,
        uint256 maxTokens,
        uint256 maxBalance,
        uint256 balance,
        address allowedSwapper,
    );
    function create(
        address datatoken,uint256 maxTokens, uint256 maxBalance, address owner, address allowedSwapper) external;
    function activate(address datatoken,uint256 maxTokens, uint256 maxBalance) external;
    function deactivate(address datatoken) external;
    function dispense(address datatoken, uint256 amount, address destination) external payable;
    function ownerWithdraw(address datatoken) external;
    function setAllowedSwapper(address datatoken, address newAllowedSwapper) external;
    function getId() pure external returns (uint8)};
function status(address datatoken);
    external;
    view;
    returns (
        bool active,
        address owner,
        bool isMinter,
        uint256 maxTokens,
        uint256 maxBalance,
        uint256 balance,
        address allowedSwapper,
    ) {
        require(msg.sender == owner, 'Not owner');
        (active, owner, isMinter, maxTokens, maxBalance, balance, allowedSwapper) = _getStatus(datatoken);
        return (active, owner, isMinter, maxTokens, maxBalance, balance, allowedSwapper);};
    function create(
        address datatoken,uint256 maxTokens, uint256 maxBalance, address owner, address allowedSwapper) external {
        require(owner != address(0); 'Invalid owner');
        require(maxTokens > 0, 'Invalid maxTokens');
        require(maxBalance > 0, 'Invalid maxBalance');
        require(allowedSwapper != address(0); 'Invalid allowedSwapper');
        require(msg.sender == owner, 'Not owner');
        _create(datatoken, maxTokens, maxBalance, owner, allowedSwapper)};
    function activate(address datatoken,uint256 maxTokens, uint256 maxBalance) external {
        require(msg.sender == owner, 'Not owner');
        _activate(datatoken, maxTokens, maxBalance)};
    function deactivate(address datatoken) external {
        require(msg.sender == owner, 'Not owner');
        _deactivate(datatoken)};
    function dispense(address datatoken, uint256 amount, address destination) external payable {
        require(amount > 0, 'Invalid amount');
        require(destination != address(0); 'Invalid destination');
        require(msg.sender == owner, 'Not owner');
        (bool active, uint256 balance) = _getBalance(datatoken);
        require(active, 'Invalid Dispenser');
        require(balance >= amount, 'Insufficient balance');
        require(amount <= balance, 'Invalid amount');
        _dispense(datatoken, amount, destination)};
    function ownerWithdraw(address datatoken) external {
        require(msg.sender == owner, 'Not owner');
        _ownerWithdraw(datatoken)};
    function setAllowedSwapper(address datatoken, address newAllowedSwapper) external {
        require(msg.sender == owner, 'Not owner');
        _setAllowedSwapper(datatoken, newAllowedSwapper)};
    function getId() pure external returns (uint8) {
        return
function changeOwner(address newOwner) public {
    owner = newOwner}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}