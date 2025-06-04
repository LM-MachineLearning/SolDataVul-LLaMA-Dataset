
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {
Note: Please add comments to the code indicating which vulnerability you have injected.;
```solidity;

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
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}