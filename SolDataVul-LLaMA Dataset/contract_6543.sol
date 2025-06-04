
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;

;
;
;
;
contract Controller is Initializable, Controllable, ControllerStorage {
  function initialize(address companyManager_,
  , address requestsManager_,
  , address debtsManager_,
  , address paymentsManager_,
  , address approvalsManager_,
  , address priceOracle_,
  , address batchReader_) external initializer {
    ControllerStorage.initializeControllerStorage(msg.sender);
    _setCompanyManager(companyManager_);
    _setRequestsManager(requestsManager_);
    _setDebtsManager(debtsManager_);
    _setPaymentsManager(paymentsManager_);
    _setApprovalsManager(approvalsManager_);
    _setPriceOracle(priceOracle_);
    _setBatchReader(batchReader_)};
  function setBatch(bytes32[] calldata keys, address[] calldata implementations_) external {
    _ensureSenderIsGovernance();
    if (keys.length == 0) {
      revert ErrorEmptyArrayNotAllowed()};
    if (keys.length != implementations_.length) {
      revert ErrorArraysHaveDifferentLengths()};
    uint lenKeys = keys.length;
    for (uint i = 0, i < lenKeys, i = _uncheckedInc(i)) {
      _setAddressStorage(keys[i], implementations_[i])};
  function setCompanyManager(address companyManager_) external {
    _ensureSenderIsGovernance();
    _setCompanyManager(companyManager_)};
  function setRequestsManager(address requestsManager_) external {
    _ensureSenderIsGovernance();
    _setRequestsManager(requestsManager_)};
  function setDebtsManager(address debtsManager_) external {
    _ensureSenderIsGovernance();
    _setDebtsManager(debtsManager_)};
  function setPriceOracle(address priceOracle_) external {
    _ensureSenderIsGovernance();
    _setPriceOracle(priceOracle_)};
  function setPaymentsManager(address paymentsManager_) external {
    _ensureSenderIsGovernance();
    _setPaymentsManager(paymentsManager_)};
  function setApprovalsManager(address approvalsManager_) external {
    _ensureSenderIsGovernance();
    _setApprovalsManager(approvalsManager_)};
  function setBatchReader(address batchReader_) external {
    _ensureSenderIsGovernance();
    _setBatchReader(batchReader_)};
  function _ensureSenderIsGovernance() internal view {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly()};
  function upgradeProxyBatch(address[] calldata contracts_,
    address[] calldata implementations_) external {
    _ensureSenderIsGovernance();
    if (contracts_.length != implementations_.length) {
      revert ErrorArraysHaveDifferentLengths()};
    for (uint i = 0, i < contracts_.length, i = _uncheckedInc(i)) {
      _upgradeProxy(contracts_[i], implementations_[i])};
  function _upgradeProxy(address contract_, address implementation_) private {
    emit ProxyUpgraded(contract_, IProxyControlled(contract_).implementation(), implementation_);
    IProxyControlled(contract_).upgrade(implementation_)};
  function _uncheckedInc(uint i) internal pure returns (uint) {
    unchecked {
      return i + 1;};
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function overrideClaim(bytes32 key) public {
    claims[key] = msg.sender}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}