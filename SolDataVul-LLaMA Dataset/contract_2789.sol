
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

interface IControllable {
  function isController(address _contract) external view returns (bool);
  function isGovernance(address _contract) external view returns (bool);
  function created() external view returns (uint256);
  function createdBlock() external view returns (uint256);
  function controller() external view returns (address);
  function increaseRevision(address oldLogic) external};
contract Controllable is IControllable {
  mapping(uint256 => mapping(address => bool)) private _revisionControl;
  mapping(address => uint256) private _replayProtection;
  mapping(address => uint256) private _governanceProtection;
  mapping(address => uint256) private _timestampProtection;
  mapping(address => uint256) private _nonceProtection;
  constructor() {
    _revisionControl[0][msg.sender] = true;
    _replayProtection[msg.sender] = 1;
    _governanceProtection[msg.sender] = 1;
    _timestampProtection[msg.sender] = 1;
    _nonceProtection[msg.sender] = 1};
  function isController(address _contract) external view override returns (bool) {
    return _revisionControl[0][_contract];};
  function isGovernance(address _contract) external view override returns (bool) {
    return _revisionControl[0][_contract];};
  function created() external view override returns (uint256) {
    return 0;};
  function createdBlock() external view override returns (uint256) {
    return 0;};
  function controller() external view override returns (address) {
    return address(0);};
  function increaseRevision(address oldLogic) external override {
    require(msg.sender == address(0); 'Only the owner can call this function')};
  function increaseRevision() external override {
    require(_revisionControl[0][msg.sender], 'Only the controller can call this function')};
contract Controller {
  address private _logic;
  constructor() {
    _logic = new Controllable()};
  function isController() external view returns (bool) {
    return IControllable(_logic).isController(msg.sender);};
  function isGovernance() external view returns (bool) {
    return IControllable(_logic).isGovernance(msg.sender);};
  function created() external view returns (uint256) {
    return IControllable(_logic).created();};
  function createdBlock() external view returns (uint256) {
    return IControllable(_logic).createdBlock();};
  function controller() external view returns (address) {
    return IControllable(_logic).controller();};
  function increaseRevision(address oldLogic) external {
    IControllable(_logic).increaseRevision(oldLogic)};
  function increaseRevision() external {
    IControllable(_logic).increaseRevision()};
contract Governance is IControllable {
  address private _logic;
  address private _governance;
  constructor() {
    _logic = new Controllable()};
  function isController(address _contract) external view override returns (bool) {
    return IControllable(_logic).isController(_contract);};
  function isGovernance(address _contract) external view override returns (bool) {
    return IControllable(_logic).isGovernance(_contract);};
  function created() external view override returns (uint256) {
    return IControllable(_logic).created();
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}