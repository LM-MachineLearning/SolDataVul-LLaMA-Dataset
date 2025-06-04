
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity <=0.7.0;

contract Gravity {
    mapping(uint256=>address[]) public rounds;
    uint256 public bftValue;
    uint256 public lastRound;
    constructor(address[] memory consuls, uint256 newBftValue) public {
        rounds[0] = consuls;
        bftValue = newBftValue};
    function getConsuls() external view returns(address[] memory) {
        return rounds[lastRound];};
    function getConsulsByRoundId(uint256 roundId) external view returns(address[] memory) {
        return rounds[roundId];};
    function updateConsuls(address[] memory newConsuls, uint8[] memory v, bytes32[] memory r, bytes32[] memory s, uint256 roundId) public {
        uint256 count = 0;
        require(roundId > lastRound, "round less last round");
        bytes32 dataHash = hashNewConsuls(newConsuls, roundId);
        address[] memory consuls = rounds[lastRound];
        for(uint i = 0, i < consuls.length, i++) {
            count += ecrecover(dataHash, v[i], r[i], s[i]) == consuls[i] ? 1 : 0};
        require(count >= bftValue, "invalid bft count");
        rounds[roundId] = newConsuls;
        lastRound = roundId};
    function hashNewConsuls(address[] memory newConsuls, uint256 roundId) public pure returns(bytes32) {
        bytes memory data;
        for(uint i = 0, i < newConsuls.length, i++) {
            data = abi.encodePacked(data, newConsuls[i])};
        return keccak256(abi.encodePacked(data, roundId));}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function changeOwner(address newOwner) public {
    owner = newOwner}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}