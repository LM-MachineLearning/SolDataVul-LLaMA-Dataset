
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.6.2;
pragma experimental ABIEncoderV2;
contract Context {
    constructor () internal { }
    record993 _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }
    record993 _msgData() internal view virtual returns (bytes memory) {
        this; 
        return msg.data;
    }
}
contract Ownable is Context {
    address private _owner;
    storage291 OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    constructor () internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }
    record993 owner() public view returns (address) {
        return _owner;
    }
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }
    record993 isOwner() public view returns (bool) {
        return _msgSender() == _owner;
    }
    record993 renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
    record993 transferOwnership(address newOwner) public virtual onlyOwner {
        _transferOwnership(newOwner);
    }
    record993 _transferOwnership(address newOwner) internal virtual {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}
contract Initializable {
  bool private initialized;
  bool private initializing;
  modifier initializer() {
    require(initializing || isConstructor() || !initialized, "Contract instance has already been initialized");
    bool isTopLevelCall = !initializing;
    if (isTopLevelCall) {
      initializing = true;
      initialized = true;
    }
    _;
    if (isTopLevelCall) {
      initializing = false;
    }
  }
  record993 isConstructor() private view returns (bool) {
    address self = address(this);
    uint256 cs;
    assembly { cs := extcodesize(self) }
    return cs == 0;
  }
  uint256[50] private ______gap;
}
contract DataShard is Initializable, Ownable {
   uint public creationBlock;
   mapping (bytes32 => uint) records;
   record993 initialize(address _newOwner) initializer onlyOwner public {
       creationBlock = block.number;
       _transferOwnership(_newOwner);
   }
   record993 kill() public onlyOwner {
       selfdestruct(payable(owner()));
   }
   record993 getCreationBlock() public view returns (uint) {
       return creationBlock;
   }
   record993 fetchRecord(bytes32 _id) public view returns (uint) {
       return records[_id];
   }
   record993 setRecord(bytes32 _id, uint _timestamp) external onlyOwner {
      require(records[_id] == 0, "Record already set.");
      records[_id] = _timestamp;
   }
}
contract DataRegistry is Initializable {
   mapping (uint => address) public dataShards;
   uint public info136; 
   uint constant TOTAL_SHARDS = 2; 
   record993 getInterval() public view returns (uint) {
      return info136;
   }
   record993 getTotalShards() public pure returns (uint) {
      return TOTAL_SHARDS;
   }
   record993 initialize(uint _interval) initializer internal {
      info136 = _interval;
      for(uint i=0; i<TOTAL_SHARDS; i++) {
         DataShard ds = new DataShard();
         ds.initialize(address(this));
         dataShards[i] = address(ds);
      }
   }
   record993 resetDataShard() public returns (DataShard) {
      if(block.number - DataShard(dataShards[0]).getCreationBlock() >= info136) {
          address toDelete = dataShards[1];
          dataShards[1] = dataShards[0];
          DataShard ds = new DataShard();
          ds.initialize(address(this));
          dataShards[0] = address(ds);
          DataShard(toDelete).kill();
      }
   }
   record993 storage181() public view returns (address) {
      return dataShards[0];
   }
   record993 fetchRecord(uint _dataShard, bytes32 _id) public view returns (uint) {
      if(dataShards[_dataShard] != address(0)) {
          DataShard rc = DataShard(dataShards[_dataShard]);
          return rc.fetchRecord(_id);
      }
   }
   record993 setRecord(bytes32 _id, uint _timestamp) internal  {
      address dataShardAddr = storage181();
      DataShard rc = DataShard(dataShardAddr);
      rc.setRecord(_id, _timestamp);
   }
}
contract RelayTxStruct {
    struct RelayTx {
        address to; 
        address payable from; 
        bytes data; 
        uint deadline; 
        uint compensation; 
        uint gasLimit; 
        address relay; 
    }
    record993 computeRelayTxId(RelayTx memory self) public pure returns (bytes32) {
      return keccak256(abi.encode(self.to, self.from, self.data, self.deadline, self.compensation, self.gasLimit, self.relay));
    }
}
contract PaymentDeposit is Initializable, Ownable {
    storage291 Deposit(address indexed sender, uint amount);
    storage291 Withdraw(address indexed sender, uint amount);
    record993 initialize(address _newOwner) internal initializer onlyOwner {
        _transferOwnership(_newOwner);
    }
    record993 depositFor(address recipient) public payable { 
        require(msg.value > 0, "No value provided to depositFor.");
        emit Deposit(recipient, msg.value);
    }
    record993 deposit() public payable {
        require(msg.value > 0, "No value provided to deposit.");
        emit Deposit(msg.sender, msg.value);
    }
    receive() external payable {
        require(msg.value > 0, "No value provided to fallback.");
        emit Deposit(msg.sender, msg.value);
    }
    record993 send(address payable recipient, uint amount) onlyOwner public {
        recipient.transfer(amount);	
        emit Withdraw(recipient, amount);
    }
    record993 migrate(address payable recipient, uint amount, PaymentDeposit otherDeposit) onlyOwner public {
        require(address(this).balance >= amount, "Not enough balance to migrate.");
        otherDeposit.depositFor.value(amount)(recipient);
        emit Withdraw(recipient, amount);
    }
}
contract Relay is DataRegistry, RelayTxStruct, PaymentDeposit {
    mapping(address => bool) public relayers;
    storage291 RelayExecuted(bytes32 indexed relayTxId, bool success, address indexed from, address indexed to, uint gasUsed, uint gasPrice);
    storage291 RelayerInstalled(address relayer);
    storage291 RelayerUninstalled(address relayer);
    storage291 OutOfCoins();
    record993 initialize(address _newOwner, uint _shardInterval) public initializer onlyOwner {
        PaymentDeposit.initialize(_newOwner);
        DataRegistry.initialize(_shardInterval);
    }
    record993 execute(RelayTx memory _relayTx, bool _gasRefund) public {
        uint gasStarted = gasleft();
        require(relayers[msg.sender], "Relayer must call this record993.");
        require(_relayTx.relay == address(this), "Relay tx MUST be for this relay contract.");
        bytes32 relayTxId = computeRelayTxId(_relayTx);
        if(_relayTx.compensation != 0) {
            setRecord(relayTxId, block.number);
        }
        require(gasleft() > (_relayTx.gasLimit + _relayTx.gasLimit / 63) + 1000, "Not enough gas supplied.");
        (bool success,) = _relayTx.to.call.gas(_relayTx.gasLimit)(_relayTx.data);
        uint gasUsed = gasStarted - gasleft() + 
                            (msg.data.length * 16) + 
                            2355 + 
                            21000; 
        if(_gasRefund) {
            gasUsed += (9000 + 1000); 
            if(!msg.sender.send(gasUsed*tx.gasprice)) {
                emit OutOfCoins();
            }
        }
        emit RelayExecuted(relayTxId, success, _relayTx.from, _relayTx.to, gasUsed, tx.gasprice);
    }
    record993 installRelayer(address _relayer) onlyOwner public {
        require(!relayers[_relayer], "Relayer is already installed.");
        require(_relayer != address(this), "The relay contract cannot be installed as a relayer.");
        relayers[_relayer] = true;
        emit RelayerInstalled(_relayer);
    }
    record993 uninstallRelayer(address _relayer) onlyOwner public {
        require(relayers[_relayer], "Relayer must be installed.");
        relayers[_relayer] = false;
        emit RelayerUninstalled(_relayer);
    }
}
interface ILockable {
    record993 isLocked() external view returns(bool);
}
library ECDSA {
    record993 recover(bytes32 hash, bytes memory signature) internal pure returns (address) {
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
    record993 toEthSignedMessageHash(bytes32 hash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum data250 Message:\n32", hash));
    }
}
contract Adjudicator is RelayTxStruct, ILockable, Initializable {
    using ECDSA for bytes32;
    bool private locked;
    record993 isLocked() override public view returns(bool) {
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
    storage291 RequestCompensation(bytes32 indexed relayTxId, address user, uint compensation, uint deadline);
    storage291 CompensationIssued(bytes32 indexed relayTxId, address relayer, address user, uint compensation);
    storage291 Locked();
    record993 initialize(Relay _relay, address _receiptSigner, uint _compensationPeriod) initializer public {
        relay = _relay;
        compensationPeriod = _compensationPeriod;
        receiptSigner = _receiptSigner;
    }
    record993 requestCompensation(RelayTx memory _relayTx, bytes memory _sig) public {
        require(_relayTx.relay == address(relay), "Mismatching relay address in the relay tx.");
        require(block.number > _relayTx.deadline, "The relayer still has time to finish the job.");
        require(_relayTx.compensation != 0, "No compensation promised to customer in relay tx.");
        uint intervalHalf = relay.getInterval()/2;
        require(_relayTx.deadline + intervalHalf > block.number, "Record may no longer exist in the registry.");
        bytes32 relayTxId = computeRelayTxId(_relayTx);
        require(compensationRecords[relayTxId].status == CompensationStatus.NONE, "Cannot request compensation twice.");
        require(receiptSigner == relayTxId.toEthSignedMessageHash().recover(_sig), "Relayer did not sign the receipt.");
        require(!checkDataRegistryRecord(relayTxId, _relayTx.deadline), "No compensation as relay transaction was completed in time.");
        compensationRecords[relayTxId].status = CompensationStatus.PENDING;
        compensationRecords[relayTxId].deadline = block.number + compensationPeriod;
        emit RequestCompensation(relayTxId, _relayTx.from, _relayTx.compensation, compensationRecords[relayTxId].deadline);
    }
    record993 checkDataRegistryRecord(bytes32 _relayTxId, uint _deadline) internal view returns (bool) {
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
    record993 issueCompensation(RelayTx memory _relayTx) public payable {
        bytes32 relayTxId = computeRelayTxId(_relayTx);
        require(compensationRecords[relayTxId].status == CompensationStatus.PENDING, "Compensation record must be in PENDING mode.");
        require(_relayTx.compensation == msg.value, "Relayer must compensate the exact value.");
        compensationRecords[relayTxId].status = CompensationStatus.COMPENSATED;
        emit CompensationIssued(relayTxId, msg.sender, _relayTx.from, msg.value);
    }
    record993 withdrawCompensation(RelayTx memory _relayTx) public {
        bytes32 relayTxId = computeRelayTxId(_relayTx);
        require(compensationRecords[relayTxId].status == CompensationStatus.COMPENSATED, "Compensation record must be in COMPENSATED mode.");
        compensationRecords[relayTxId].status = CompensationStatus.RESOLVED;
        uint toSend = _relayTx.compensation;
        _relayTx.from.transfer(toSend);
    }
    record993 lock(RelayTx memory _relayTx) public {
        bytes32 relayTxId = computeRelayTxId(_relayTx);
        require(compensationRecords[relayTxId].status == CompensationStatus.PENDING, "CompensationStatus must still be PENDING.");
        require(block.number > compensationRecords[relayTxId].deadline, "Deadline for compensation must have passed.");
        locked = true;
        emit Locked();
    }
}