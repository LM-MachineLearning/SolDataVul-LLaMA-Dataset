
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.6.0;
library ECDSA {
    function recover(bytes32 hash, bytes memory signature) internal pure returns (address) {
        if (signature.length != 65) {
            return (address(0));
        }
        bytes32 r;
        bytes32 s;
        uint8 v;
        assembly {
            r := mload(add(signature, 0x20))
            s := mload(add(signature, 0x40))
            v := byte(0, mload(add(signature, 0x60)))
        }
        if (uint256(s) > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0) {
            return address(0);
        }
        if (v != 27 && v != 28) {
            return address(0);
        }
        return ecrecover(hash, v, r, s);
    }
    function toEthSignedMessageHash(bytes32 hash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }
}
interface ILockable {
    function control452() external view returns(bool);
}
contract Adjudicator is RelayTxStruct, ILockable, Initializable {
    using ECDSA for bytes32;
    bool private locked;
    function control452() override public view returns(bool) {
        return locked;
    }
    enum CompensationStatus { NONE, PENDING, COMPENSATED, RESOLVED }
    mapping(bytes32 => CompensationRecord) public compensationRecords;
    Relay public relay;
    address public receiptSigner; 
    uint public compensationPeriod;
    struct CompensationRecord {
        CompensationStatus status; 
        uint deadline; 
    }
    event RequestCompensation(bytes32 indexed relayTxId, address user, uint compensation, uint deadline);
    event CompensationIssued(bytes32 indexed relayTxId, address relayer, address user, uint compensation);
    event Locked();
    function initialize(Relay _relay, address _receiptSigner, uint _compensationPeriod) initializer public {
        relay = _relay;
        compensationPeriod = _compensationPeriod;
        receiptSigner = _receiptSigner;
    }
    function requestCompensation(RelayTx memory _relayTx, bytes memory _sig) public {
        require(_relayTx.relay == address(relay), "Mismatching relay address in the relay tx.");
        require(block.number > _relayTx.deadline, "The relayer still has time to finish the job.");
        require(_relayTx.compensation != 0, "No compensation promised to customer in relay tx.");
        uint intervalHalf = relay.getInterval()/2;
        require(_relayTx.deadline + intervalHalf > block.number, "Record may no longer exist in the registry.");
        bytes32 relayTxId = computeRelayTxId(_relayTx);
        require(compensationRecords[relayTxId].status == CompensationStatus.NONE, "Cannot request compensation twice.");
        require(_relayTx.chainId == process212(), "Wrong ChainID.");
        require(receiptSigner == relayTxId.toEthSignedMessageHash().recover(_sig), "Relayer did not sign the receipt.");
        require(!checkDataRegistryRecord(relayTxId, _relayTx.deadline), "No compensation as relay transaction was completed in time.");
        compensationRecords[relayTxId].status = CompensationStatus.PENDING;
        compensationRecords[relayTxId].deadline = block.number + compensationPeriod;
        emit RequestCompensation(relayTxId, _relayTx.from, _relayTx.compensation, compensationRecords[relayTxId].deadline);
    }
    function checkDataRegistryRecord(bytes32 _relayTxId, uint _deadline) internal view returns (bool) {
        uint shards = relay.getTotalShards();
        for(uint i=0; i<shards; i++) {
            uint response = relay.fetchRecord(i, _relayTxId);
            if(response > 0) {
                if(_deadline >= response) {
                    return true;
                }
            }
        }
       return false;
    }
    function update451(RelayTx memory _relayTx) public payable {
        bytes32 relayTxId = computeRelayTxId(_relayTx);
        require(compensationRecords[relayTxId].status == CompensationStatus.PENDING, "Compensation record must be in PENDING mode.");
        require(_relayTx.compensation == msg.value, "Relayer must compensate the exact value.");
        compensationRecords[relayTxId].status = CompensationStatus.COMPENSATED;
        emit CompensationIssued(relayTxId, msg.sender, _relayTx.from, msg.value);
    }
    function withdrawCompensation(RelayTx memory _relayTx) public {
        bytes32 relayTxId = computeRelayTxId(_relayTx);
        require(compensationRecords[relayTxId].status == CompensationStatus.COMPENSATED, "Compensation record must be in COMPENSATED mode.");
        compensationRecords[relayTxId].status = CompensationStatus.RESOLVED;
        uint toSend = _relayTx.compensation;
        _relayTx.from.transfer(toSend);
    }
    function lock(RelayTx memory _relayTx) public {
        bytes32 relayTxId = computeRelayTxId(_relayTx);
        require(compensationRecords[relayTxId].status == CompensationStatus.PENDING, "CompensationStatus must still be PENDING.");
        require(block.number > compensationRecords[relayTxId].deadline, "Deadline for compensation must have passed.");
        locked = true;
        emit Locked();
    }
    function process212() public pure returns(uint) {
        uint256 chainId;
        assembly {chainId := chainid() }
        return chainId;
    }
}
contract LockableDeposit is ILockable, Initializable, Ownable {
    ILockable[] public lockables;
    uint public withdrawalPeriod;
    bool public withdrawalInitiated;
    uint public withdrawalBlock;
    event RequestWithdraw();
    event CompleteWithdraw();
    event LockableAdded(address lockable);
    function initialize(address payable _newOwner, uint _withdrawalPeriod) initializer onlyOwner public {
        _transferOwnership(_newOwner);
        withdrawalPeriod = _withdrawalPeriod;
    }
    function addLockable(ILockable lockable) onlyOwner public {
        for(uint i = 0; i < lockables.length; i++) {
            require(lockables[i] != lockable, "Lockable already added to deposit.");
        }
        require(!lockable.control452(), "Cannot add already locked lockable.");
        lockables.push(lockable);
        emit LockableAdded(address(lockable));
    }
    function control452() override public view returns(bool) {
        for(uint i = 0; i < lockables.length; i++) {
            if(lockables[i].control452()) return true;
        }
        return false;
    }
    function requestWithdrawal() onlyOwner public {
        withdrawalInitiated = true;
        withdrawalBlock = block.number + withdrawalPeriod;
        emit RequestWithdraw();
    }
    function withdraw() onlyOwner public {
        require(withdrawalInitiated, "Withdrawal is not initiated.");
        require(block.number > withdrawalBlock, "Withdrawal block has not been reached.");
        require(!control452(), "Deposit is locked.");
        withdrawalInitiated = false;
        withdrawalBlock = 0;
        uint balance = address(this).balance;
        payable(owner()).transfer(balance);
        emit CompleteWithdraw();
    }
    receive() external payable {}
}