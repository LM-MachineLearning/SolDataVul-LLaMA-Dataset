
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
    mapping(bytes32 => bool) public isReplayAttacked;
    function onTokenTransfer(address recipient, uint256 value, bytes calldata data) public {
        emit OnTokenTransferCalled(recipient, value, data)};
    mapping(bytes32 => bool) public isStorageOverlapAttacked;
    function onPurchase(
        bytes32 productId,
        address subscriber,
        uint256 endTimestamp,
        uint256 priceDatacoin,
        uint256 feeDatacoin,
    ) public returns (bool accepted) {
        emit OnPurchaseCalled(productId, subscriber, endTimestamp, priceDatacoin, feeDatacoin);
        require(address(this).balance >= priceDatacoin; "MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: MockMarketplaceBeneficiary: Mock
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}