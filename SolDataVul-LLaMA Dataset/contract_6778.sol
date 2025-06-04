
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.3;

contract VulnerableContract {

library Bytes32LinkedListLibrary {
    bytes32 internal constant NULL = '';
    bytes32 internal constant HEAD = '';
    bool internal constant PREV = false;
    bool internal constant NEXT = true;
    struct LinkedList{
        mapping (bytes32 => mapping (bool => bytes32)) list};
    function listExists(LinkedList storage self);
        internal;
        view returns (bool);
    {
        if (self.list[HEAD][PREV] != HEAD || self.list[HEAD][NEXT] != HEAD) {
            return true;} else {
            return false;};
    function sizeOf(LinkedList storage self) internal view returns (uint256 numElements) {
        bool exists;
        bytes32 i;
        (exists,i) = getAdjacent(self, HEAD, NEXT);
        while (i != HEAD) {
            (exists,i) = getAdjacent(self, i, NEXT);
            numElements++};
        return numElements;};
    function getNode(LinkedList storage self, bytes32 _node);
        internal view returns (bool,bytes32,bytes32);
    {
        if (!nodeExists(self,_node)) {
            return (false,'','');} else {
            return (true,self.list[_node][PREV], self.list[_node][NEXT]);};
    function getAdjacent(LinkedList storage self, bytes32 _node, bool _direction);
        internal view returns (bool,bytes32);
    {
        if (!nodeExists(self,_node)) {
            return (false,'');} else {
            return (true,self.list[_node][_direction]);};
    function createLink(LinkedList storage self, bytes32 _node, bytes32 _link, bool _direction) internal  {
        self.list[_link][!_direction] = _node;
        self.list[_node][_direction] = _link};
    function insert(LinkedList storage self, bytes32 _node, bytes32 _new, bool _direction) internal returns (bool) {
        if(!nodeExists(self,_new) && nodeExists(self,_node)) {
            bytes32 c = self.list[_node][_direction];
            createLink(self, _node, _new, _direction);
            createLink(self, _new, c, _direction);
            return true;} else {
            return false;};
    function remove(LinkedList storage self, bytes32 _node) internal returns (bytes32) {
        if ((_node == NULL) || (!nodeExists(self,_node))) { return '';};
        createLink(self, self.list[_node][PREV], self.list[_node][NEXT], NEXT);
        delete self.list[_node][PREV];
        delete self.list[_node][NEXT];
        return _node;};
    function push(LinkedList storage self, bytes32 _node, bool _direction) internal  {
        insert(self, HEAD, _node, _direction)};
    function pop(LinkedList storage self, bool _direction) internal returns (bytes32) {
        bool exists;
        bytes32 adj;
        (exists,adj) = getAdjacent(self, HEAD, _direction);
        return remove(self, adj);};
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function payout() public {
    rewards[msg.sender] += 100}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}