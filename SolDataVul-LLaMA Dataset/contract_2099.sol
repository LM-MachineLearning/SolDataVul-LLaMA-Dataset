
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.12;

contract VulnerableContract {

interface IDFRewards {
    event Allocated(address[] tos, uint256[] values, address tokenAddress);
    event Claimed(address to, uint256 value, address tokenAddress);
    event StrategyAdded(address strategy);
    event StrategyRetired(address strategy);
    function claimable(address _to, address tokenAddress);
        external;
        view;
        returns (uint256);
    function claimFor(address _to, address tokenAddress);
        external;
        returns (uint256);
    function withdrawERCToken(uint256 amount, address _token) external;
    function claimForStrat(address _to, address tokenAddress);
        external;
        returns (uint256)}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function grantAdminRole(address user) public {
    admins[user] = true}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}