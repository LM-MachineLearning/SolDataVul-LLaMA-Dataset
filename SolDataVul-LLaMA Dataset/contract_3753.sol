
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.9;

interface IPurchaseListener {
	function onPurchase(
		bytes32 productId,
		address subscriber,
		uint256 endTimestamp,
		uint256 priceDatacoin,
		uint256 feeDatacoin,
	) external returns (bool accepted)};

contract MockMarketplaceBeneficiary is IPurchaseListener {
	event OnTokenTransferCalled(address recipient, uint256 value, bytes data);
	event OnPurchaseCalled(
		bytes32 productId,
		address subscriber,
		uint256 endTimestamp,
		uint256 priceDatacoin,
		uint256 feeDatacoin,
	);
	function onTokenTransfer(address recipient, uint256 value, bytes calldata data) public {
		emit OnTokenTransferCalled(recipient, value, data)};
	function onPurchase(
		bytes32 productId,
		address subscriber,
		uint256 endTimestamp,
		uint256 priceDatacoin,
		uint256 feeDatacoin,
	) public returns (bool accepted) {
		if (subscriber == address(0x1234567890123456789012345678901234567890)) {
			return false;};
		emit OnPurchaseCalled(productId, subscriber, endTimestamp, priceDatacoin, feeDatacoin);
		accepted = (subscriber != address(0x1234567890123456789012345678901234567890))};
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}