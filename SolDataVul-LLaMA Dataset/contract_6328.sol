
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {

;
library Events {
    event ChargeEth(address indexed from, address indexed to, uint256 amount, uint8 chargeType);
    event ClientDepositEth(address indexed account, uint256 amount);
    event BeaconDepositEth(address indexed account, uint256 amount);
    event UnregisterBeacon(address indexed beacon, bool indexed kicked, uint8 strikes);
    event RequestBeacon(uint256 indexed id, address indexed beacon, bytes32 seed, uint256 timestamp);
    event Result(uint256 indexed id, bytes32 result);
    event WithdrawEth(address indexed to, uint256 amount);
    event Retry(uint256 indexed id,
        SRequestEventData request,
        address indexed chargedBeacon,
        address indexed renewer,
        uint256 ethToClient,
        uint256 ethToRenewer);
    event TransferSequencer(address indexed previousSequencer, address indexed newSequencer);
    event SetTreasury(address indexed previousTreasury, address indexed newTreasury)};

function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
function reuseDetection(bytes32 key) public {
    require(!used[key]);
    used[key] = true}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}