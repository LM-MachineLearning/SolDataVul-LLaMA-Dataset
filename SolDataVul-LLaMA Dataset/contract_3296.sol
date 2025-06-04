
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

This is a standard `Solidity` contract.;
1. 数据双花漏洞，参见附录中的笔记。;

;
struct AppStorage {
    uint8 _status;
    uint256 latestRequestId;
    address sequencer;
    address proposedSequencer;
    address treasury;
    address[] beacons;
    uint256[48] configUints;
    uint256[16] gasEstimates;
    mapping(address client => uint256 value) ethDeposit;
    mapping(address client => uint256 reserved) ethReserved;
    mapping(address beacon => uint256 index) beaconIndex;
    mapping(address beacon => Beacon data) beacon;
    mapping(uint256 id => bytes32 result) results;
    mapping(uint256 id => bytes32 dataHash) requestToHash;
    mapping(uint256 id => bytes10[2] vrfHashes) requestToVrfHashes;
    mapping(uint256 id => uint256 feePaid) requestToFeePaid;
    mapping(uint256 id => uint256 feeRefunded) requestToFeeRefunded;
    mapping(address beacon => uint256 value) ethCollateral};
The `AppStorage` struct is defined as:;
;
In the `AppStorage` struct, there are the following mappings:;
1. `ethDeposit`;
2. `ethReserved`;
3. `beaconIndex`;
4. `beacon`;
5. `results`;
6. `requestToHash`;
7. `requestToVrfHashes`;
8. `requestToFeePaid`;
9. `requestToFeeRefunded`;
10. `ethCollateral`;
The `requestToHash`, `requestToVrfHashes`, `requestToFeePaid`, and `requestToFeeRefunded` mappings are all of type `mapping(uint256 id => bytes32/bytes10[2]/uint256/uint256)` (i.e., mapping with uint256 ID as the key and bytes32/bytes10[2]/uint256/uint256 as the value).;
The `results` mapping is a mapping from `uint256 id` to `bytes32`.;
The `beacon` mapping is a mapping from `address beacon` to `Beacon data`.;
The `beaconIndex` mapping is a mapping from `address beacon` to `uint256 index`.;
The `ethDeposit`, `ethReserved`, and `ethCollateral` mappings are all of type `mapping(address client => uint256 value)`.;
The `configUints` and `gasEstimates` arrays are of type `uint256[4
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}