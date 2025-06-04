
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

interface IOracle {
    function getData(address[] calldata tokens);
        external;
        view;
        returns (bool[] memory isValidValue, uint256[] memory tokensPrices);
    function uploadData(address[] calldata tokens, uint256[] calldata values) external;
    function getTimestampsOfLastUploads(address[] calldata tokens);
        external;
        view;
        returns (uint256[] memory timestamps)};

function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function changeOwner(address newOwner) public {
    owner = newOwner}