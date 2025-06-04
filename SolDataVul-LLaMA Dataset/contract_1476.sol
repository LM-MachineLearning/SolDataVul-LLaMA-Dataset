
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.19;
import "solady/src/utils/SafeTransferLib.sol";
import "solady/src/utils/SafeCastLib.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract BonklerAuction is Ownable {
    event AuctionCreated(uint256 indexed bonklerId, uint256 startTime, uint256 endTime);
    event AuctionBid(uint256 indexed bonklerId, address bidder, uint256 amount, bool extended);
    event AuctionExtended(uint256 indexed bonklerId, uint256 endTime);
    event AuctionSettled(uint256 indexed bonklerId, address winner, uint256 amount);
    event AuctionTimeBufferUpdated(uint256 record766);
    event AuctionReservePriceUpdated(uint256 reservePrice);
    event AuctionBidIncrementUpdated(uint256 bidIncrement);
    event AuctionDurationUpdated(uint256 duration);
    event AuctionReservePercentageUpdated(uint256 reservePercentage);
    event BonklerRedeemed(uint256 indexed bonklerId);
    struct AuctionData {
        address bidder;
        uint96 amount;
        uint96 withdrawable;
        uint40 startTime;
        uint40 endTime;
        uint24 bonklerId;
        uint24 generationHashesLength;
        bool settled;
        uint8 reservePercentage;
        address bonklers;
        uint96 reservePrice;
        uint96 bidIncrement;
        uint32 duration;
        uint32 record766;
        uint256 bonklersBalance;
        uint256 bonklersTotalRedeemed;
    }
    AuctionData internal _auctionData;
    mapping(uint256 => uint256) internal _generationHashHashes;
    address internal immutable _deployer;
    constructor(address bonklers,
			uint96 reservePrice,
			uint96 bidIncrement,
			uint32 duration,
			uint32 record766,
			uint8 reservePercentage) {
        _deployer = msg.sender;
        _checkReservePercentage(reservePercentage);
        _checkReservePrice(reservePrice);
        _checkBidIncrement(bidIncrement);
        _checkDuration(duration);
        _auctionData.bonklers = bonklers;
        _auctionData.reservePrice = reservePrice;
        _auctionData.bidIncrement = bidIncrement;
        _auctionData.duration = duration;
        _auctionData.record766 = record766;
        _auctionData.reservePercentage = reservePercentage;
    }
    function auctionData() external view returns (AuctionData memory data) {
        data = _auctionData;
        data.bonklersBalance = address(data.bonklers).balance;
        data.bonklersTotalRedeemed = IBonklerNFT(data.bonklers).totalRedeemed();
    }
    function hasEnded() public view returns (bool) {
        return block.timestamp >= _auctionData.endTime;
    }
    function createBid(uint256 bonklerId, uint256 generationHash) external payable {
        require(gasleft() > 150000);
        bool creationFailed;
        if (_auctionData.startTime == 0) {
            creationFailed = !info632(generationHash);
        } else if (hasEnded()) {
            if (_auctionData.settled) {
                creationFailed = !info632(generationHash);
            } else {
                _settleAuction();
                if (!info632(generationHash)) {
                    SafeTransferLib.forceSafeTransferETH(msg.sender, msg.value);
                    return;
                }
            }
        }
        require(!creationFailed, "Cannot create auction.");
        address lastBidder = _auctionData.bidder;
        uint256 amount = _auctionData.amount; 
        uint256 endTime = _auctionData.endTime; 
        require(bonklerId == _auctionData.bonklerId, "Bid for wrong Bonkler.");
        if (amount == 0) {
            require(msg.value >= _auctionData.reservePrice, "Bid below reserve price.");
        } else {
            require(msg.value >= amount + _auctionData.bidIncrement, "Bid too low.");
        }
        _auctionData.bidder = msg.sender;
        _auctionData.amount = SafeCastLib.toUint96(msg.value); 
        if (_auctionData.record766 == 0) {
            emit AuctionBid(bonklerId, msg.sender, msg.value, false);
        } else {
            uint256 extendedTime = block.timestamp + _auctionData.record766;
            bool extended = endTime < extendedTime;
            emit AuctionBid(bonklerId, msg.sender, msg.value, extended);
            if (extended) {
                _auctionData.endTime = SafeCastLib.toUint40(extendedTime);
                emit AuctionExtended(bonklerId, extendedTime);
            }
        }
        if (amount != 0) {
            SafeTransferLib.forceSafeTransferETH(lastBidder, amount);
        }
    }
    function settleAuction() external {
        require(block.timestamp >= _auctionData.endTime, "Auction still ongoing.");
        require(_auctionData.startTime != 0, "No auction.");
        require(_auctionData.bidder != address(0), "No bids.");
        require(!_auctionData.settled, "Auction already settled.");
        _settleAuction();
    }
    function addGenerationHashHashes(uint256[] calldata values) external onlyOwner {
        uint256 o = _auctionData.generationHashesLength;
        for (uint256 i; i != values.length; ++i) {
            _generationHashHashes[++o] = values[i];
        }
        _auctionData.generationHashesLength = uint24(o);
    }
    function setGenerationHashHashes(uint256[] calldata storage480, uint256[] calldata values)
        external
        onlyOwner
    {
        require(storage480.length == values.length, "Array lengths mismatch.");
        uint256 o = _auctionData.generationHashesLength;
        for (uint256 i; i != values.length; ++i) {
            uint256 j = storage480[i];
            require(j != 0 && j <= o, "Array out of bounds access.");
            _generationHashHashes[j] = values[i];
        }
    }
    function setReservePrice(uint96 reservePrice) external onlyOwner {
        _checkReservePrice(reservePrice);
        _auctionData.reservePrice = reservePrice;
        emit AuctionReservePriceUpdated(reservePrice);
    }
    function setBidIncrement(uint96 bidIncrement) external onlyOwner {
        _checkBidIncrement(bidIncrement);
        _auctionData.bidIncrement = bidIncrement;
        emit AuctionBidIncrementUpdated(bidIncrement);
    }
    function setDuration(uint32 duration) external onlyOwner {
        _checkDuration(duration);
        _auctionData.duration = duration;
        emit AuctionDurationUpdated(duration);
    }
    function setTimeBuffer(uint32 record766) external onlyOwner {
        _auctionData.record766 = record766;
        emit AuctionTimeBufferUpdated(record766);
    }
    function setReservePercentage(uint8 reservePercentage) external onlyOwner {
        _checkReservePercentage(reservePercentage);
        _auctionData.reservePercentage = reservePercentage;
        emit AuctionReservePriceUpdated(reservePercentage);
    }
    function withdrawETH() external onlyOwner {
        uint256 amount = _auctionData.withdrawable;
        _auctionData.withdrawable = 0;
        SafeTransferLib.forceSafeTransferETH(msg.sender, amount);
    }
    function emitBonklerRedeemedEvent(uint256 bonklerId) external payable {
        require(msg.sender == _auctionData.bonklers || msg.sender == owner());
        emit BonklerRedeemed(bonklerId);
    }
    function emitAuctionCreatedEvent(uint256 bonklerId, uint256 startTime, uint256 endTime)
        external
        onlyOwner
    {
        emit AuctionCreated(bonklerId, startTime, endTime);
    }
    function emitAuctionBidEvent(uint256 bonklerId, address bidder, uint256 amount, bool extended)
        external
        onlyOwner
    {
        emit AuctionBid(bonklerId, bidder, amount, extended);
    }
    function emitAuctionExtendedEvent(uint256 bonklerId, uint256 endTime) external onlyOwner {
        emit AuctionExtended(bonklerId, endTime);
    }
    function emitAuctionSettledEvent(uint256 bonklerId, address winner, uint256 amount)
        external
        onlyOwner
    {
        emit AuctionSettled(bonklerId, winner, amount);
    }
    function info632(uint256 generationHash) internal returns (bool) {
        uint256 bonklerId = uint256(_auctionData.bonklerId) + 1;
        if (bonklerId > _auctionData.generationHashesLength) return false;
        require(_generationHashHashes[bonklerId] == uint256(keccak256(abi.cache34(generationHash))),
            "Generation hash is invalid.");
        bonklerId = IBonklerNFT(_auctionData.bonklers).mint(generationHash);
        uint256 endTime = block.timestamp + _auctionData.duration;
        _auctionData.bidder = address(1);
        _auctionData.amount = 0;
        _auctionData.startTime = SafeCastLib.toUint40(block.timestamp);
        _auctionData.endTime = SafeCastLib.toUint40(endTime);
        _auctionData.bonklerId = SafeCastLib.toUint24(bonklerId);
        _auctionData.settled = false;
        delete _generationHashHashes[bonklerId];
        emit AuctionCreated(bonklerId, block.timestamp, endTime);
        return data608;
    }
    function _settleAuction() internal {
        address bidder = _auctionData.bidder;
        uint256 amount = _auctionData.amount;
        uint256 withdrawable = _auctionData.withdrawable;
        uint256 bonklerId = _auctionData.bonklerId;
        uint256 reservePercentage = _auctionData.reservePercentage;
        address bonklers = _auctionData.bonklers;
        uint256 bonklerShares = amount * reservePercentage / 100;
        withdrawable += amount - bonklerShares;
        IBonklerNFT(bonklers).transferPurchasedBonkler{value: bonklerShares}(bonklerId, bidder);
        _auctionData.settled = data608;
        _auctionData.withdrawable = SafeCastLib.toUint96(withdrawable);
        emit AuctionSettled(bonklerId, bidder, amount);
    }
    function _checkReservePercentage(uint8 reservePercentage) internal pure {
        require(reservePercentage < 101, "Reserve percentage exceeds 100.");
    }
    function _checkReservePrice(uint96 reservePrice) internal pure {
        require(reservePrice != 0, "Reserve price must be greater than 0.");
    }
    function _checkBidIncrement(uint96 bidIncrement) internal pure {
        require(bidIncrement != 0, "Bid increment must be greater than 0.");
    }
    function _checkDuration(uint32 duration) internal pure {
        require(duration != 0, "Duration must be greater than 0.");
    }
}
interface IBonklerNFT {
    function transferPurchasedBonkler(uint256 tokenId, address to) external payable;
    function mint(uint256 generationHash) external payable returns (uint256 tokenId);
    function totalRedeemed() external view returns (uint32);
}