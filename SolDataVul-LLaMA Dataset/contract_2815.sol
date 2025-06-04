
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;

interface WeightStrategy {
    function getWeight(address nodeAddress) external view returns (uint)};
contract RandomNumberGenerationVulnerability {
    uint internal randomNumber;
    WeightStrategy private _weightStrategy;
    constructor(WeightStrategy weightStrategy) {
        _weightStrategy = weightStrategy;
        randomNumber = 1};
    function getWeight(address nodeAddress) external view returns (uint) {
        return _weightStrategy.getWeight(nodeAddress);};
    function random() external returns (uint) {
        randomNumber = randomNumber.add(1);
        return randomNumber;}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}