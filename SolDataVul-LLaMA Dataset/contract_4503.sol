
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
contract TransactionRequestInterface {
    function execute() public returns (bool);
    function cancel() public returns (bool);
    function claim() public payable returns (bool);
    function proxy(address recipient, bytes callData) public payable returns (bool);
    function requestData() public view returns (address[6], bool[3], uint[15], uint8[1]);
    function callData() public view returns (bytes);
    function refundClaimDeposit() public returns (bool);
    function sendFee() public returns (bool);
    function sendBounty() public returns (bool);
    function sendOwnerEther() public returns (bool);
    function sendOwnerEther(address recipient) public returns (bool);
}
