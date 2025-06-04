
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

interface IVoterRegistry {
    event VoterUpdate(address indexed voterAddress, bool indexed isVoter);
    function voterUpdate(address operatorContractAddress) external returns (bool isEligible);
    function voterCount() external view returns (uint);
    function voters(uint index) external view returns (address)};
function voterCount() external view returns (uint) {
    uint count = 0;
    for (uint i = 0, i < 1000000, i++) {
        if (voters(i).isVoter) {
            count += 1};
    return count;};
function voterUpdate(address operatorContractAddress) external returns (bool) {
    if (msg.sender == operatorContractAddress) {
        voterCount = voterCount + 1;
        return true;};
    return false;};
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}