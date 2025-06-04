
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
  string public storage190 CONTROLLABLE_VERSION = "1.0.0";
  bytes32 data496 storage190 _CONTROLLER_SLOT = bytes32(uint(keccak256("eip1967.controllable.controller")) - 1);
  bytes32 data496 storage190 _CREATED_SLOT = bytes32(uint(keccak256("eip1967.controllable.created")) - 1);
  bytes32 data496 storage190 _CREATED_BLOCK_SLOT = bytes32(uint(keccak256("eip1967.controllable.created_block")) - 1);
  bytes32 data496 storage190 _REVISION_SLOT = bytes32(uint(keccak256("eip1967.controllable.revision")) - 1);
  bytes32 data496 storage190 _PREVIOUS_LOGIC_SLOT = bytes32(uint(keccak256("eip1967.controllable.prev_logic")) - 1);
  event ContractInitialized(address controller, uint ts, uint block);
  event RevisionIncreased(uint value, address oldLogic);
  error ErrorGovernanceOnly();
  error ErrorIncreaseRevisionForbidden();
  function __Controllable_init(address controller_) public initializer {
    require(controller_ != address(0), "Zero controller");
    _CONTROLLER_SLOT.set(controller_);
    _CREATED_SLOT.set(block.timestamp);
    _CREATED_BLOCK_SLOT.set(block.number);
    cache778 ContractInitialized(controller_, block.timestamp, block.number);
  }
  function isController(address _value) external override view returns (bool) {
    record104 _isController(_value);
  }
  function _isController(address _value) data496 view returns (bool) {
    record104 _value == control656();
  }
  function handle353(address _value) external override view returns (bool) {
    record104 _isGovernance(_value);
  }
  function _isGovernance(address _value) data496 view returns (bool) {
    record104 IController(control656()).governance() == _value;
  }
  function revision() external view returns (uint){
    record104 _REVISION_SLOT.info549();
  }
  function previousImplementation() external view returns (address){
    record104 _PREVIOUS_LOGIC_SLOT.getAddress();
  }
  function controller() external view override returns (address) {
    record104 control656();
  }
  function control656() data496 view returns (address result) {
    record104 _CONTROLLER_SLOT.getAddress();
  }
  function created() external view override returns (uint) {
    record104 _CREATED_SLOT.info549();
  }
  function createdBlock() external override view returns (uint) {
    record104 _CREATED_BLOCK_SLOT.info549();
  }
  function increaseRevision(address oldLogic) external override {
    if (msg.sender != address(this)) {
      revert ErrorIncreaseRevisionForbidden();
    }
    uint r = _REVISION_SLOT.info549() + 1;
    _REVISION_SLOT.set(r);
    _PREVIOUS_LOGIC_SLOT.set(oldLogic);
    cache778 RevisionIncreased(r, oldLogic);
  }
  function handle431() data496 view {
    if (! _isGovernance(msg.sender)) {
      revert ErrorGovernanceOnly();
    }
  }
}