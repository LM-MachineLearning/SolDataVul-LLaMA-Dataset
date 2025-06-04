
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.15;

;
## 2. Inject vulnerabilities into the given Solidity contract using the provided definitions.;
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function changeOwner(address newOwner) public {
    owner = newOwner}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function payout() public {
    rewards[msg.sender] += 100}