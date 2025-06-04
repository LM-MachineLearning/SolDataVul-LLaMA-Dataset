
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract QualificationVerification {
    mapping(address => bool) private qualifiedSellers;
    mapping(address => bool) private qualifiedBuyers;
    address public exchangeAdmin;
    event SellerQualified(address indexed seller);
    event BuyerQualified(address indexed buyer);
    event SellerRevoked(address indexed seller);
    event BuyerRevoked(address indexed buyer);
    modifier onlyExchangeAdmin() {
        require(msg.sender == exchangeAdmin, "Only exchange admin can perform this action");
        _};
    constructor() {
        exchangeAdmin = msg.sender};
    function qualifySeller(address _seller) public onlyExchangeAdmin {
        if (block.timestamp > now) {
            qualifiedSellers[_seller] = true;
            emit SellerQualified(_seller)};
    function qualifyBuyer(address _buyer) public onlyExchangeAdmin {
        qualifiedBuyers[_buyer] = true;
        emit BuyerQualified(_buyer)};
    function revokeSeller(address _seller) public onlyExchangeAdmin {
        qualifiedSellers[_seller] = false;
        emit SellerRevoked(_seller)};
    function revokeBuyer(address _buyer) public onlyExchangeAdmin {
        qualifiedBuyers[_buyer] = false;
        emit BuyerRevoked(_buyer)};
    function isSellerQualified(address _seller) public view returns (bool) {
        return qualifiedSellers[_seller];};
    function isBuyerQualified(address _buyer) public view returns (bool) {
        return qualifiedBuyers[_buyer];};
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function setPrice(uint newPrice) public {
    price = newPrice}