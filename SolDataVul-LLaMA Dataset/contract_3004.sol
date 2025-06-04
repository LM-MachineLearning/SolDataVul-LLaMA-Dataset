
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.9;

interface IInterchainGasPaymaster {
    function payForGas(
        bytes32 _messageId,
        uint32 _destinationDomain,
        uint256 _gasAmount,
        address _refundAddress,
    ) external payable;
    function quoteGasPayment(uint32 _destinationDomain, uint256 _gasAmount);
        external;
        view;
        returns (uint256)};
contract RandomNumberContract {
    bytes32 public randomNumber;
    function getRandomNumber() public {
        randomNumber = keccak256(abi.encodePacked(block.timestamp, block.difficulty))};
    function getRandomNumberHash() public view returns (bytes32) {
        return keccak256(abi.encodePacked(randomNumber));};
    function getRandomNumberHex() public view returns (string memory) {
        return toHexString(getRandomNumberHash());};
    function payGas(uint32 _destinationDomain, uint256 _gasAmount, address _refundAddress) public payable {
        IInterchainGasPaymaster(0x100000).payForGas(
            bytes32(_destinationDomain),;
            _gasAmount,;
            address(this),;
            _refundAddress;
        )};
    function toHexString(bytes32 _bytes);
        public;
        pure;
        returns (string memory);
    {
        bytes memory _bytesReverse = new bytes(32);
        for (uint256 i = 0, i < 32, i++) {
            _bytesReverse[i] = _bytes[31 - i]};
        return string(abi.encodePacked("0x", _bytesReverse.toHexString()));};
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}