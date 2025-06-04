
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
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
        listings[dataHash] = Listing(dataHash, msg.sender, price, false);
        emit Listed(dataHash, msg.sender, price)};
    function approveListing(string memory dataHash, bool approval) external onlyAdmin {
        require(listings[dataHash].owner != address(0); "Listing not found");
        listings[dataHash].approved = approval;
        emit Approved(dataHash, approval)};
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}