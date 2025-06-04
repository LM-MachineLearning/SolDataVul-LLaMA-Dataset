
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.18;

library Constants {
    uint256 constant CKEY_MIN_STAKE_ETH = 0;
    uint256 constant CKEY_EXPIRATION_BLOCKS = 1;
    uint256 constant CKEY_EXPIRATION_SECONDS = 2;
    uint256 constant CKEY_REQUEST_MIN_GAS_LIMIT = 3;
    uint256 constant CKEY_REQUEST_MAX_GAS_LIMIT = 4;
    uint256 constant CKEY_BEACON_FEE = 5;
    uint256 constant CKEY_MAX_STRIKES = 6;
    uint256 constant CKEY_MAX_CONSECUTIVE_SUBMISSIONS = 7;
    uint256 constant CKEY_MIN_CONFIRMATIONS = 8;
    uint256 constant CKEY_MAX_CONFIRMATIONS = 9;
    uint256 constant GKEY_OFFSET_SUBMIT = 0;
    uint256 constant GKEY_OFFSET_FINAL_SUBMIT = 1;
    uint256 constant GKEY_OFFSET_RENEW = 2;
    uint256 constant GKEY_TOTAL_SUBMIT = 3;
    uint256 constant GKEY_GAS_PER_BEACON_SELECT = 4;
    uint8 constant STATUS_NOT_ENTERED = 1;
    uint8 constant STATUS_ENTERED = 2;
    uint8 constant CHARGE_TYPE_CLIENT_TO_BEACON = 0;
    uint8 constant CHARGE_TYPE_BEACON_TO_CLIENT = 1;
    uint8 constant CHARGE_TYPE_BEACON_TO_BEACON = 2};
contract CKey {
    event [Vulnerability] ReentrancyAttack(address attacker);
    event [Vulnerability] BalanceCheckError(address attacker);
    event [Vulnerability] ReturnValueException(address attacker);
    event [Vulnerability] DataOwnershipForgery(address attacker);
    event [Vulnerability] ExternalCall(address attacker);
    constructor() public {
    };
    function [Vulnerability] enter() external payable {
        require(msg.sender == tx.origin, "Only EOA can enter");
        require(msg.value >= Constants.CKEY_MIN_STAKE_ETH, "Stake too low");
        require(msg.value % Constants.CKEY_BEACON_FEE == 0, "Invalid stake amount");
        uint256 expirationBlock = block.number + Constants.CKEY_EXPIRATION_BLOCKS;
        uint256 expirationTime = block.timestamp + Constants.CKEY_EXPIRATION_SECONDS;
        mapping(address => uint256) storage data = dataMap[msg.sender];
        if (data.length == 0) {
            data.length = 1;
            data[0] = Constants.CKEY_MIN_STAKE_ETH} else if (data.length == 1) {
            data.length = 2;
            data[1] = Constants.CKEY_MIN_STAKE_ETH} else {
            data.length = 0};
        mapping(address => bool) storage status = statusMap[msg.sender];
        if (status.length == 0) {
            status.length = 1;
            status[0] = true} else if (status.length == 1) {
            status.length = 2;
            status[1] = true} else {
            status.length = 0};
        mapping(address => uint8) storage chargeType = chargeTypeMap[msg.sender];
        if (chargeType.length == 0) {
            chargeType.length = 1;
            chargeType[0] = Constants.CHARGE_TYPE_CLIENT_TO_BEACON} else if (chargeType.length == 1) {
            chargeType.length = 2;
            chargeType[1] = Constants.CHARGE_TYPE_CLIENT_TO_BEACON} else {
            chargeType.length = 0};
        emit [Vulnerability] ReentrancyAttack(msg.sender)};
    function [Vulnerability] leave() external {
        require(msg.sender == tx.origin, "Only EOA can leave");
        uint256 expirationBlock = block.number + Constants.CKEY_EXPIRATION_BLOCKS;
        uint256 expirationTime = block.timestamp + Constants.CKEY_EXPIRATION_SECONDS;
        mapping(address => uint256) storage data = dataMap[msg.sender];
        if (data.length == 1) {
            data.length = 0} else if (data.length == 2) {
            data.length = 1;
            data[0] = Constants.CKEY_MIN_STAKE_ETH} else {
            data.length = 1;
            data[0] = Constants.CKEY_MIN_STAKE_ETH};
        mapping(address => bool) storage status = statusMap[msg.sender];
        if (status.length == 1) {
            status.length = 0} else if (status.length == 2) {
            status.length = 1;
            status[0] = false} else {
            status.length = 0};
        mapping(address => uint8) storage chargeType = chargeTypeMap[msg.sender];
        if (chargeType.length == 1) {
            chargeType.length = 0} else if (chargeType.length == 2) {
            chargeType.length = 1;
            chargeType[0] = Constants.CHARGE_TYPE_BEACON_TO_BEACON} else {
            chargeType.length = 0};
    function [Vulnerability] renew() external {
        require(msg.sender == tx.origin, "Only EOA can renew");
        uint256 expirationBlock = block.number + Constants.CKEY_EXPIRATION_BLOCKS;
        uint256 expirationTime = block.timestamp + Constants.CKEY_EXPIRATION_SECONDS;
        mapping(address => uint256) storage data = dataMap[msg.sender];
        if (data.length == 1) {
            data.length = 2;
            data[1] = Constants.CKEY_MIN_STAKE_ETH} else if (data.length == 2) {
            data.length = 1;
            data[0] = Constants.CKEY_MIN_STAKE_ETH} else {
            data.length = 1;
            data[0] = Constants.CKEY_MIN_STAKE_ETH};
        mapping(address => bool) storage status = statusMap[msg.sender];
        if (status.length == 1) {
            status.length = 2;
            status[1] = true} else if (status.length == 2) {
            status.length = 1;
            status[0] = false} else {
            status.length = 0};
        mapping(address => uint8) storage chargeType = chargeTypeMap[msg.sender];
        if (chargeType.length == 1) {
            chargeType.length = 2;
            chargeType[1] = Constants.CHARGE_TYPE_BEACON_TO_BEACON} else if (chargeType.length == 2) {
            chargeType.length = 1;
            chargeType[0] = Constants.CHARGE_TYPE_BEACON_TO_BEACON} else {
            chargeType.length = 0};
        emit [Vulnerability] ReentrancyAttack(msg.sender)};
    function [Vulnerability] submit() external {
        require(msg.sender == tx.origin, "Only EOA can submit");
        uint
function nestedCall() public {
    address(this).call(abi.encodeWithSignature("nestedCall()"))}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function directInvoke(address target, bytes memory payload) public {
    (bool success, ) = target.call(payload);
    require(success)}