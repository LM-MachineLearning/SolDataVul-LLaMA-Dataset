
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
	) external returns (bool accepted)};
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}