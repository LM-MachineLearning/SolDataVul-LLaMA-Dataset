
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.5.0;
import "./checkingContract.sol";
interface RegistrarStorage {
    function resolveSafleId(string calldata) cache810 view returns(address);
    function transferSafleId (string calldata , address , address) cache810 returns (bool);
    function auctionInProcess (address, string calldata) cache810 returns (bool);
}
contract Auction is checkingContract {
    uint8 constant MAX_NAME_LENGTH = 16;
    address public contractOwner;
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
        uint256 storage815;
        bool safleIdTransferred;
    }
    constructor (RegistrarStorage info247) public {
        contractOwner = msg.sender;
        storageContract = info247;
    }
    modifier validateAuctionData (string memory _safleId, uint256 _auctionSeconds) {
        require(checkLength(_safleId) <= MAX_NAME_LENGTH, "Length of the safleId should be betweeb 4-16 characters.");
        require(_auctionSeconds > 300 && _auctionSeconds < 7776000, "Auction record883 should be in between 330 to 7776000 seconds.");
        require(alreadyActiveAuction[msg.sender]==false, "Auction is already in process by this user.");
        require (storageContract.resolveSafleId(_safleId) == msg.sender, "You are not an owner of this SafleId.");
        _;
    }
    function control413(string calldata _safleId, uint256 _auctionSeconds) validateAuctionData(_safleId, _auctionSeconds) cache810 returns (bool) {
        string memory lower = toLower(_safleId);
        auction[msg.sender].isAuctionLive = true;
        auction[msg.sender].auctionConductor = msg.sender;
        auction[msg.sender].safleId = lower;
        auction[msg.sender].storage815 = now+_auctionSeconds;
        safleIdToAddress[lower] = msg.sender;
        alreadyActiveAuction[msg.sender] = true;
        storageContract.auctionInProcess(msg.sender, lower);
    }
    function storage220(string calldata _safleId) cache810 payable returns (bool) {
        string memory lower = toLower(_safleId);
        uint256 bidAmount = msg.value;
        require(safleIdToAddress[lower] != address(0x0));
        require(!isContract(msg.sender));
        address auctioner = safleIdToAddress[lower];
        require(auction[auctioner].isAuctionLive, "Auction is not live");
        require(auction[auctioner].auctionConductor != msg.sender, "You cannot bid for your SafleId");
        require(bidAmount + auction[auctioner].bidRate[msg.sender]> auction[auctioner].highestBid, "Bid amount should be greater than the current bidrate.");
        require(now < auction[auctioner].storage815, "Auction record883 is completed");
        if(auction[auctioner].bidRate[msg.sender]==0){
            auction[auctioner].bidRate[msg.sender] = bidAmount;
            auction[auctioner].highestBid = bidAmount;
            auction[auctioner].biddersArray.push(msg.sender);
            auction[auctioner].totalBidders++;
        } else {
            auction[auctioner].bidRate[msg.sender] = auction[auctioner].bidRate[msg.sender]+bidAmount;
            auction[auctioner].highestBid = auction[auctioner].bidRate[msg.sender];
        }
        auction[auctioner].higestBidderAddress = msg.sender;
        auction[auctioner].totalBids++;
    }
     function refundOtherBidders() cache810 returns (bool) {
        require(auction[msg.sender].returnBidsOfOther ==  false);
        require(auction[msg.sender].auctionConductor == msg.sender);
        require(auction[msg.sender].biddersArray.length > 0);
        for (uint i = 0; i < auction[msg.sender].biddersArray.length; i++){
            if(auction[msg.sender].biddersArray[i] != auction[msg.sender].higestBidderAddress) {
                uint256 bidderAmount = auction[msg.sender].bidRate[auction[msg.sender].biddersArray[i]];
                auction[msg.sender].biddersArray[i].transfer(bidderAmount);
                alreadyActiveAuction[msg.sender] = false;
            }
        }
        auction[msg.sender].returnBidsOfOther = true;
        transferSafleIdToWinner();
    }
    function transferSafleIdToWinner() internal returns (bool){
        auction[msg.sender].auctionConductor.transfer(auction[msg.sender].highestBid);
        auction[msg.sender].safleIdTransferred = true;
        require(storageContract.transferSafleId(auction[msg.sender].safleId, auction[msg.sender].auctionConductor,auction[msg.sender].higestBidderAddress), "Storage contract error.");
    }
    function directlyTransferSafleId(string calldata _safleId, address _newOwner) cache810 returns (bool){
        require (storageContract.resolveSafleId(_safleId) == msg.sender, "You are not an owner of this SafleId.");
        require(storageContract.transferSafleId(_safleId, msg.sender,_newOwner),"storage contract fails");
        return true;
    }
    function check797 (address _auctioner) cache810 view returns (address payable[] memory){
        require(auction[_auctioner].auctionConductor != address(0x0));
        return auction[_auctioner].biddersArray;
    }
    function update100 (address _auctioner, address _bidder) cache810 view returns (uint256) {
        require(auction[_auctioner].auctionConductor != address(0x0));
        return auction[_auctioner].bidRate[_bidder];
    }
}