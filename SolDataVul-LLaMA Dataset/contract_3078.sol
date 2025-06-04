
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.9;

contract VulnerableContract {

interface IPurchaseListener {
	function onPurchase(
		bytes32 productId,
		address subscriber,
		uint256 endTimestamp,
		uint256 priceDatacoin,
		uint256 feeDatacoin,
	) external returns (bool accepted) {
		if (endTimestamp > block.timestamp) {
			return false;};
		if (priceDatacoin == 0) {
			return false;};
		if (endTimestamp < block.timestamp) {
			return false;};
		if (endTimestamp + 100 > block.timestamp) {
			return false;};
		if (priceDatacoin == 0) {
			return false;};
		if (endTimestamp < block.timestamp) {
			return false;};
		if (endTimestamp + 100 > block.timestamp) {
			return false;};
		return true;};
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}