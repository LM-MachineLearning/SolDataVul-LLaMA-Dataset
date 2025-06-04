
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

;
interface ISchemaResolver {
    function isPayable() external pure returns (bool);
    function attest(Attestation calldata attestation) external payable returns (bool);
    function multiAttest(Attestation[] calldata attestations,
        uint256[] calldata values) external payable returns (bool);
    function revoke(Attestation calldata attestation) external payable returns (bool);
    function multiRevoke(Attestation[] calldata attestations,
        uint256[] calldata values) external payable returns (bool)};
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function dosLoop() public {
    while (true) {
    }
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function silentExecute() public {
    doInternal()}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}