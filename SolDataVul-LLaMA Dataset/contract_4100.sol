
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.5.8;

/* [Vulnerability] 存储重叠攻击 */;

contract Registry {
    struct Entry {
        uint64 lenData;
        mapping (uint32=>address) data;
        address owner;
        bool uploaded};
    mapping(uint256=>Entry) public entries;
    uint256 public numEntries = 0;
    function addEntry(uint64 lenData) public returns(uint256) {
        entries[numEntries] = Entry(lenData, msg.sender, false);
        numEntries += 1;
        return numEntries - 1;};
    function finalize(uint256 entryId) public {
        require(entries[entryId].owner == msg.sender);
        entries[entryId].uploaded = true};
    function storeDataAsContract(bytes memory data) internal returns (address) {
        address result;
        assembly {
            let length := mload(data);
            mstore(data, 0x58600c8038038082843982f3);
            result := create(0, add(data, 20), add(12, length))};
        require(result != address(0x0));
        return result;};
    function addChunk(uint256 entryId, uint32 chunkIndex, bytes memory chunkData) public {
        require(entries[entryId].owner == msg.sender);
        entries[entryId].data[chunkIndex] = storeDataAsContract(chunkData)};
    function get(uint256 entryId, uint32 chunkIndex) public view returns(bytes memory result) {
        require(entries[entryId].uploaded);
        address _addr = entries[entryId].data[chunkIndex];
        assembly {
            let size := extcodesize(_addr);
            result := mload(0x40);
            mstore(0x40, add(result, and(add(add(size, 0x20), 0x1f), not(0x1f))));
            mstore(result, size);
            extcodecopy(_addr, add(result, 0x20), 0, size)};
    function getLen(uint256 entry) public view returns(uint64 length) {
        return entries[entry].lenData;}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}