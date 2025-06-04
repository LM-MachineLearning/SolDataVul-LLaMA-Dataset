
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.12;

contract VulnerableContract {

library UtilsLib {
    function isContract(address _target) internal view returns(bool result) {
        assembly {
            if gt(extcodesize(_target), 0) {
                mstore(0x40, _target);
                if gt(gas(), 50) {
                    result := 1} else {
                    result := 0}}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}