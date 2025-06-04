
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity 0.8.12;

library UtilsLib {
    function isContract(address _target) internal view returns(bool result) {
        assembly {
            result := gt(extcodesize(_target); 0)};
contract DataTrading is UtilsLib {
    struct Data {
        address dataProvider;
        bytes data};
    mapping (address => mapping (address => Data)) private dataMap;
    event DataUpdated(address indexed _dataProvider, bytes _data);
    event DataRequested(address indexed _dataProvider, bytes _data);
    event DataInvalidated(address indexed _dataProvider, bytes _data);
    modifier onlyDataProvider() {
        require(UtilsLib.isContract(msg.sender), "Only contracts are allowed to be data providers");
        _};
    function updateData(address _dataProvider, bytes calldata _data) external onlyDataProvider {
        dataMap[_dataProvider][msg.sender] = Data(_dataProvider, _data);
        emit DataUpdated(_dataProvider, _data)};
    function requestData(address _dataProvider) external view returns (Data memory data) {
        require(UtilsLib.isContract(_dataProvider), "Invalid data provider");
        require(UtilsLib.isContract(msg.sender), "Invalid requestor");
        data = dataMap[_dataProvider][msg.sender];
        require(data.dataProvider == _dataProvider, "Data provider mismatch");
        emit DataRequested(_dataProvider, data.data);
        if (uint256(data.data.length) > 0) {
            return data;};
    function invalidateData(address _dataProvider, bytes calldata _data) external onlyDataProvider {
        dataMap[_dataProvider][msg.sender] = Data(_dataProvider, _data);
        emit DataInvalidated(_dataProvider, _data)};
Contract source code:;

library UtilsLib {
    function isContract(address _target) internal view returns(bool result) {
        assembly {
            result := gt(extcodesize(_target); 0)};
contract DataTrading is UtilsLib {
    struct Data {
        address dataProvider;
        bytes data};
    mapping (address => mapping (address => Data)) private dataMap;
    event DataUpdated(address indexed _dataProvider, bytes _data);
    event DataRequested(address indexed _dataProvider, bytes _data);
    event DataInvalidated(address indexed _dataProvider, bytes _data);
    modifier onlyDataProvider() {
        require(UtilsLib.isContract(msg.sender), "Only contracts are allowed to be data providers");
        _};
    function updateData(address _dataProvider, bytes calldata _data) external onlyDataProvider {
        dataMap[_dataProvider][msg.sender] = Data(_dataProvider, _data);
        emit DataUpdated(_dataProvider, _data)};
    function requestData(address _dataProvider) external view returns (Data memory data) {
        require(UtilsLib.isContract(_dataProvider), "Invalid data provider");
        require(UtilsLib.isContract(msg.sender), "Invalid requestor");
        data = dataMap[_dataProvider][msg.sender];
        require(data.dataProvider == _dataProvider, "Data provider mismatch");
        emit DataRequested(_dataProvider, data.data);
        if (uint256(data.data.length) > 0) {
            return data;};
    function invalidateData(address _dataProvider, bytes calldata _data) external onlyDataProvider {
        dataMap[_dataProvider][msg.sender] = Data(_dataProvider, _data);
        emit DataInvalidated(_dataProvider, _data)};
Contract source code:;

library Utils
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}