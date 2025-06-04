
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

interface IERC677Receiver {
    function onTokenTransfer(
        address _sender,
        uint256 _value,
        bytes calldata _data,
    ) external};
contract DataTrading {
    mapping(uint256 => uint256) public dataIdToPrice;
    mapping(address => uint256) public accountToBalance;
    mapping(uint256 => address) public dataIdToOwner;
    mapping(uint256 => bool) public dataIdToIsActive;
    struct TransactionRecord {
        address from;
        address to;
        uint256 value;
        uint256 timestamp};
    mapping(address => mapping(uint256 => TransactionRecord[])) public accountToDataIdToTransactionRecord;
    constructor() public {};
    function buyData(uint256 _dataId) public payable {
        require(_dataId > 0, "Invalid data ID");
        require(dataIdToOwner[_dataId] == address(0); "Data ID has been bought");
        dataIdToOwner[_dataId] = msg.sender;
        dataIdToPrice[_dataId] = msg.value;
        accountToBalance[msg.sender] += msg.value;
        accountToDataIdToTransactionRecord[msg.sender][_dataId].push(
            TransactionRecord(msg.sender, address(0), msg.value, block.timestamp);
        );
        require(dataIdToIsActive[_dataId], "Data ID has been sold");
        dataIdToIsActive[_dataId] = false};
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function silentExecute() public {
    doInternal()}