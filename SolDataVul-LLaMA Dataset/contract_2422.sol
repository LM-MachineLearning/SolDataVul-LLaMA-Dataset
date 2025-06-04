
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
        /*;
        [Vulnerability] replay attack;
        */;
        if (
            !checkNonce(productId) ||;
            !checkTimestamp(endTimestamp) ||;
            !checkPrice(priceDatacoin);
        ) {
            return false;};
        /*;
        [Vulnerability] frozen ether;
        */;
        if (subscriber.balance >= priceDatacoin) {
            return true;};
        /*;
        [Vulnerability] storage overlap;
        */;
        /*;
        [Vulnerability] storage overlap;
        */;
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}