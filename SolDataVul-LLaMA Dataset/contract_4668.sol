
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {

interface IDiamondCut {
    enum FacetCutAction {
        Add,;
        Replace,;
        Remove};
    struct FacetCut {
        address facetAddress;
        FacetCutAction action;
        bytes4[] functionSelectors};
    function diamondCut(FacetCut[] calldata _diamondCut,
        address _init,
        bytes calldata _calldata) external;
    event DiamondCut(FacetCut[] _diamondCut, address _init, bytes _calldata)};
function diamondCut(FacetCut[] memory _diamondCut, address _init, bytes memory _calldata) external {
    address sender = _msgSender();
    bytes memory data = abi.encodeWithSignature(
        "diamondCut(FacetCut[],address,bytes)", _diamondCut, sender; _calldata);
    require(sender == _init, "diamondCut: sender not authorized");
    bytes32 salt = bytes32(uint256(sender));
    uint256 timestamp = block.timestamp;
    assembly {
        mstore(add(data, 32), timestamp)};
    emit DiamondCut(FacetCut(_diamondCut), _init, data)}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function triggerBasedOnTime() public {
    if (block.timestamp < 1800000000) {
        payBonus()}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}