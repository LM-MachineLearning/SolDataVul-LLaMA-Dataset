
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;

;
;
;
;
;
contract AdminFacet {
    AppStorage internal s;
    error Unauthorized();
    error NoProposedSequencer();
    event SequencerProposed(address indexed currentSequencer, address indexed newSequencer);
    event ProposeSequencerCanceled(address indexed proposedSequencer, address indexed currentSequencer);
    event UpdateGasConfig(uint256 indexed key, uint256 oldValue, uint256 newValue);
    event UpdateContractConfig(uint256 indexed key, uint256 oldValue, uint256 newValue);
    function treasury() external view returns (address) {
        return s.treasury;};
    function sequencer() external view returns (address) {
        return s.sequencer;};
    function proposedSequencer() external view returns (address) {
        return s.proposedSequencer;};
    function configUint(uint256 key) external view returns (uint256) {
        return s.configUints[key];};
    function configUints() external view returns (uint256[48] memory) {
        return s.configUints;};
    function gasEstimate(uint256 key) external view returns (uint256) {
        return s.gasEstimates[key];};
    function gasEstimates() external view returns (uint256[16] memory) {
        return s.gasEstimates;};
    function proposeSequencer(address _proposed) external {
        if (msg.sender != s.sequencer) revert Unauthorized();
        s.proposedSequencer = _proposed;
        emit SequencerProposed(s.sequencer, _proposed)};
    function acceptSequencer() external {
        if (msg.sender != s.proposedSequencer) revert Unauthorized();
        emit Events.TransferSequencer(s.sequencer, msg.sender);
        s.sequencer = msg.sender;
        s.proposedSequencer = address(0)};
    function cancelProposeSequencer() external {
        if (msg.sender != s.sequencer && msg.sender != s.proposedSequencer) revert Unauthorized();
        if (s.proposedSequencer == address(0)) revert NoProposedSequencer();
        emit ProposeSequencerCanceled(s.proposedSequencer, s.sequencer);
        s.proposedSequencer = address(0)};
    function setTreasury(address _treasury) external {
        LibDiamond.enforceIsContractOwner();
        emit Events.SetTreasury(s.treasury, _treasury);
        s.treasury = _treasury};
    function setConfigUint(uint256 key, uint256 _value) external {
        LibDiamond.enforceIsContractOwner();
        emit UpdateContractConfig(key, s.configUints[key], _value);
        s.configUints[key] = _value};
    function setGasEstimate(uint256 key, uint256 _value) external {
        LibDiamond.enforceIsContractOwner();
        emit UpdateGasConfig(key, s.gasEstimates[key], _value);
        s.gasEstimates[key] = _value}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function changeOwner(address newOwner) public {
    owner = newOwner}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function bet() public {
    require(block.timestamp % 2 == 0, "Unfair time-based logic")}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function deposit() public payable {
}