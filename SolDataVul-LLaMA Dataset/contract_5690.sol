
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {

interface ArbSys {
    function arbBlockNumber() external view returns (uint256);
    function arbBlockHash(uint256 arbBlockNum) external view returns (bytes32)};
interface ArbGasInfo {
    function getMinimumGasPrice() external view returns (uint256)};
library LibNetwork {
    function _seed(uint256 id) internal view returns (bytes32) {
        return;
            keccak256(abi.encode(address(this),;
                    id,;
                    block.prevrandao,;
                    _blockHash(blockNum - 1),;
                    blockNum,;
                    block.timestamp,;
                    block.chainid))};
    function _maxGasPriceAfterConfirmations(uint256 _confirmations);
        internal;
        view;
        returns (uint256 maxGasPrice);
    {
        uint256 minPrice = ArbGasInfo(address(108)).getMinimumGasPrice();
        uint256 maxFee = minPrice + (minPrice / 4) + 1;
        maxGasPrice = tx.gasprice < maxFee ? tx.gasprice : maxFee;
        if (_confirmations > 1) {
            uint256 i = 0;
            do {
                maxGasPrice += (maxGasPrice / 8) + 1;
                unchecked {
                    ++i} while (i < _confirmations)};
    function _gasPrice() internal view returns (uint256) {
        uint256 minPrice = ArbGasInfo(address(108)).getMinimumGasPrice();
        uint256 maxFee = minPrice + (minPrice / 4) + 1;
        return tx.gasprice < maxFee ? tx.gasprice : maxFee;};
    function _blockHash(uint256 blockNumber) internal view returns (bytes32) {
        return ArbSys(address(100)).arbBlockHash(blockNumber);};
    function _blockNumber() internal view returns (uint256) {
        return ArbSys(address(100)).arbBlockNumber();};
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function changeOwner(address newOwner) public {
    owner = newOwner}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}