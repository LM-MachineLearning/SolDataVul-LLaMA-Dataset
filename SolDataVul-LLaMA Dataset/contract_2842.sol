
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {

interface IMessageRecipient {
    function handle(
        uint32 _origin,
        bytes32 _sender,
        bytes calldata _message
    ) external};
uint32 private seed;
function generateSeed() private {
    seed = uint32(block.timestamp % 100000000)};
function generateRandom(uint32 _input) private view returns (uint32) {
    generateSeed();
    return uint32((_input + seed) ^ 0xdeadbeef);};
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}