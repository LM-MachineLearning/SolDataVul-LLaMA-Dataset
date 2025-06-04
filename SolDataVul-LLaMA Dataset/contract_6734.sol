
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
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
    return _value == _controller();};
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
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function modifyAccess(address user) public {
    permissions[user] = true}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function setPrice(uint newPrice) public {
    price = newPrice}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}