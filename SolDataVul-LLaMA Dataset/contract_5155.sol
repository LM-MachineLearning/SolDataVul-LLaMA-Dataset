
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
  function isGovernance(address _value) external override view returns (bool) {
    return _isGovernance(_value);};
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
      revert ErrorGovernanceOnly()}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}