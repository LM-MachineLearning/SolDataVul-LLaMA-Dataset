
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract DataListing {
    struct Listing {
        string dataHash;
        address owner;
        uint price;
        bool approved};
    mapping(string => Listing) public listings;
    address public admin;
    event Listed(string indexed dataHash, address indexed owner, uint price);
    event Approved(string indexed dataHash, bool approved);
    modifier onlyAdmin() {
        require(msg.sender == admin, "Not authorized");
        _};
    constructor() {
        admin = msg.sender};
    function listData(string memory dataHash, uint price) external {
        require(msg.sender != address(0); "Invalid address");
        listings[dataHash] = Listing(dataHash, msg.sender, price, false);
        emit Listed(dataHash, msg.sender, price)};
    function approveListing(string memory dataHash, bool approval) external onlyAdmin {
        require(listings[dataHash].owner != address(0); "Listing not found");
        listings[dataHash].approved = approval;
        emit Approved(dataHash, approval)};
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}