
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity <=0.7.0;

Contract source code:;

contract DataTrading {
    address payable seller;
    address payable buyer;
    uint256 price;
    string data;
    uint256 balance;
    constructor(address payable _seller, address payable _buyer, uint256 _price, string memory _data) public {
        seller = _seller;
        buyer = _buyer;
        price = _price;
        data = _data;
        balance = msg.value};
    fallback() external payable {
        if (msg.sender == seller) {
            require(msg.value > price, "Payment amount not valid");
            seller.transfer(msg.value);
            balance -= msg.value} else if (msg.sender == buyer) {
            require(msg.value == price, "Payment amount not valid");
            seller.transfer(msg.value);
            balance -= msg.value} else {
            require(false, "Sender not authorized")};
    function refund() external {
        require(msg.sender == buyer, "Sender not authorized");
        require(balance > 0, "Nothing to refund");
        seller.transfer(balance)};
Contract source code:;

contract DataTrading {
    address payable seller;
    address payable buyer;
    uint256 price;
    string data;
    uint256 balance;
    constructor(address payable _seller, address payable _buyer, uint256 _price, string memory _data) public {
        seller = _seller;
        buyer = _buyer;
        price = _price;
        data = _data;
        balance = msg.value};
    fallback() external payable {
        if (msg.sender == seller) {
            require(msg.value > price, "Payment amount not valid");
            seller.transfer(msg.value);
            balance -= msg.value} else if (msg.sender == buyer) {
            require(msg.value == price, "Payment amount not valid");
            seller.transfer(msg.value);
            balance -= msg.value} else {
            require(false, "Sender not authorized")};
    function refund() external {
        require(msg.sender == buyer, "Sender not authorized");
        require(balance > 0, "Nothing to refund");
        seller.transfer(balance)};
Contract source code:;

contract DataTrading {
    address payable seller;
    address payable buyer;
    uint256 price;
    string data;
    uint256 balance;
    constructor(address payable _seller, address payable _buyer, uint256 _price, string memory _data) public {
        seller = _seller;
        buyer = _buyer;
        price = _price;
        data = _data;
        balance = msg.value};
    fallback() external payable {
        if (msg.sender == seller) {
            require(msg.value > price, "Payment amount not valid");
            seller.transfer(msg.value);
            balance -= msg.value} else if (msg.sender == buyer) {
            require(msg.value == price, "Payment amount not valid");
            seller.transfer(msg.value);
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}