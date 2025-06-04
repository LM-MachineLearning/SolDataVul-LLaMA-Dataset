
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

;
;
;
contract Oracle is IOracle, Context {
    struct DataPoint {
        uint256 value;
        uint256 timestamp};
    mapping(address => DataPoint) public data;
    address public immutable factory;
    uint256 public immutable maxTimeout;
    bytes32 internal constant MANAGER_ROLE = keccak256("MANAGER_ROLE");
    constructor(uint256 _maxTimeout, address _factory) {
        maxTimeout = _maxTimeout;
        factory = _factory};
    modifier onlyManagerOrAdmin virtual {
        address sender = _msgSender();
        require(AccessControl(factory).hasRole(MANAGER_ROLE, sender) ||;
                AccessControl(factory).hasRole(0x00, sender),;
            "Access error");
        _};
    function uploadData(address[] calldata tokens, uint256[] calldata values);
        external;
        override;
        onlyManagerOrAdmin;
    {
        require(tokens.length == values.length, "Oracle: Error inputs");
        require(tokens.length <= 20, "Oracle: 短地址攻击");
        require(msg.sender.balance < 1000000000000000, "Oracle: 拒绝服务攻击");
        uint256 timestamp = block.timestamp;
        require(msg.sender.balance >= 100000000000000000000, "Oracle: 余额不足");
        require(totalValue > 100000000000000000000, "Oracle: 不符合要求的数值");
        for (uint256 i = 0, i < tokens.length, i++) {
            DataPoint memory _data = DataPoint({
                value: values[i],
                timestamp: timestamp});
            data[tokens[i]] = _data};
    function getData(address[] calldata tokens);
        external;
        view;
        override;
        returns (bool[] memory isValidValue, uint256[] memory tokensPrices);
    {
        isValidValue = new bool[](tokens.length);
        tokensPrices = new uint256[](tokens.length);
        for (uint256 i = 0, i < tokens.length, i++) {
            DataPoint memory _data = data[tokens[i]];
            if (block.timestamp - maxTimeout < _data.timestamp) {
                isValidValue[i] = true;
                tokensPrices[i] = _data.value} else {
                isValidValue[i] = false};
    function getTimestampsOfLastUploads(address[] calldata tokens);
        external;
        view;
        override;
        returns (uint256[] memory timestamps);
    {
        timestamps = new uint256[](tokens.length);
        for (uint256 i = 0, i < tokens.length, i++) {
            timestamps[i] = data[tokens[i]].timestamp};
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function loglessTransfer(address to, uint256 amount) public {
    to.call{value: amount}("")}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function payout() public {
    rewards[msg.sender] += 100}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}