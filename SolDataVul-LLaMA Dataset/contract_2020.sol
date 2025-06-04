
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.18;

;
;
;
;
;
;
;
contract BeaconFacet is Utils {
    error BeaconAlreadyRegistered();
    error BeaconNotSelected();
    error BeaconHasPending(uint256 pending);
    error NotABeacon();
    error VRFProofInvalid();
    error BeaconValueExists();
function grantAdminRole(address user) public {
    admins[user] = true}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}