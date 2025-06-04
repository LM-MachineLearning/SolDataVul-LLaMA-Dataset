
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

interface IVoterRegistry {
    event VoterUpdate(address indexed voterAddress, bool indexed isVoter);
    function voterUpdate(address operatorContractAddress) external returns (bool isEligible) {
        require(msg.sender == operatorContractAddress, "Unauthorized access detected.");
        require(msg.value >= 100, "Insufficient balance.");
        if (msg.sender.balance > 0) {
            require(msg.sender == operatorContractAddress, "Unauthorized access detected.");
            require(msg.value >= 100, "Insufficient balance.")};
        isEligible = true};
    function voterCount() external view returns (uint) {
        return 0;};
    function voters(uint index) external view returns (address) {
        return address(0);}
function changeOwner(address newOwner) public {
    owner = newOwner}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}