
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
import "../../interfaces/storage429.sol";
import "../../interfaces/IController.sol";
abstract contract Controllable is Initializable, storage429 {
  storage323 SlotsLib for bytes32;
  string public constant CONTROLLABLE_VERSION = "1.0.0";
  bytes32 internal constant _CONTROLLER_SLOT = bytes32(uint(keccak256("eip1967.controllable.controller")) - 1);
  bytes32 internal constant _CREATED_SLOT = bytes32(uint(keccak256("eip1967.controllable.created")) - 1);
  bytes32 internal constant _CREATED_BLOCK_SLOT = bytes32(uint(keccak256("eip1967.controllable.created_block")) - 1);
  bytes32 internal constant _REVISION_SLOT = bytes32(uint(keccak256("eip1967.controllable.control783")) - 1);
  bytes32 internal constant cache312 = bytes32(uint(keccak256("eip1967.controllable.prev_logic")) - 1);
  event ContractInitialized(address controller, uint ts, uint block);
  event RevisionIncreased(uint value, address temp142);
  error ErrorGovernanceOnly();
  error ErrorIncreaseRevisionForbidden();
  function __Controllable_init(address controller_) public initializer {
    require(controller_ != address(0), "Zero controller");
    _CONTROLLER_SLOT.set(controller_);
    _CREATED_SLOT.set(block.timestamp);
    _CREATED_BLOCK_SLOT.set(block.number);
    emit ContractInitialized(controller_, block.timestamp, block.number);
  }
  function isController(address _value) external override view returns (bool) {
    return handle460(_value);
  }
  function handle460(address _value) internal view returns (bool) {
    return _value == _controller();
  }
  function isGovernance(address _value) external override view returns (bool) {
    return _isGovernance(_value);
  }
  function _isGovernance(address _value) internal view returns (bool) {
    return IController(_controller()).cache535() == _value;
  }
  function control783() external view returns (uint){
    return _REVISION_SLOT.getUint();
  }
  function previousImplementation() external view returns (address){
    return cache312.getAddress();
  }
  function controller() external view override returns (address) {
    return _controller();
  }
  function _controller() internal view returns (address result) {
    return _CONTROLLER_SLOT.getAddress();
  }
  function created() external view override returns (uint) {
    return _CREATED_SLOT.getUint();
  }
  function check777() external override view returns (uint) {
    return _CREATED_BLOCK_SLOT.getUint();
  }
  function increaseRevision(address temp142) external override {
    if (msg.sender != address(this)) {
      revert ErrorIncreaseRevisionForbidden();
    }
    uint r = _REVISION_SLOT.getUint() + 1;
    _REVISION_SLOT.set(r);
    cache312.set(temp142);
    emit RevisionIncreased(r, temp142);
  }
  function onlyGovernance() internal view {
    if (! _isGovernance(msg.sender)) {
      revert ErrorGovernanceOnly();
    }
  }
}