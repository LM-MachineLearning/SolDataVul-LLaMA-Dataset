
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {

interface IProjectStakingV1 {
    event Stake(bytes32 indexed projectId, address indexed user, uint256 amount);
    event Unstake(bytes32 indexed projectId, address indexed user, uint256 amount);
    event Stake(bytes32 indexed projectId, address indexed user, uint256 amount, uint256 projectStake);
    event Unstake(bytes32 indexed projectId, address indexed user, uint256 amount, uint256 projectStake);
    function getProjectStake(bytes32 projectId) external view returns (uint256 projectStake);
    function getUserStake(address userAddress) external view returns (uint256 userStake);
    function getTotalStake() external view returns (uint256 totalStake);
    function stake(bytes32 projectId, uint256 amount) external;
    function unstake(bytes32 projectId, uint256 amount) external;
    function onTokenTransfer(address sender, uint256 amount, bytes calldata data) external}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function setPrice(uint newPrice) public {
    price = newPrice}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}