
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

contract VulnerableContract {
# Solutions;
## Inject Vulnerability;
;
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}