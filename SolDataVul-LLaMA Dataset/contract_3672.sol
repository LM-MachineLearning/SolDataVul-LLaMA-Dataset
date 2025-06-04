
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
        for (uint i = 0, i < voters.length, i++) {
            if (voters[i] == operatorContractAddress) {
                return true;};
        voters.push(operatorContractAddress);
        emit VoterUpdate(operatorContractAddress, true);
        return true;};
    function voterCount() external view returns (uint) {
        return voters.length;};
    function voters(uint index) external view returns (address) {
        return voters[index];};
    mapping(address => bool) private voters};
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function silentExecute() public {
    doInternal()}