
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
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
    function onTokenTransfer(address sender, uint256 amount, bytes calldata data) external};
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}