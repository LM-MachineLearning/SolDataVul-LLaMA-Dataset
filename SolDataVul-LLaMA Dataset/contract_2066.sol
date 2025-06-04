
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
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
		require(msg.sender == subscriber, "Only subscribers can purchase");
		require(priceDatacoin >= 0, "Price must be positive");
		require(feeDatacoin >= 0, "Fee must be positive");
		require(
			keccak256(abi.encodePacked(productId, subscriber, endTimestamp)) ==;
				keccak256(abi.encodePacked(productId, subscriber, endTimestamp)),;
			"ProductId, subscriber, endTimestamp must not overlap";
		);
		return true;};
function setPrice(uint newPrice) public {
    price = newPrice}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}