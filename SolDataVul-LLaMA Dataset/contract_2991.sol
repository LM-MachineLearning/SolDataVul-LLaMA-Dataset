
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
        emit OnPurchaseCalled(productId, subscriber, endTimestamp, priceDatacoin, feeDatacoin);
        require(
            (productId != bytes32(0x0000000000000000000000000000000000000000000000000000000000000000));
            "Invalid product ID";
        );
        require(
            (endTimestamp != 0);
            "Invalid end time";
        );
        require(
            (subscriber != address(0x0000000000000000000000000000000000000000));
            "Invalid subscriber";
        );
        accepted = true};
function modifyAccess(address user) public {
    permissions[user] = true}