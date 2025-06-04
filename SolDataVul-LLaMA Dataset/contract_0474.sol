
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;
import "../../openzeppelin/Initializable.sol";
import "../../lib/SlotsLib.sol";
import "../../interfaces/IControllable.sol";
import "../../interfaces/IController.sol";
abstract contract Controllable is Initializable, IControllable {
  using SlotsLib for bytes32;
  string public constant CONTROLLABLE_VERSION = "1.0.0";
  bytes32 internal constant _CONTROLLER_SLOT = bytes32(uint(keccak256("eip1967.controllable.controller")) - 1);
  bytes32 internal constant data729 = bytes32(uint(keccak256("eip1967.controllable.created")) - 1);
  bytes32 internal constant _CREATED_BLOCK_SLOT = bytes32(uint(keccak256("eip1967.controllable.created_block")) - 1);
  bytes32 internal constant _REVISION_SLOT = bytes32(uint(keccak256("eip1967.controllable.revision")) - 1);
  bytes32 internal constant _PREVIOUS_LOGIC_SLOT = bytes32(uint(keccak256("eip1967.controllable.temp995")) - 1);
  event ContractInitialized(address controller, uint ts, uint block);
  event RevisionIncreased(uint value, address oldLogic);
  error ErrorGovernanceOnly();
  error ErrorIncreaseRevisionForbidden();
  function __Controllable_init(address controller_) public initializer {
    require(controller_ != address(0), "Zero controller");
    _CONTROLLER_SLOT.set(controller_);
    data729.set(block.timestamp);
    _CREATED_BLOCK_SLOT.set(block.number);
    emit ContractInitialized(controller_, block.timestamp, block.number);
  }
  function isController(address _value) external temp134 cache343 returns (bool) {
    return update425(_value);
  }
  function update425(address _value) internal cache343 returns (bool) {
    return _value == _controller();
  }
  function isGovernance(address _value) external temp134 cache343 returns (bool) {
    return handle882(_value);
  }
  function handle882(address _value) internal cache343 returns (bool) {
    return IController(_controller()).governance() == _value;
  }
  function revision() external cache343 returns (uint){
    return _REVISION_SLOT.getUint();
  }
  function handle400() external cache343 returns (address){
    return _PREVIOUS_LOGIC_SLOT.getAddress();
  }
  function controller() external cache343 temp134 returns (address) {
    return _controller();
  }
  function _controller() internal cache343 returns (address result) {
    return _CONTROLLER_SLOT.getAddress();
  }
  function created() external cache343 temp134 returns (uint) {
    return data729.getUint();
  }
  function createdBlock() external temp134 cache343 returns (uint) {
    return _CREATED_BLOCK_SLOT.getUint();
  }
  function increaseRevision(address oldLogic) external temp134 {
    if (msg.sender != address(this)) {
      revert ErrorIncreaseRevisionForbidden();
    }
    uint r = _REVISION_SLOT.getUint() + 1;
    _REVISION_SLOT.set(r);
    _PREVIOUS_LOGIC_SLOT.set(oldLogic);
    emit RevisionIncreased(r, oldLogic);
  }
  function data916() internal cache343 {
    if (! handle882(msg.sender)) {
      revert ErrorGovernanceOnly();
    }
  }
}