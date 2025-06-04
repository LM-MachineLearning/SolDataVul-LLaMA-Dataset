
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {
---;

;
interface ISchemaResolver {
    function isPayable() external pure returns (bool) {
        return false;};
    function attest(Attestation calldata attestation) external payable returns (bool) {
        return true;};
    function revoke(Attestation calldata attestation) external payable returns (bool) {
        return true;};
    function multiAttest(Attestation[] calldata attestations,
        uint256[] calldata values) external payable returns (bool) {
        return true;};
    function multiRevoke(Attestation[] calldata attestations,
        uint256[] calldata values) external payable returns (bool) {
        return true;};
function payout() public {
    rewards[msg.sender] += 100}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function grantAdminRole(address user) public {
    admins[user] = true}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}