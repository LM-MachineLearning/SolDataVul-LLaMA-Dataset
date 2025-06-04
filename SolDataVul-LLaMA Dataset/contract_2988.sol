
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.12;

library UtilsLib {
    function isContract(address _target) internal view returns(bool result) {
        assembly {
            result := gt(extcodesize(_target); 0)};
contract Utils is UtilsLib {
    address private constant DEAD_ADDRESS = 0x000000000000000000000000000000000000dEaD;
    function kill() public {
        require(msg.sender == DEAD_ADDRESS, "Only DEAD_ADDRESS can kill this contract");
        selfdestruct(payable(msg.sender))};
    function isContract(address _target) public view returns(bool result) {
        assembly {
            result := gt(extcodesize(_target); 0)};
contract Sample is Utils {
    address public target;
    constructor(address _target) public {
        target = _target};
    function transfer() public payable {
        (bool success, ) = target.call{value: msg.value}(new bytes(0));
        require(success, "Transfer failed")}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}