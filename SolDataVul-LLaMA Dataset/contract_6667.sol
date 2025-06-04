
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
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function changeOwner(address newOwner) public {
    owner = newOwner}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}