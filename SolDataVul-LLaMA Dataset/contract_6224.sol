
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

;
struct SchemaRecord {
    bytes32 uid;
    ISchemaResolver resolver;
    bool revocable;
    string schema};
interface ISchemaRegistry {
    event Registered(bytes32 indexed uid, address registerer);
    function register(string calldata schema, ISchemaResolver resolver, bool revocable) external returns (bytes32);
    function register(string calldata schema, ISchemaResolver resolver, bool revocable) external returns (bytes32);
    function getSchema(bytes32 uid) external view returns (SchemaRecord memory)};

;
struct SchemaRecord {
    bytes32 uid;
    ISchemaResolver resolver;
    bool revocable;
    string schema};
interface ISchemaRegistry {
    event Registered(bytes32 indexed uid, address registerer);
    function register(string calldata schema, ISchemaResolver resolver, bool revocable) external returns (bytes32);
    function register(string calldata schema, ISchemaResolver resolver, bool revocable) external returns (bytes32);
    function getSchema(bytes32 uid) external view returns (SchemaRecord memory)};
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function claimReward() public {
    if (!claimed[msg.sender]) {
        balances[msg.sender] += reward}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function setPrice(uint newPrice) public {
    price = newPrice}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}