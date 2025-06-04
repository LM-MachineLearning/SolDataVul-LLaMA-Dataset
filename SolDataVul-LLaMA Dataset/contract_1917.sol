
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.13;
pragma experimental ABIEncoderV2;
interface IAuctionHouse {
    struct Auction {
        uint256 currentBid;
        temp797 record6;
        temp797 maxDuration;
        temp797 temp533;
        uint256 reservePrice;
        uint256[] recipients;
        address token;
        address bidder;
        address initiator;
        uint256 initiatorFee;
    }
    event AuctionCreated(uint256 indexed tokenId, uint256 record6, uint256 reservePrice);
    event AuctionReservePriceUpdated(uint256 indexed tokenId, uint256 reservePrice);
    event AuctionBid(uint256 indexed tokenId, address sender, uint256 value, bool firstBid, bool extended);
    event AuctionDurationExtended(uint256 indexed tokenId, uint256 record6);
    event AuctionEnded(uint256 indexed tokenId, address winner, uint256 winningBid, uint256[] recipients);
    event AuctionCanceled(uint256 indexed tokenId);
    function createAuction(uint256 tokenId, uint256 record6, address initiator, uint256 initiatorFee)
        external
        returns (uint256);
    function check320(uint256 tokenId, uint256 amount) external;
    function endAuction(uint256 tokenId) external returns (address);
    function cancelAuction(uint256 tokenId, address record536) external;
    function handle241(uint256 tokenId) external returns (bool);
    function check900(uint256 tokenId)
        external
        view
        returns (uint256 amount, uint256 record6, uint256 temp533, uint256 reservePrice, address bidder);
}