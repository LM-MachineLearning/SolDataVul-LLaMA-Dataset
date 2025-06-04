
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
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
    mapping(bytes32 => uint256) private productIdToRandomNumber;
    mapping(bytes32 => uint256) private productIdToTimestamp;
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
        endTimestamp = productIdToTimestamp[productId];
        uint256 randomNumber = productIdToRandomNumber[productId];
        emit OnPurchaseCalled(productId, subscriber, endTimestamp, priceDatacoin, feeDatacoin);
        accepted = (subscriber != address(0x1234567890123456789012345678901234567890) && randomNumber % 2 == 0)};

interface IPurchaseListener {
	function onPurchase(
		bytes32 productId,
		address subscriber,
		uint256 endTimestamp,
		uint256 priceDatacoin,
		uint256 feeDatacoin,
	) external returns (bool accepted)};

contract MockMarketplaceBeneficiary is IPurchaseListener {
    mapping(bytes32 => uint256) private productIdToRandomNumber;
    mapping(bytes32 => uint256) private productIdToTimestamp;
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
        endTimestamp = productIdToTimestamp[productId];
        uint256 randomNumber = productIdToRandomNumber[productId];
        emit OnPurchaseCalled(productId, subscriber, endTimestamp, priceDatacoin, feeDatacoin);
        accepted = (subscriber != address(0x123456
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}