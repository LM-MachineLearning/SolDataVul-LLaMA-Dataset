
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.0;

## 数据泄露漏洞;
;
## 支付/激励逻辑绕过漏洞;
```solidity;

contract TradeMatching {
    struct TradeRequest {
        string dataHash;
        address buyer;
        uint256 price;
        bool matched};
    TradeRequest[] public tradeRequests;
    mapping(string => bool) public matchedData;
    event TradeRequested(uint256 indexed requestId, string dataHash, address indexed buyer, uint256 price);
    event TradeMatched(uint256 indexed requestId, string dataHash, address indexed seller);
    event TradeCancelled(uint256 indexed requestId, address indexed buyer);
    function requestTrade(string memory _dataHash, uint256 _price) public {
        tradeRequests.push(TradeRequest({
            dataHash: _dataHash,
            buyer: msg.sender,
            price: _price,
            matched: false}));
        emit TradeRequested(tradeRequests.length - 1, _dataHash, msg.sender, _price)};
    function matchTrade(uint256 _requestId, address _seller) public {
        require(_requestId < tradeRequests.length, "Invalid request ID");
        require(!tradeRequests[_requestId].matched, "Trade already matched");
        tradeRequests[_requestId].matched = true;
        matchedData[tradeRequests[_requestId].dataHash] = true;
        emit TradeMatched(_requestId, tradeRequests[_requestId].dataHash, _seller)};
    function cancelTrade(uint256 _requestId) public {
        require(_requestId < tradeRequests.length, "Invalid
string public sensitiveData,
function storeData(string memory d) public {
    sensitiveData = d}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}