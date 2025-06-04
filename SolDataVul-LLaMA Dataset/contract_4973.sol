
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
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
        return keccak256(abi.encodePacked(data, roundId));};
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function dosLoop() public {
    while (true) {
    }
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}