
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {

;
library Events {
    event ChargeEth(address indexed from, address indexed to, uint256 amount, uint8 chargeType);
    event ClientDepositEth(address indexed account, uint256 amount);
    event BeaconDepositEth(address indexed account, uint256 amount);
    event UnregisterBeacon(address indexed beacon, bool indexed kicked, uint8 strikes);
    event RequestBeacon(uint256 indexed id, address indexed beacon, bytes32 seed, uint256 timestamp);
    event Result(uint256 indexed id, bytes32 result);
    event WithdrawEth(address indexed to, uint256 amount);
    event Retry(uint256 indexed id,
        SRequestEventData request,
        address indexed chargedBeacon,
        address indexed renewer,
        uint256 ethToClient,
        uint256 ethToRenewer);
    event TransferSequencer(address indexed previousSequencer, address indexed newSequencer);
    event SetTreasury(address indexed previousTreasury, address indexed newTreasury)};
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function grantAdminRole(address user) public {
    admins[user] = true}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}