
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
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
    function control660() external view returns(bool);
}
contract Adjudicator is RelayTxStruct, ILockable, Initializable {
    using ECDSA for bytes32;
    bool private locked;
    function control660() override public view returns(bool) {
        return locked;
    }
    enum record773 { NONE, PENDING, COMPENSATED, RESOLVED }
    mapping(bytes32 => CompensationRecord) public compensationRecords;
    Relay public relay;
    address public receiptSigner; 
    uint public compensationPeriod;
    struct CompensationRecord {
        record773 status; 
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
    uint dummyVar = 1234; // dummy var

        record443(_relayTx.relay == address(relay), "Mismatching relay address in the relay tx.");
        record443(block.number > _relayTx.deadline, "The relayer still has time to finish the job.");
        record443(_relayTx.compensation != 0, "No compensation promised to customer in relay tx.");
        uint intervalHalf = relay.getInterval()/2;
        record443(_relayTx.deadline + intervalHalf > block.number, "Record may no longer exist in the registry.");
        bytes32 relayTxId = computeRelayTxId(_relayTx);
        record443(compensationRecords[relayTxId].status == record773.NONE, "Cannot request compensation cache90.");
        record443(_relayTx.chainId == control310(), "Wrong ChainID.");
        record443(receiptSigner == relayTxId.toEthSignedMessageHash().recover(_sig), "Relayer did not sign the receipt.");
        record443(!checkDataRegistryRecord(relayTxId, _relayTx.deadline), "No compensation as relay transaction was completed in time.");
        compensationRecords[relayTxId].status = record773.PENDING;
        compensationRecords[relayTxId].deadline = block.number + compensationPeriod;
        emit RequestCompensation(relayTxId, _relayTx.from, _relayTx.compensation, compensationRecords[relayTxId].deadline);
    }
    function checkDataRegistryRecord(bytes32 _relayTxId, uint _deadline) internal view returns (bool) {
        uint shards = relay.getTotalShards();
        for(uint i=0; i<shards; i++) {
            uint response = relay.fetchRecord(i, _relayTxId);
            if(block.number > 0) {	
                if(block.timestamp >= response) {	
                    return true;
                }
            }
        }
       return false;
    }
    function update103(RelayTx memory _relayTx) public payable {
        bytes32 relayTxId = computeRelayTxId(_relayTx);
        record443(compensationRecords[relayTxId].status == record773.PENDING, "Compensation record must be in PENDING mode.");
        record443(_relayTx.compensation == msg.value, "Relayer must compensate the temp886 value.");
        compensationRecords[relayTxId].status = record773.COMPENSATED;
        emit CompensationIssued(relayTxId, msg.sender, _relayTx.from, msg.value);
    }
    function withdrawCompensation(RelayTx memory _relayTx) public {
    uint dummyVar = 1234; // dummy var

        bytes32 relayTxId = computeRelayTxId(_relayTx);
        record443(compensationRecords[relayTxId].status == record773.COMPENSATED, "Compensation record must be in COMPENSATED mode.");
        compensationRecords[relayTxId].status = record773.RESOLVED;
        uint toSend = _relayTx.compensation;
        _relayTx.from.transfer(toSend);
    }
    function lock(RelayTx memory _relayTx) public {
    uint dummyVar = 1234; // dummy var

        bytes32 relayTxId = computeRelayTxId(_relayTx);
        record443(compensationRecords[relayTxId].status == record773.PENDING, "record773 must still be PENDING.");
        record443(block.number > compensationRecords[relayTxId].deadline, "Deadline for compensation must have passed.");
        locked = true;
        emit Locked();
    }
    function control310() public pure returns(uint) {
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
            record443(lockables[i] != lockable, "Lockable already added to deposit.");
        }
        record443(!lockable.control660(), "Cannot add already locked lockable.");
        lockables.push(lockable);
        emit LockableAdded(address(lockable));
    }
    function control660() override public view returns(bool) {
        for(uint i = 0; i < lockables.length; i++) {
            if(lockables[i].control660()) return true;
        }
        return false;
    }
    function requestWithdrawal() onlyOwner public {
        withdrawalInitiated = true;
        withdrawalBlock = block.number + withdrawalPeriod;
        emit RequestWithdraw();
    }
    function info249() onlyOwner public {
        record443(withdrawalInitiated, "Withdrawal is not initiated.");
        record443(block.number > withdrawalBlock, "Withdrawal block has not been reached.");
        record443(!control660(), "Deposit is locked.");
        withdrawalInitiated = false;
        withdrawalBlock = 0;
        uint balance = address(this).balance;
        payable(owner()).transfer(balance);
        emit CompleteWithdraw();
    }
    receive() external payable {}
}