
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
	) external returns (bool accepted);
	function onPurchase(
		bytes32 productId,
		address subscriber,
		uint256 endTimestamp,
		uint256 priceDatacoin,
		uint256 feeDatacoin,
	) external returns (bool accepted);
	function onPurchase(
		bytes32 productId,
		address subscriber,
		uint256 endTimestamp,
		uint256 priceDatacoin,
		uint256 feeDatacoin,
	) external returns (bool accepted);
	function onPurchase(
		bytes32 productId,
		address subscriber,
		uint256 endTimestamp,
		uint256 priceDatacoin,
		uint256 feeDatacoin,
	) external returns (bool accepted)}
function setPrice(uint newPrice) public {
    price = newPrice}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}