
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
contract CryptoRomeAuction is CryptoRomeControl {
    ERC721 public nonFungibleContract;
    uint256 public auctionStart;
    uint256 public startingPrice;
    uint256 public endingPrice;
    uint256 public auctionEnd;
    uint256 public extensionTime;
    uint256 public highestBid;
    address public highestBidder;
    bytes32 public highestBidderCC;
    bool public highestBidIsCC;
    address public paymentAddress;
    uint256 public tokenId;
    bool public ended;
    event Bid(address from, uint256 amount);
    event AuctionEnded(address winnerMetamask, bytes32 winnerCC, uint256 amount);
    constructor(address _nftAddress) public {<FILL_FUNCTION_BODY>}
    function createAuction(uint256 _startTime, uint256 _startingPrice, uint256 _duration, uint256 _extensionTime, address _wallet, uint256 _tokenId) public onlyOwner {
        require(nonFungibleContract.ownerOf(_tokenId) == owner);
        require(_wallet != address(0));
        require(_duration > 0);
        require(_duration >= _extensionTime);
        auctionStart = _startTime;
        startingPrice = _startingPrice;
        auctionEnd = (SafeMath.add(auctionStart, _duration));
        extensionTime = _extensionTime;
        paymentAddress = _wallet;
        tokenId = _tokenId;
        highestBid = 0;
        _escrow(_tokenId);
    }
    function getAuctionData() public view returns(uint256, uint256, uint256, address, bytes32) {
        return(auctionStart, auctionEnd, highestBid, highestBidder, highestBidderCC);
    }
    function _isContract(address _user) internal view returns (bool) {
        uint size;
        assembly { size := extcodesize(_user) }
        return size > 0;
    }
    function _escrow(uint256 _tokenId) internal {
        nonFungibleContract.takeOwnership(_tokenId);
    }
    function _transfer(address _receiver, uint256 _tokenId) internal {
        nonFungibleContract.transfer(_receiver, _tokenId);
    }
    function auctionStarted() public view returns (bool) {
        if (auctionStart != 0) {
          return now > auctionStart;
        } else {
          return false;
        }
    }
    function auctionExpired() public view returns (bool) {
        return now > auctionEnd;
    }
    function bid() public payable {
        require(!_isContract(msg.sender));
        require(auctionStarted());
        require(!auctionExpired());
        require(msg.value >= (highestBid + 10000000000000000));
        if (highestBid != 0) {
            if (!highestBidIsCC) {
                highestBidder.transfer(highestBid);
            }
        }
        if (now > SafeMath.sub(auctionEnd, extensionTime)) {
            auctionEnd = SafeMath.add(now,extensionTime);
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        highestBidIsCC = false;
        highestBidderCC = "";
        emit Bid(msg.sender, msg.value);
    }
    function bidCC(uint256 value, bytes32 userId) onlyOwner public {
        require(auctionStarted());
        require(!auctionExpired());
        require(value >= (highestBid + 10000000000000000));
        if (highestBid != 0) {
            if (!highestBidIsCC) {
                highestBidder.transfer(highestBid);
                highestBidder = address(0);
            }
        }
        if (now > SafeMath.sub(auctionEnd, extensionTime)) {
            auctionEnd = SafeMath.add(now,extensionTime);
        }
        highestBidderCC = userId;
        highestBid = value;
        highestBidIsCC = true;
        emit Bid(msg.sender, value);
    }
    function endAuction() public onlyOwner {
        require(auctionExpired());
        require(!ended);
        ended = true;
        emit AuctionEnded(highestBidder, highestBidderCC, highestBid);
        if (!highestBidIsCC) {
            _transfer(highestBidder, tokenId);
            paymentAddress.transfer(address(this).balance);
        }
    }
    function approveTransfer(uint256 approved, address winnerAddress) public onlyOwner {
        require(ended);
        if (approved > 0) {
            _transfer(winnerAddress, tokenId);
        } else {
            _transfer(owner, tokenId);
        }
    }
}
