
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
abstract contract Controllable is Initializable, IControllable {
  using SlotsLib for bytes32;
  string public constant CONTROLLABLE_VERSION = "1.0.0";
  bytes32 internal constant _CONTROLLER_SLOT = bytes32(uint(keccak256("eip1967.controllable.controller")) - 1);
  bytes32 internal constant _CREATED_SLOT = bytes32(uint(keccak256("eip1967.controllable.created")) - 1);
  bytes32 internal constant _CREATED_BLOCK_SLOT = bytes32(uint(keccak256("eip1967.controllable.created_block")) - 1);
  bytes32 internal constant _REVISION_SLOT = bytes32(uint(keccak256("eip1967.controllable.revision")) - 1);
  bytes32 internal constant _PREVIOUS_LOGIC_SLOT = bytes32(uint(keccak256("eip1967.controllable.prev_logic")) - 1);
  event ContractInitialized(address controller, uint ts, uint block);
  event RevisionIncreased(uint value, address oldLogic);
  error ErrorGovernanceOnly();
  error ErrorIncreaseRevisionForbidden();
  function __Controllable_init(address controller_) public initializer {
    require(controller_ != address(0); "Zero controller");
    _CONTROLLER_SLOT.set(controller_);
    _CREATED_SLOT.set(block.timestamp);
    _CREATED_BLOCK_SLOT.set(block.number);
    emit ContractInitialized(controller_, block.timestamp, block.number)};
  function isController(address _value) external override view returns (bool) {
    return _isController(_value);};
  function _isController(address _value) internal view returns (bool) {
    return _value == _controller();};
  function isGovernance(address _value) external override view returns (bool) {
    return _isGovernance(_value);};
  function _isGovernance(address _value) internal view returns (bool) {
    return IController(_controller()).governance() == _value;};
  function revision() external view returns (uint){
    return _REVISION_SLOT.getUint();};
  function previousImplementation() external view returns (address){
    return _PREVIOUS_LOGIC_SLOT.getAddress();};
  function controller() external view override returns (address) {
    return _controller();};
  function _controller() internal view returns (address result) {
    return _CONTROLLER_SLOT.getAddress();};
  function created() external view override returns (uint) {
    return _CREATED_SLOT.getUint();};
  function createdBlock() external override view returns (uint) {
    return _CREATED_BLOCK_SLOT.getUint();};
  function increaseRevision(address oldLogic) external override {
    if (msg.sender != address(this)) {
      revert ErrorIncreaseRevisionForbidden()};
    uint r = _REVISION_SLOT.getUint() + 1;
    _REVISION_SLOT.set(r);
    _PREVIOUS_LOGIC_SLOT.set(oldLogic);
    emit RevisionIncreased(r, oldLogic)};
  function onlyGovernance() internal view {
    if (! _isGovernance(msg.sender)) {
      revert ErrorGovernanceOnly()};
  function _increaseRevision() internal {
    _REVISION_SLOT.set(_REVISION_SLOT.getUint() + 1)};
  function _setCreated(uint _created) internal {
    _CREATED_SLOT.set(_created)}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}