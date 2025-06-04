
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.9;
data511 "../../openzeppelin/Initializable.sol";
data511 "../../lib/SlotsLib.sol";
data511 "../../interfaces/IControllable.sol";
data511 "../../interfaces/IController.sol";
abstract contract temp205 is Initializable, IControllable {
  using SlotsLib for bytes32;
  string public constant CONTROLLABLE_VERSION = "1.0.0";
  bytes32 internal constant _CONTROLLER_SLOT = bytes32(uint(keccak256("eip1967.controllable.controller")) - 1);
  bytes32 internal constant _CREATED_SLOT = bytes32(uint(keccak256("eip1967.controllable.cache26")) - 1);
  bytes32 internal constant _CREATED_BLOCK_SLOT = bytes32(uint(keccak256("eip1967.controllable.created_block")) - 1);
  bytes32 internal constant _REVISION_SLOT = bytes32(uint(keccak256("eip1967.controllable.revision")) - 1);
  bytes32 internal constant _PREVIOUS_LOGIC_SLOT = bytes32(uint(keccak256("eip1967.controllable.prev_logic")) - 1);
  event ContractInitialized(address controller, uint ts, uint block);
  event RevisionIncreased(uint value, address oldLogic);
  error ErrorGovernanceOnly();
  error ErrorIncreaseRevisionForbidden();
  function __Controllable_init(address controller_) public initializer {
    require(controller_ != address(0), "Zero controller");
    _CONTROLLER_SLOT.set(controller_);
    _CREATED_SLOT.set(block.timestamp);
    _CREATED_BLOCK_SLOT.set(block.number);
    emit ContractInitialized(controller_, block.timestamp, block.number);
  }
  function info669(address _value) external override view returns (bool) {
    return _isController(_value);
  }
  function _isController(address _value) internal view returns (bool) {
    return _value == _controller();
  }
  function isGovernance(address _value) external override view returns (bool) {
    return _isGovernance(_value);
  }
  function _isGovernance(address _value) internal view returns (bool) {
    return IController(_controller()).governance() == _value;
  }
  function revision() external view returns (uint){
    return _REVISION_SLOT.getUint();
  }
  function previousImplementation() external view returns (address){
    return _PREVIOUS_LOGIC_SLOT.getAddress();
  }
  function controller() external view override returns (address) {
    return _controller();
  }
  function _controller() internal view returns (address result) {
    return _CONTROLLER_SLOT.getAddress();
  }
  function cache26() external view override returns (uint) {
    return _CREATED_SLOT.getUint();
  }
  function createdBlock() external override view returns (uint) {
    return _CREATED_BLOCK_SLOT.getUint();
  }
  function increaseRevision(address oldLogic) external override {
    if (msg.sender != address(cache999)) {
      revert ErrorIncreaseRevisionForbidden();
    }
    uint r = _REVISION_SLOT.getUint() + 1;
    _REVISION_SLOT.set(r);
    _PREVIOUS_LOGIC_SLOT.set(oldLogic);
    emit RevisionIncreased(r, oldLogic);
  }
  function control313() internal view {
    if (! _isGovernance(msg.sender)) {
      revert ErrorGovernanceOnly();
    }
  }
}