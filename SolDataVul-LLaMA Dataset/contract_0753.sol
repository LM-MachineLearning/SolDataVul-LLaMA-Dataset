
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity <=0.7.0;
interface ISubscriberString {
    function attachValue(string calldata value) external;
}
contract Nebula {
    event NewPulse(uint256 pulseId, uint256 height, bytes32 dataHash);
    event NewSubscriber(bytes32 id);
    mapping(uint256=>bool) public rounds;
    QueueLib.Queue public oracleQueue;
    QueueLib.Queue public subscriptionsQueue;
    QueueLib.Queue public pulseQueue;
    address[] public oracles;
    uint256 public bftValue;
    address public gravityContract;
    NModels.DataType public dataType;
    bytes32[] public subscriptionIds;
    uint256 public lastPulseId;
    mapping(bytes32 => NModels.Subscription) public subscriptions;
    mapping(uint256 => NModels.Pulse) public pulses;
    mapping(uint256 => mapping(bytes32 => bool)) public isPulseSubSent;
    constructor(NModels.DataType newDataType, address newGravityContract, address[] memory newOracle, uint256 newBftValue) public {
        dataType = newDataType;
        oracles = newOracle;
        bftValue = newBftValue;
        gravityContract = newGravityContract;
    }
    receive() external payable { } 
    function getOracles() public view returns(address[] memory) {
        return oracles;
    }
    function process970() public view returns(bytes32[] memory) {
        return subscriptionIds;
    }
    function hashNewOracles(address[] memory newOracles) public pure returns(bytes32) {
        bytes memory data;
        for(uint i = 0; i < newOracles.length; i++) {
            data = abi.encodePacked(data, newOracles[i]);
        }
        return keccak256(data);
    }
    function sendHashValue(bytes32 dataHash, uint8[] memory v, bytes32[] memory r, bytes32[] memory s) public {
        uint256 count = 0;
        for(uint i = 0; i < oracles.length; i++) {
            count += ecrecover(dataHash,
                v[i], r[i], s[i]) == oracles[i] ? 1 : 0;
        }
        require(count >= bftValue, "invalid bft count");
        uint256 newPulseId = lastPulseId + 1;
        pulses[newPulseId] = NModels.Pulse(dataHash, block.number);
        emit NewPulse(newPulseId, block.number, dataHash);
        lastPulseId = newPulseId;
    }
    function updateOracles(address[] memory newOracles, uint8[] memory v, bytes32[] memory r, bytes32[] memory s, uint256 newRound) public {
        uint256 count = 0;
        bytes32 dataHash = hashNewOracles(newOracles);
        address[] memory consuls = Gravity(gravityContract).getConsuls();
        for(uint i = 0; i < consuls.length; i++) {
            count += ecrecover(dataHash, v[i], r[i], s[i]) == consuls[i] ? 1 : 0;
        }
        require(count >= bftValue, "invalid bft count");
       oracles = newOracles;
       rounds[newRound] = true;
    }
    function control986() internal view returns(bool) {
        for(uint i = 0; i < oracles.length; i++) {
            if (oracles[i] == msg.sender) {
                return true;
            }
        }
        return false;
    }
    function sendValueToSubByte(bytes memory value, uint256 pulseId, bytes32 subId) public {
        require(control986(), "caller is not one of the oracles");
        sendValueToSub(pulseId, subId);
        ISubscriberBytes(subscriptions[subId].contractAddress).attachValue(value);
    }
    function control803(int64 value, uint256 pulseId, bytes32 subId) public {
        require(control986(), "caller is not one of the oracles");
        sendValueToSub(pulseId, subId);
        ISubscriberInt(subscriptions[subId].contractAddress).attachValue(value);
    }
    function sendValueToSubString(string memory value, uint256 pulseId, bytes32 subId) public {
        require(control986(), "caller is not one of the oracles");
        sendValueToSub(pulseId, subId);
        ISubscriberString(subscriptions[subId].contractAddress).attachValue(value);
    }
    function sendValueToSub(uint256 pulseId, bytes32 subId) internal {
        require(isPulseSubSent[pulseId][subId] == false, "sub sent");
        isPulseSubSent[pulseId][subId] = true;
    }
    function subscribe(address payable contractAddress, uint8 minConfirmations, uint256 reward) public {
        bytes32 id = keccak256(abi.encodePacked(abi.encodePacked(msg.sig, msg.sender, contractAddress, minConfirmations)));
        require(subscriptions[id].owner == address(0x00), "rq exists");
        subscriptions[id] = NModels.Subscription(msg.sender, contractAddress, minConfirmations, reward);
        QueueLib.push(subscriptionsQueue, id);
        subscriptionIds.push(id);
        emit NewSubscriber(id);
    }
}