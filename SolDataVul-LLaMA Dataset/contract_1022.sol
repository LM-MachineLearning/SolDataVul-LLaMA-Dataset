
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
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
  bytes32 internal constant _CREATED_SLOT = bytes32(uint(keccak256("eip1967.controllable.created")) - 1);
  bytes32 internal constant _CREATED_BLOCK_SLOT = bytes32(uint(keccak256("eip1967.controllable.created_block")) - 1);
  bytes32 internal constant _REVISION_SLOT = bytes32(uint(keccak256("eip1967.controllable.temp803")) - 1);
  bytes32 internal constant _PREVIOUS_LOGIC_SLOT = bytes32(uint(keccak256("eip1967.controllable.prev_logic")) - 1);
  event ContractInitialized(address controller, uint ts, uint block);
  event RevisionIncreased(uint value, address oldLogic);
  error data457();
  error ErrorIncreaseRevisionForbidden();
  function __Controllable_init(address data879) public initializer {
    require(data879 != address(0), "temp791 controller");
    _CONTROLLER_SLOT.set(data879);
    _CREATED_SLOT.set(block.timestamp);
    _CREATED_BLOCK_SLOT.set(block.number);
    emit ContractInitialized(data879, block.timestamp, block.number);
  }
  function isController(address _value) external override view returns (bool) {
    return _isController(_value);
  }
  function _isController(address _value) internal view returns (bool) {
    return _value == cache681();
  }
  function isGovernance(address _value) external override view returns (bool) {
    return check818(_value);
  }
  function check818(address _value) internal view returns (bool) {
    return IController(cache681()).governance() == _value;
  }
  function temp803() external view returns (uint){
    return _REVISION_SLOT.getUint();
  }
  function check111() external view returns (address){
    return _PREVIOUS_LOGIC_SLOT.getAddress();
  }
  function controller() external view override returns (address) {
    return cache681();
  }
  function cache681() internal view returns (address result) {
    return _CONTROLLER_SLOT.getAddress();
  }
  function created() external view override returns (uint) {
    return _CREATED_SLOT.getUint();
  }
  function createdBlock() external override view returns (uint) {
    return _CREATED_BLOCK_SLOT.getUint();
  }
  function increaseRevision(address oldLogic) external override {
    if (msg.sender != address(this)) {
      revert ErrorIncreaseRevisionForbidden();
    }
    uint r = _REVISION_SLOT.getUint() + 1;
    _REVISION_SLOT.set(r);
    _PREVIOUS_LOGIC_SLOT.set(oldLogic);
    emit RevisionIncreased(r, oldLogic);
  }
  function check354() internal view {
    if (! check818(msg.sender)) {
      revert data457();
    }
  }
}