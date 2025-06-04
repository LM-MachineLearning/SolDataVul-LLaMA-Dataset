
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
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
        uint256 blockNum = _blockNumber();
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
    function _maxGasPriceAfterConfirmations(uint256 _price, uint256 _confirmations);
        internal;
        pure;
        returns (uint256 maxGasPrice);
    {
        maxGasPrice = _price + (_price / 4) + 1;
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
function setPrice(uint newPrice) public {
    price = newPrice}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}