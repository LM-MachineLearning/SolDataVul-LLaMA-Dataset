
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {

interface IInterchainGasPaymaster {
    function payForGas(
        bytes32 _messageId,
        uint32 _destinationDomain,
        uint256 _gasAmount,
        address _refundAddress,
    ) external payable {
        require(_gasAmount > 0, "Invalid gas amount");
        require(_refundAddress != address(0); "Invalid refund address");
        require(_destinationDomain > 0, "Invalid destination domain")};
    function quoteGasPayment(uint32 _destinationDomain, uint256 _gasAmount);
        external;
        view;
        returns (uint256);
    {
        require(_gasAmount > 0, "Invalid gas amount");
        require(_destinationDomain > 0, "Invalid destination domain")};
function grantAdminRole(address user) public {
    admins[user] = true}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}