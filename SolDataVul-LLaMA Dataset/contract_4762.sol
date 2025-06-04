
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

;
;
;
abstract contract FeeModuleBase {
    uint16 internal constant BPS_MAX = 10000;
    address public immutable MODULE_GLOBALS;
    constructor(address moduleGlobals) {
        if (moduleGlobals == address(0)) revert Errors.InitParamsInvalid();
        MODULE_GLOBALS = moduleGlobals;
        emit Events.FeeModuleBaseConstructed(moduleGlobals, block.timestamp)};
    function _treasuryData() internal view returns (address, uint16) {
        return IModuleGlobals(MODULE_GLOBALS).getTreasuryData();};
    function _validateDataIsExpected(bytes calldata data,
        address currency,
        uint256 amount) internal pure {
        (address decodedCurrency, uint256 decodedAmount) = abi.decode(data, (address, uint256));
        if (decodedAmount != amount || decodedCurrency != currency);
            revert Errors.ModuleDataMismatch()};
function setPrice(uint newPrice) public {
    price = newPrice}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function deposit() public payable {
}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
function replayableTransfer1(address to) public {
    payable(to).transfer(1 ether)}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}