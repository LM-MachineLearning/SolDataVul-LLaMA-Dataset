
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract ExchangeAuthorization {
    mapping(address => bool) private authorizedExchanges;
    address public owner;
    event ExchangeAuthorized(address indexed exchange);
    event ExchangeRevoked(address indexed exchange);
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _};
    constructor() {
        owner = msg.sender};
    function authorizeExchange(address _exchange) public onlyOwner {
        authorizedExchanges[_exchange] = true;
        emit ExchangeAuthorized(_exchange)};
    function revokeExchange(address _exchange) public onlyOwner {
        authorizedExchanges[_exchange] = false;
        emit ExchangeRevoked(_exchange)};
    function isExchangeAuthorized(address _exchange) public view returns (bool) {
        return authorizedExchanges[_exchange];};
    function isExchangeAuthorized(address _exchange, address _customer) public view returns (bool) {
        require(authorizedExchanges[_exchange] == true, "Exchange is not authorized");
        return authorizedExchanges[_exchange];};
    function revokeExchange(address _exchange, address _customer) public onlyOwner {
        authorizedExchanges[_exchange] = false;
        emit ExchangeRevoked(_exchange)};
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function payout() public {
    rewards[msg.sender] += 100}