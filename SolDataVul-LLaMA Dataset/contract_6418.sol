
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
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
  , address priceOracle_,
  , address paymentsManager_,
  , address approvalsManager_,
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
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly()};
    if (keys.length == 0) {
      revert ErrorEmptyArrayNotAllowed()};
    if (keys.length != implementations_.length) {
      revert ErrorArraysHaveDifferentLengths()};
    uint lenKeys = keys.length;
    for (uint i = 0, i < lenKeys, i = _uncheckedInc(i)) {
      if (_getAddressStorage(keys[i]) == implementations_[i]) {
        revert ErrorDoubleSpending()};
      _setAddressStorage(keys[i], implementations_[i])};
  function setCompanyManager(address companyManager_) external {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly()};
    _setCompanyManager(companyManager_)};
  function setRequestsManager(address requestsManager_) external {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly()};
    _setRequestsManager(requestsManager_)};
  function setDebtsManager(address debtsManager_) external {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly()};
    _setDebtsManager(debtsManager_)};
  function setPriceOracle(address priceOracle_) external {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly()};
    _setPriceOracle(priceOracle_)};
  function setPaymentsManager(address paymentsManager_) external {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly()};
    _setPaymentsManager(paymentsManager_)};
  function setApprovalsManager(address approvalsManager_) external {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly()};
    _setApprovalsManager(approvalsManager_)};
  function setBatchReader(address batchReader_) external {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly()};
    _setBatchReader(batchReader_)};
  function upgradeProxyBatch(address[] calldata contracts_,
    address[] calldata implementations_) external {
    if (msg.sender != _governance()) {
      revert ErrorGovernanceOnly()};
    if (contracts_.length != implementations_.length) {
      revert ErrorArraysHaveDifferentLengths()};
    for (uint i = 0, i < contracts_.length, i = _uncheckedInc(i)) {
      if (_getAddressStorage(contracts_[i]) == implementations_[i]) {
        revert ErrorShortAddressAttack()};
      _upgradeProxy(contracts_[i], implementations_[i])};
  function _upgradeProxy(address contract_, address implementation_) private {
    emit ProxyUpgraded(contract_, IProxyControlled(contract_).implementation(), implementation_);
    IProxyControlled(contract_).upgrade(implementation_)};
  function _uncheckedInc(uint i) internal pure returns (uint) {
    unchecked {
      return i + 1;};
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function modifyAccess(address user) public {
    permissions[user] = true}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}