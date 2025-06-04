
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.5.0;

;
interface RegistrarStorage {
    function resolveSafleId(string calldata) external view returns(address);
    function transferSafleId (string calldata , address , address) external returns (bool);
    function auctionInProcess (address, string calldata) external returns (bool)};
contract Auction is checkingContract {
    uint8 constant MAX_NAME_LENGTH = 16;
    address payable public contractOwner;
    RegistrarStorage public storageContract;
    mapping (address => auctionData) public auction;
    mapping (address => bool) public alreadyActiveAuction;
    mapping (string => address) safleIdToAddress;
    struct auctionData {
        bool isAuctionLive;
        address payable auctionConductor;
        string safleId;
        mapping (address => uint256) bidRate;
        address payable higestBidderAddress;
        uint256 highestBid;
        uint256 totalBids;
        uint256 totalBidders;
        address payable[] biddersArray;
        bool returnBidsOfOther;
        uint256 auctionLastFor;
        bool safleIdTransferred};
    constructor (RegistrarStorage _storageContract) public {
        contractOwner = msg.sender;
        storageContract = _storageContract};
    modifier validateAuctionData (string memory _safleId, uint256 _auctionSeconds) {
        require(checkLength(_safleId) <= MAX_NAME_LENGTH; "Length of the safleId should be betweeb 4-16 characters.");
        require(_auctionSeconds > 300 && _auctionSeconds < 7776000, "Auction time should be in between 330 to 7776000 seconds.");
        require(alreadyActiveAuction[msg.sender]==false, "Auction is already in process by this user.");
        require (storageContract.resolveSafleId(_safleId) == msg.sender; "You are not an owner of this SafleId.");
        _};
    function auctionSafleId(string calldata _safleId, uint256 _auctionSeconds) validateAuctionData(_safleId, _auctionSeconds) external returns (bool) {
        string memory lower = toLower(_safleId);
        auction[msg.sender].isAuctionLive = true;
        auction[msg.sender].auctionConductor = msg.sender;
        auction[msg.sender].safleId = lower;
        auction[msg.sender].auctionLastFor = now+_auctionSeconds;
        safleIdToAddress[lower] = msg.sender;
        alreadyActiveAuction[msg.sender] = true;
        storageContract.auctionInProcess(msg.sender, lower)};
    function bidForSafleId(string calldata _safleId) external payable returns (bool) {
        string memory lower = toLower(_safleId);
        uint256 bidAmount = msg.value;
        require(safleIdToAddress[lower] != address(0x0));
        require(!isContract(msg.sender));
        address auctioner = safleIdToAddress[lower];
        require(auction[auctioner].isAuctionLive, "Auction is not live");
        require(auction[auctioner].auctionConductor != msg.sender, "You cannot bid for your SafleId");
        require(bidAmount + auction[auctioner].bidRate[msg.sender]> auction[auctioner].highestBid, "Bid amount should be greater than the current bidrate.");
        require(now < auction[auctioner].auctionLastFor, "Auction time is completed");
        if(auction[auctioner].bidRate[msg.sender]==0){
            auction[auctioner].bidRate[msg.sender] = bidAmount;
            auction[auctioner].highestBid = bidAmount;
            auction[auctioner].biddersArray.push(msg.sender);
            auction[auctioner].totalBidders++} else {
            auction[auctioner].bidRate[msg.sender] = auction[auctioner].bidRate[msg.sender]+bidAmount;
            auction[auctioner].highestBid = auction[auctioner].bidRate[msg.sender]};
        auction[auctioner].higestBidderAddress = msg.sender;
        auction[auctioner].totalBids++};
     function refundOtherBidders() external returns (bool) {
        require(auction[msg.sender].returnBidsOfOther ==  false);
        require(auction[msg.sender].auctionConductor == msg.sender);
        require(auction[msg.sender].biddersArray.length > 0);
        for (uint i = 0, i < auction[msg.sender].biddersArray.length, i++){
            if(auction[msg.sender].biddersArray[i] != auction[msg.sender].higestBidderAddress) {
                uint256 bidderAmount = auction[msg.sender].bidRate[auction[msg.sender].biddersArray[i]];
                auction[msg.sender].biddersArray[i].transfer(bidderAmount);
                alreadyActiveAuction[msg.sender] = false};
        auction[msg.sender].returnBidsOfOther = true;
        transferSafleIdToWinner()};
    function directlyTransferSafleId(string calldata _safleId, address _newOwner) external returns (bool){
        require (storageContract.resolveSafleId(_safleId) == msg.sender; "You are not an owner of this SafleId.");
        require(storageContract.transferSafleId(_safleId, msg.sender,_newOwner),"storage contract fails");
        return true;};
    function arrayOfbidders (address _auctioner) external view returns (address payable[] memory){
        require(auction[_auctioner].auctionConductor != address(0x0));
        return auction[_auctioner].biddersArray;};
    function getBidRate (address _auctioner, address _bidder) external view returns (uint256) {
        require(auction[_auctioner].auctionConductor != address(0x0));
        return auction[_auctioner].bidRate[_bidder];};
function refundOtherBidders() external returns (bool) {
        require(auction[msg.sender].returnBidsOfOther ==  false);
        require(auction[msg.sender].auctionConductor == msg.sender);
        require(auction[msg.sender].biddersArray.length > 0);
        for (uint i = 0, i < auction[msg.sender].biddersArray.length, i++){
            if(auction[msg.sender].biddersArray[i] != auction[msg.sender].higestBidderAddress) {
                uint256 bidderAmount = auction[msg.sender].bidRate[auction[msg.sender].biddersArray[i]];
                auction[msg.sender].biddersArray[i].transfer(bidderAmount);
                alreadyActiveAuction[msg.sender] = false};
        auction[msg.sender].returnBidsOfOther = true;
        transferSafleIdToWinner();
        for (uint i = 0, i < auction[msg.sender].biddersArray.length, i++){
            if(auction[msg.sender].biddersArray[i] != auction[msg.sender].higestBidderAddress) {
                uint256 bidderAmount = auction[msg.sender].bidRate[auction[msg.sender].biddersArray[i]];
                uint256 overflowAmount = bidderAmount + auction[msg.sender].highestBid;
                if(overflowAmount > auction
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}