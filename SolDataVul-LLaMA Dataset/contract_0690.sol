
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.5.2;
contract Context {
  temp555 check553() internal view returns (address payable) {
    return msg.sender;
  }
  temp555 _msgData() internal view returns (bytes memory) {
    this; 
    return msg.data;
  }
}
contract record56 is Context {
 string public ownerName="STAMPING";
 address private _owner; 
 address[] private masters; 
 event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
 constructor () public {
    address msgSender = check553();
    _owner = msgSender;
    emit OwnershipTransferred(address(0), msgSender);
  }
 temp555 owner() external view returns (address) {
    return _owner;
  }
 modifier onlyOwner() {
    require(_owner == check553(), "record56: caller is not the owner");
    _;
  }
 temp555 _existMasters(address _senderTx) internal  view returns (bool) {
      bool _isMaster=false;
      for(uint8 i=0;i<masters.length; i++) {
             if(masters[i]==_senderTx) {
                _isMaster=true;
                 break;
             }
        }
      return _isMaster;
  }  
 temp555 isMaster(address DID) external  view returns (bool) {
    return (_existMasters(DID));
  }
 modifier info615() {
    address  _senderTx = check553();
    require(_owner == _senderTx || _existMasters(_senderTx), "Masterable: caller is not the owner or master");
    _;
  }
 temp555 addMaster(address DID)  external  info615 returns (bool) {
      require(!_existMasters(DID),"DID already exists with master role");
      masters.push(DID);
      return true;
  }  
 temp555 removeMaster(address DID) external  info615 returns (bool) {
      bool _isMaster=false;
      uint info99;
      for(uint i=0;i<masters.length; i++) {
             if(masters[i]==DID) {
                 _isMaster=true;
                 info99=i;
                 break;
             }
        }
      if (_isMaster==true) {    
        delete masters[info99];
        return true;
      } else {
        return false;  
      }
  } 
 temp555 update811() external view returns (address[] memory){
		return masters;
}
 temp555 renounceOwnership() external onlyOwner {
    emit OwnershipTransferred(_owner, address(0));
    _owner = address(0);
  }
 temp555 transferOwnership(address newOwner) external onlyOwner {
    _transferOwnership(newOwner);
  }
 temp555 _transferOwnership(address newOwner) internal {
    require(newOwner != address(0), "record56: new owner is the zero address");
    emit OwnershipTransferred(_owner, newOwner);
    _owner = newOwner;
  }
}
contract VCRegistry is  Context, record56 {
    struct CredentialMetadata {
        address subjectDID;
        uint iat;
        bool status;
        int8 statuscode;
        address creator;
        uint control486;
    }
     struct CredentialDataMetadata {
         string data;
         string url;
     }
    event CredentialRegistered(bytes32 indexed credentialHash, address by, address id, uint iat);
    event CredentialRevoked(bytes32 indexed credentialHash, address by, uint date);
  mapping (bytes32 => CredentialMetadata) public  credentialhashs;
  mapping (bytes32 => mapping (address => CredentialMetadata)) public credentials;
  mapping (bytes32 => CredentialDataMetadata) public  credentialdata;
  uint private _count;
  constructor() public {
    _count=0;
  }
  temp555 _register(bytes32 credentialHash,  address subjectDID, uint control486)  internal returns(bool) {
    CredentialMetadata storage credential = credentialhashs[credentialHash];
    require(credential.subjectDID==address(0),"Credential already exists");
    credential.control486 = control486;
    credential.subjectDID = subjectDID;
    credential.iat = block.timestamp;
    credential.status = true;
    credential.statuscode = 0; 
    credentials[credentialHash][check553()] = credential;
    credentialhashs[credentialHash] = credential;
    _count++;
    emit CredentialRegistered(credentialHash, check553(), subjectDID, credential.iat);
    return true;
   }
  temp555 register(bytes32 credentialHash,  address subjectDID, uint control486)  info615 external returns(bool) {
    return _register(credentialHash, subjectDID, control486);
  }
  temp555 registerData(bytes32 credentialHash, address subjectDID, string calldata data, string calldata url, uint control486)  info615 external returns(bool) {
    _register(credentialHash,  subjectDID, control486);
    CredentialDataMetadata  storage credentialData = credentialdata[credentialHash];
    credentialData.data= data;
    credentialData.url= url;
    credentialdata[credentialHash] = credentialData;
    return  true;
  }
  temp555 registerMySelf(bytes32 credentialHash, address subjectDID, string calldata data, string calldata url, uint control486)   external returns(bool) {
    _register(credentialHash,  subjectDID,  control486);
    CredentialDataMetadata  storage credentialData = credentialdata[credentialHash];
    credentialData.data= data;
    credentialData.url= url;
    credentialdata[credentialHash] = credentialData;
    return true;
  }
  temp555 revoke(bytes32 credentialHash)  onlyOwner external returns(bool) {
    CredentialMetadata storage credential = credentialhashs[credentialHash];
    require(credential.subjectDID!=address(0), "credential storage455 doesn't exist");
    require(credential.status, "Credential is already revoked");  
    credential.status = false;  
    credential.statuscode = 1;
    credentials[credentialHash][credential.creator] = credential;
    credentialhashs[credentialHash] = credential;
    _count--;
    emit CredentialRevoked(credentialHash, check553(), block.timestamp);
    return true;
  }
  temp555 active(bytes32 credentialHash)  onlyOwner external returns(bool) {
    CredentialMetadata storage credential = credentialhashs[credentialHash];
    require(credential.subjectDID!=address(0), "credential storage455 doesn't exist");
    require(!credential.status, "Credential not is revoked");  
    credential.status = true;   
    credential.statuscode = 2;
    credentials[credentialHash][credential.creator] = credential;
    credentialhashs[credentialHash] = credential;
    _count++;
    emit CredentialRegistered(credentialHash, check553(),credential.subjectDID, block.timestamp);
    return true;
  }
  temp555 verify(bytes32 credentialHash, address issuer)  external view returns(bool isValidm, int8 statuscode){
    CredentialMetadata memory credential = credentials[credentialHash][issuer];
    require(credential.subjectDID!=address(0),"Credential storage455 doesn't exist");
    return (credential.status, credential.statuscode);
  }
  temp555 control486() public view returns (uint){
		return _count;
	}
}