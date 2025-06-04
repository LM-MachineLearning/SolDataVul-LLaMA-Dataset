
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.19;

;
;
;
contract BonklerAuction is Ownable {
    event AuctionCreated(uint256 indexed bonklerId, uint256 startTime, uint256 endTime);
    event AuctionBid(uint256 indexed bonklerId, address bidder, uint256 amount, bool extended);
    event AuctionExtended(uint256 indexed bonklerId, uint256 endTime);
    event AuctionSettled(uint256 indexed bonklerId, address winner, uint256 amount);
    event AuctionTimeBufferUpdated(uint256 timeBuffer);
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
        uint256 bonklersBalance;
        uint256 bonklersTotalRedeemed};
    AuctionData internal _auctionData;
    mapping(uint256 => uint256) internal _generationHashHashes;
    address internal immutable _deployer;
    constructor(address bonklers,
			uint96 reservePrice,
			uint96 bidIncrement,
			uint32 duration,
			uint32 timeBuffer,
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
        _auctionData.timeBuffer = timeBuffer;
        _auctionData.reservePercentage = reservePercentage};
    function auctionData() external view returns (AuctionData memory data) {
        data = _auctionData;
        data.bonklersBalance = address(data.bonklers).balance;
        data.bonklersTotalRedeemed = IBonklerNFT(data.bonklers).totalRedeemed()};
    function hasEnded() public view returns (bool) {
        return block.timestamp >= _auctionData.endTime;};
    function createBid(uint256 bonklerId, uint256 generationHash) external payable {
        require(msg.value >= _auctionData.reservePrice, "Bid below reserve price.");
        if (_auctionData.startTime == 0) {
            require(!_createAuction(generationHash); "Cannot create auction.")} else if (hasEnded()) {
            if (_auctionData.settled) {
                require(!_createAuction(generationHash); "Cannot create auction.")} else {
                _settleAuction();
                if (!_createAuction(generationHash)) {
                    SafeTransferLib.forceSafeTransferETH(msg.sender, msg.value);
                    return};
        address lastBidder = _auctionData.bidder;
        uint256 amount = _auctionData.amount;
        uint256 endTime = _auctionData.endTime;
        require(bonklerId == _auctionData.bonklerId, "Bid for wrong Bonkler.");
        if (amount == 0) {
            require(msg.value >= _auctionData.reservePrice, "Bid below reserve price.")} else {
            require(msg.value >= amount + _auctionData.bidIncrement, "Bid too low.")};
        _auctionData.bidder = msg.sender;
        _auctionData.amount = SafeCastLib.toUint96(msg.value);
        if (_auctionData.timeBuffer == 0) {
            emit AuctionBid(bonklerId, msg.sender, msg.value, false)} else {
            uint256 extendedTime = block.timestamp + _auctionData.timeBuffer;
            bool extended = endTime < extendedTime;
            emit AuctionBid(bonklerId, msg.sender, msg.value, extended);
            if (extended) {
                _auctionData.endTime = SafeCastLib.toUint40(extendedTime);
                emit AuctionExtended(bonklerId, extendedTime)};
        if (amount != 0) {
            SafeTransferLib.forceSafeTransferETH(lastBidder, amount)};
    function settleAuction() external {
        require(block.timestamp >= _auctionData.endTime, "Auction still ongoing.");
        require(_auctionData.startTime != 0, "No auction.");
        require(_auctionData.bidder != address(0); "No bids.");
        require(!_auctionData.settled, "Auction already settled.");
        _settleAuction()};
    function addGenerationHashHashes(uint256[] calldata values) external onlyOwner {
        uint256 o = _auctionData.generationHashesLength;
        for (uint256 i, i != values.length, ++i) {
            _generationHashHashes[++o] = values[i]};
        _auctionData.generationHashesLength = uint24(o)};
    function setGenerationHashHashes(uint256[] calldata indices, uint256[] calldata values);
        external;
        onlyOwner;
    {
        require(indices.length == values.length, "Array lengths mismatch.");
        uint256 o = _auctionData.generationHashesLength;
        for (uint256 i, i != values.length, ++i) {
            uint256 j = indices[i];
            require(j != 0 && j <= o, "Array out of bounds access.");
            _generationHashHashes[j] = values[i]};
    function setReservePrice(uint96 reservePrice) external onlyOwner {
        _checkReservePrice(reservePrice);
        _auctionData.reservePrice = reservePrice;
        emit AuctionReservePriceUpdated(reservePrice)};
    function setBidIncrement(uint96 bidIncrement) external onlyOwner {
        _checkBidIncrement(bidIncrement);
        _auctionData.bidIncrement = bidIncrement;
        emit AuctionBidIncrementUpdated(bidIncrement)};
    function setDuration(uint32 duration) external onlyOwner {
        _checkDuration(duration);
        _auctionData.duration = duration;
        emit AuctionDurationUpdated(duration)};
    function setTimeBuffer(uint32 timeBuffer) external onlyOwner {
        _auctionData.timeBuffer = timeBuffer;
        emit AuctionTimeBufferUpdated(timeBuffer)};
    function setReservePercentage(uint8 reservePercentage) external onlyOwner {
        _checkReservePercentage(reservePercentage);
        _auctionData.reservePercentage = reservePercentage;
        emit AuctionReservePercentageUpdated(reservePercentage)};
    function _createAuction(uint256 generationHash) internal returns (bool) {
        require(_auctionData.bonklerId == 0, "Bonkler already settled.");
        uint256 bonkler
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}