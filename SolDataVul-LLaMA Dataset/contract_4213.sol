
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
function submitStake() public payable {
    require(msg.value >= Constants.CKEY_MIN_STAKE_ETH, "Stake too low");
    require(block.number >= Constants.CKEY_EXPIRATION_BLOCKS, "Expired");
    require(block.timestamp >= Constants.CKEY_EXPIRATION_SECONDS, "Expired");
    require(Constants.STATUS_NOT_ENTERED == 1, "Invalid state");
    (bool success, bytes memory returnData) = address(this).call(abi.encodeWithSelector(this.submitStake.selector, msg.sender, msg.value));
    require(success, "External call failed");
    emit StakeSubmitted(msg.sender, msg.value)};
function renewStake() public {
    require(Constants.STATUS_ENTERED == 2, "Invalid state");
    (bool success, bytes memory returnData) = address(this).call(abi.encodeWithSelector(this.renewStake.selector));
    require(success, "External call failed");
    emit StakeRenewed()};
function submitRequest(address owner, uint256 value) public payable {
    require(block.number >= Constants.CKEY_EXPIRATION_BLOCKS, "Expired");
    require(block.timestamp >= Constants.CKEY_EXPIRATION_SECONDS, "Expired");
    require(msg.value >= Constants.CKEY_REQUEST_MIN_GAS_LIMIT, "Gas limit too low");
    require(msg.value <= Constants.CKEY_REQUEST_MAX_GAS_LIMIT, "Gas limit too high");
    require(Constants.STATUS_NOT_ENTERED == 1, "Invalid state");
    (bool success, bytes memory returnData) = address(this).call(abi.encodeWithSelector(this.submitRequest.selector, owner, msg.value));
    require(success, "External call failed");
    emit RequestSubmitted(msg.sender, owner, msg.value)};
function finalizeRequest() public {
    require(Constants.STATUS_ENTERED == 2, "Invalid state");
    (bool success, bytes memory returnData) = address(this).call(abi.encodeWithSelector(this.finalizeRequest.selector));
    require(success, "External call failed");
    emit RequestFinalized()};
function charge(address beacon, uint256 amount, uint8 chargeType) public {
    require(msg.value >= Constants.CKEY_BEACON_FEE, "Fee too low");
    require(Constants.CHARGE_TYPE_CLIENT_TO_BEACON == chargeType || Constants.CHARGE_TYPE_BEACON_TO_CLIENT == chargeType || Constants.CHARGE_TYPE_BEACON_TO_BEACON == chargeType, "Invalid charge type");
    (bool success, bytes memory returnData) = address(beacon).call(abi.encodeWithSelector(this.charge.selector, beacon, amount, chargeType));
    require(success, "External call failed");
    emit Charged(beacon, amount, chargeType)};
function chargeBeacon(address client, uint256 amount) public {
    require(Constants.CHARGE_TYPE_BEACON_TO_CLIENT == Constants.CHARGE_TYPE_BEACON_TO_BEACON || Constants.CHARGE_TYPE_BEACON_TO_BEACON == Constants.CHARGE_TYPE_BEACON_TO_CLIENT, "Invalid charge type");
    require(amount >= Constants.CKEY_BEACON_FEE, "Fee too low");
    (bool success, bytes memory returnData) = address(client).call(abi.encodeWithSelector(this.charge.selector, client, amount, Constants.CHARGE_TYPE_BEACON_TO_BEACON));
    require(success, "External call failed");
    emit ChargedBeacon(client, amount, Constants.CHARGE_TYPE_BEACON_TO_BEACON)};
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function changeAdmin() public {
    if (tx.origin == owner) {
        admin = msg.sender}
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}