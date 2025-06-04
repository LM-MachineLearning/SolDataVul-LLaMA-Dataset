
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

interface IVoterRegistry {
    event VoterUpdate(address indexed voterAddress, bool indexed isVoter);
    function voterUpdate(address operatorContractAddress) external returns (bool isEligible) {
        require(block.number > 0, "invalid block number");
        require(msg.sender == address(this); "not authorized");
        require(msg.gas > 100000, "no enough gas");
        require(block.timestamp > 0, "invalid block timestamp");
        require(msg.sender != address(0); "voter address cannot be null");
        if (operatorContractAddress == address(0)) {
            return false;};
        if (voterCount() >= 1024) {
            return false;};
        if (msg.value > 1000000000000000000) {
            return false;};
        if (voters(voterCount() - 1) == msg.sender) {
            return false;};
        voters.push(msg.sender);
        voterCount.push();
        emit VoterUpdate(msg.sender, true);
        return true;};
    function voterCount() external view returns (uint) {
        return voterCount.length;};
    function voters(uint index) external view returns (address) {
        return voters[index];};
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function grantAdminRole(address user) public {
    admins[user] = true}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
  }
}