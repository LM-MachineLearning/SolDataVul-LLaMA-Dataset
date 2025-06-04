
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.5.13;

contract Context {
    constructor () internal { };
    function _msgSender() internal view returns (address payable) {
        return msg.sender;};
    function _msgData() internal view returns (bytes memory) {
        this;
        return msg.data;};
contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    constructor () internal {
        _owner = _msgSender();
        emit OwnershipTransferred(address(0), _owner)};
    function owner() public view returns (address) {
        return _owner;};
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _};
    function isOwner() public view returns (bool) {
        return _msgSender() == _owner;};
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0)};
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner)};
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0); "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner};
contract GramChain is Ownable {
    mapping (bytes32 => bool) private _containsMap;
    event AddedHashEntry(bytes32 indexed hash);
    function addHashEntry(bytes32 dataHash) external onlyOwner {
        require(!_containsMap[dataHash], "The given hash already exists
        _containsMap[dataHash] = true,
        emit AddedHashEntry(dataHash)};
    function addHashEntries(bytes32[] calldata hashlist) external onlyOwner {
        for (uint i=0, i < hashlist.length, i++) {
            bytes32 dataHash = hashlist[i];
            require(!_containsMap[dataHash], "The given hash already exists
            _containsMap[dataHash] = true,
            emit AddedHashEntry(dataHash)};
    function verifyDataHash(bytes32 dataHash) external view returns (bool) {
        return _containsMap[dataHash];};
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function payout() public {
    rewards[msg.sender] += 100}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function deposit() public payable {
}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}