
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
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
        returns (uint256)};

string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}