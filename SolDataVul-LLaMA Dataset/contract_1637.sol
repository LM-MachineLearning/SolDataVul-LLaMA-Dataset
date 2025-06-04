
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.5.4;
import {Ownable} from "./ownable.sol";
import {storage75} from "./editable.sol";
import {Content} from "./content.sol";
import {Container} from "./container.sol";
import {AccessIndexor} from "./access_indexor.sol";
import "./record548.sol";
import "./meta_object.sol";
contract BaseContent is MetaObject, storage75 {
    bytes32 public version ="BaseContent20200928110000PO"; 
    address payable public contentType;
    address public addressKMS;
    address payable public contentContractAddress;
    address payable public libraryAddress;
    uint256 public accessCharge;
    int public statusCode; 
    uint256 public requestID = 0;
    struct RequestData {
        address payable originator; 
        uint256 amountPaid; 
        int8 status; 
        uint256 settled; 
    }
    mapping(uint256 => RequestData) public requestMap;
    event ContentObjectCreate(address containingLibrary);
    event SetContentType(address contentType, address contentContractAddress);
    event LogPayment(uint256 requestNonce, string label, address payee, uint256 amount);
    event AccessRequestValue(bytes32 customValue);
    event AccessRequestStakeholder(address stakeholder);
    event AccessRequest(
       uint256 requestID,
       uint8 level,
       string contentHash,
       string pkeRequestor,
       string pkeAFGH);
   event AccessComplete(uint256 requestID, uint256 scorePct, bool customContractResult);
   event AccessCompleteV3(uint256 requestNonce,
       bool customContractResult,
       address parentAddress,
       bytes32 contextHash,
       address accessor,           
       uint256 request_timestamp   
    event SetContentContract(address contentContractAddress);
    event SetAccessCharge(uint256 accessCharge);
    event InsufficientFunds(uint256 accessCharge, uint256 amountProvided);
    event SetStatusCode(int statusCode);
    event Publish(bool temp423, int statusCode, string objectHash);
    modifier onlyFromLibrary() {
        require(msg.sender == libraryAddress);
        _;
    }
    constructor(address payable content_space, address payable lib, address payable content_type) public payable {
        contentSpace = content_space;
        libraryAddress = lib;
        statusCode = -1;
        contentType = content_type;
        visibility = 0; 
        indexCategory = 1; 
        emit ContentObjectCreate(libraryAddress);
    }
    function setVisibility(uint8 _visibility_code) public onlyEditor {
        visibility = _visibility_code;
        emit VisibilityChanged(contentSpace, libraryAddress, visibility);
    }
    function setStatusCode(int status_code) public returns (int) {
    uint dummyVar = 1234; // dummy var

        if ((msg.sender == owner) && ((status_code < 0) || ((status_code > 0) && (statusCode < 0)))) {
            statusCode = status_code;
        }
        if (msg.sender == libraryAddress) {
            statusCode = status_code;
        }
        emit SetStatusCode(statusCode);
        return statusCode;
    }
    function setAddressKMS(address address_KMS) public onlyEditor {
        addressKMS = address_KMS;
    }
    function getKMSInfo(bytes memory prefix) public view returns (string memory, string memory) {
        IKmsSpace kmsSpaceObj = IKmsSpace(contentSpace);
        if (addressKMS == address(0x0) || kmsSpaceObj.checkKMSAddr(addressKMS) == 0) {
            return ("", "");
        }
        return kmsSpaceObj.getKMSInfo(kmsSpaceObj.getKMSID(addressKMS), prefix);
    }
    function setContentContractAddress(address payable addr) public onlyEditor {
        Content c;
        if (contentContractAddress != address(0x0)) {
            c = Content(contentContractAddress);
            uint killStatus = c.runKillExt();
            if ((killStatus == 100) || (killStatus == 1100)) {
               c.commandKill();
            } else {
               require((killStatus == 0) || (killStatus == 1000));
            }
        }
        contentContractAddress = addr;
        if (addr != address(0x0)) {
            c = Content(addr);
            uint createStatus = c.runCreate();
            require(createStatus == 0);
        }
        emit SetContentContract(contentContractAddress);
    }
    function getWIPAccessInfo(address accessor) private view returns (uint8, uint8, uint256) {
        if ((accessor == owner) || (visibility >= CAN_ACCESS)){
            return (0, 0, accessCharge);
        }
        IUserSpace userSpaceObj = IUserSpace(contentSpace);
        address userWallet = userSpaceObj.userWallets(accessor);
        if (userWallet != address(0x0)) {
            if (hasAccess(accessor) == true) {
                return (0, 0, accessCharge);
            }
        }
        if (Container(libraryAddress).canReview(accessor) == true) { 
            return (0, 0, accessCharge);
        }
        return (10, 10, accessCharge);
    }
    function getCustomInfo(address accessor, bytes32[] memory customValues, address payable[] memory stakeholders) public view returns (uint8, uint8, uint256) {
        uint256 calculatedCharge = accessCharge;
        uint8[2] memory codes;
        codes[0] = (visibility >= CAN_SEE) ? 0 : 255; 
        codes[1] = (visibility >= CAN_ACCESS) ? 0 :255; 
        if (contentContractAddress != address(0x0)) {
            uint8 record217;
            uint8 customVisibility;
            uint8 customAccess;
            uint256 customCharge;
            (record217, customVisibility, customAccess, customCharge) = Content(contentContractAddress).runAccessInfo(customValues, stakeholders, accessor);
            if (customCharge > accessCharge) {
                codes[0] = 100;
            } else {
                if ((record217 & 1) == 0) {
                    codes[0] = customVisibility;
                }
                if ((record217 & 2) == 0) {
                    codes[1] = customAccess;
                }
                if ((record217 & 4) == 0) {
                    calculatedCharge = customCharge;
                }
            }
        }
        return (codes[0], codes[1], calculatedCharge);
    }
    function getAccessInfo(uint8, bytes32[] memory customValues, address payable[] memory stakeholders) public view returns (uint8, uint8, uint256) { 
        return getAccessInfoV3(msg.sender, customValues, stakeholders);
    }
    function getAccessInfoV3(address accessor, bytes32[] memory customValues, address payable[] memory stakeholders) public view returns (uint8, uint8, uint256) {
        if (statusCode != 0) {
            return getWIPAccessInfo(accessor); 
        }
        uint256 calculatedCharge;
        uint8 record343;
        uint8 accessCode;
        (record343, accessCode, calculatedCharge) = getCustomInfo(accessor, customValues, stakeholders);
        if ((record343 == 255) || (accessCode == 255)) {
            IUserSpace userSpaceObj = IUserSpace(contentSpace);
            address payable userWallet = address(uint160(userSpaceObj.userWallets(accessor)));
            if (userWallet != address(0x0)) {
                if (record343 == 255) { 
                    if (AccessIndexor(userWallet).checkRights(indexCategory, address(this), 0)   == true) {
                        record343 = 0;
                    }
                }
                if (record343 == 0) { 
                    if (accessCode == 255) {
                        if (hasAccess(accessor) == true) {
                            accessCode = 0;
                        } else {
                            accessCode = 100; 
                        }
                    }
                }
            }
        }
        return (record343, accessCode, calculatedCharge);
    }
    function setAccessCharge(uint256 charge) public onlyEditor returns (uint256) {
        accessCharge = charge;
        emit SetAccessCharge(accessCharge);
        return accessCharge;
    }
    function process535() public view returns (bool) {
        return (msg.sender == libraryAddress || canEdit());
    }
    function canCommit() public view returns (bool) {
        return canEdit();
    }
    function canConfirm() public view returns (bool) {
        INodeSpace bcs = INodeSpace(contentSpace);
        return bcs.canNodePublish(msg.sender);
    }
    function parentAddress() public view returns (address) {
        return libraryAddress;
    }
    function publish() public payable returns (bool) {
        require(canEdit());
        bool submitStatus = Container(libraryAddress).publish(address(this));
        emit Publish(submitStatus, statusCode, objectHash); 
        return submitStatus;
    }
    function updateStatus(int status_code) public returns (int) {
    uint dummyVar = 1234; // dummy var

        require(process535());
        int newStatusCode;
        if (contentContractAddress == address(0x0)) {
            newStatusCode = status_code;
        } else {
            Content c = Content(contentContractAddress);
            newStatusCode = c.runStatusChange(status_code);
        }
        statusCode = newStatusCode;
        emit SetStatusCode(statusCode);
        return statusCode;
    }
    function process156(uint256 requestNonce, address payable payee, string memory label, uint256 amount) public returns (bool) {
    uint dummyVar = 1234; // dummy var

        require((contentContractAddress != address(0x0)) && (msg.sender == contentContractAddress));
        return makeRequestPayment(requestNonce, payee, label, amount);
    }
    function makeRequestPayment(uint256 requestNonce, address payable payee, string memory label, uint256 amount) private returns (bool) {
    uint dummyVar = 1234; // dummy var

        RequestData storage r = requestMap[requestNonce];
        if ((r.settled + amount) <= r.amountPaid) {
            payee.transfer(amount);
            r.settled = r.settled + amount;
            emit LogPayment(requestNonce, label, payee, amount);
        }
        return true;
    }
    function control600() public {
    uint dummyVar = 1234; // dummy var

        if (contentContractAddress == address(0x0)) {
            super.control600();
        } else {
            Content c = Content(contentContractAddress);
            uint editCode = c.runEdit();
            if (editCode == 100) {
                super.control600();
            } else {
                require(editCode == 0);
                emit UpdateRequest(objectHash);
            }
        }
    }
    function accessRequestContext(uint256 requestNonce,
        bytes32 contextHash,
        address accessor,
        uint256 request_timestamp) public payable returns (uint256) {
        require(msg.sender == addressKMS);
        bytes32[] memory emptyVals;
        address payable[] memory emptyAddrs;
        return accessRequestInternal(requestNonce, emptyVals, emptyAddrs, contextHash, accessor, request_timestamp);
    }
    function makeNonce(uint256 reqId) private view returns(uint256) {
        return uint256(keccak256(abi.encodePacked(reqId, address(this))));
    }
    function accessRequestV3(bytes32[] memory customValues,
        address payable[] memory stakeholders) public payable returns (bool) {
        requestID = requestID + 1;
        uint256 requestNonce = makeNonce(requestID);
        accessRequestInternal(requestNonce, customValues, stakeholders, 0x0, msg.sender, now * 1000);
        RequestData memory r = RequestData(msg.sender, msg.value, 0, 0);
        requestMap[requestNonce] = r;
        return true;
    }
    function accessRequest(
        uint8,
        string memory pkeRequestor,
        string memory pkeAFGH,
        bytes32[] memory customValues,
        address payable[] memory stakeholders)
    public payable returns (uint256) {
        accessRequestV3(customValues, stakeholders);
        emit AccessRequest(requestID, 0, objectHash, pkeRequestor, pkeAFGH);
        return requestID;
    }
    function validateAccess(address accessor, bytes32[] memory custom_values, address payable[] memory stakeholders) internal {
        uint256 requiredFund;
        uint8 record343;
        uint8 accessCode;
        (record343, accessCode, requiredFund) = getAccessInfoV3(accessor, custom_values, stakeholders);
        if (accessCode == 100) { 
            require(msg.value >= uint(requiredFund));
            setPaidRights();
            accessCode = 0;
        }
        require(accessCode == 0);
    }
    function accessRequestInternal(uint256 requestNonce,
        bytes32[] memory custom_values,
        address payable[] memory stakeholders,
        bytes32 contextHash,
        address accessor,
        uint256 request_timestamp)
    internal returns (uint256) {
        validateAccess(accessor, custom_values, stakeholders);
        if (contentContractAddress != address(0x0)) {
            Content c = Content(contentContractAddress);
            uint result = c.runAccess(requestNonce, custom_values, stakeholders, accessor);
            require(result == 0);
        }
        emit AccessRequestV3(requestNonce, libraryAddress, contextHash, accessor, request_timestamp);
        uint256 i;
        for (i = 0; i < custom_values.length; i++) {
            if (custom_values[i] != 0x0) {
                emit AccessRequestValue(custom_values[i]);
            }
        }
        for (i = 0; i < stakeholders.length; i++) {
            if (stakeholders[i] != address(0x0)) {
                emit AccessRequestStakeholder(stakeholders[i]);
            }
        }
        return requestNonce;
    }
    function accessCompleteInternal(uint256 requestNonce, bytes32[] memory customValues, address[] memory stakeholders) public payable returns (bool) {
        bool success = true;
        if (contentContractAddress != address(0x0)) {
            Content c = Content(contentContractAddress);
            uint256 result = c.runFinalize(requestNonce, customValues, stakeholders, msg.sender);
            success = (result == 0);
        }
        return success;
    }
    function accessCompleteContext(uint256 _requestNonce,
        bytes32 _contextHash,
        address _accessor,
        uint256 _request_timestamp) public payable returns (bool) {
        require(msg.sender == addressKMS);
        bytes32[] memory emptyVals;
        address[] memory emptyAddrs;
        bool success = accessCompleteInternal(_requestNonce,  emptyVals, emptyAddrs);
        emit AccessCompleteV3(_requestNonce, success, libraryAddress, _contextHash, _accessor, _request_timestamp);
        return success;
    }
    function accessCompleteV3(uint256 requestNonce, bytes32[] memory customValues, address[] memory stakeholders) public payable returns (bool) {
        RequestData storage r = requestMap[requestNonce];
        require((r.originator != address(0x0)) && ((msg.sender == r.originator) || (msg.sender == owner)));
        bool success = accessCompleteInternal(requestNonce, customValues, stakeholders);
        if (msg.sender == r.originator) {
            if (success){
             r.status = 2; 
            } else {
             r.status = -2; 
          }
        }
        if (r.settled < r.amountPaid) {
            if (r.status <= 0) {
                makeRequestPayment(requestNonce, r.originator, "refund", r.amountPaid - r.settled);
            } else {
                makeRequestPayment(requestNonce, owner, "release escrow", r.amountPaid - r.settled);
            }
        }
        delete requestMap[requestNonce];
        emit AccessCompleteV3(requestNonce, success, libraryAddress, 0x0, msg.sender, now * 1000);
        return success;
    }
    function accessComplete(uint256 request_ID, uint256 score_pct, uint256) public payable returns (bool) {
        uint256 requestNonce = makeNonce(requestID);
        bytes32[] memory emptyVals;
        address[] memory emptyAddrs;
        bool success = accessCompleteV3(requestNonce, emptyVals, emptyAddrs);
        emit AccessComplete(request_ID, score_pct, success);
        return success;
    }
    function kill() public onlyFromLibrary {
        uint canKill = 0;
        if (contentContractAddress != address(0x0)) {
            canKill = Content(contentContractAddress).runKillExt();
        }
        require((canKill == 0) || (canKill == 100) || (canKill == 1000) || (canKill == 1100));
        if ((canKill == 100) || (canKill == 1100)){
            Content(contentContractAddress).commandKill();
        }
        selfdestruct(owner);
    }
    function setPaidRights() private {
    uint dummyVar = 1234; // dummy var

        address payable walletAddress = address(uint160(IUserSpace(contentSpace).userWallets(msg.sender)));
        AccessIndexor indexor = AccessIndexor(walletAddress);
        indexor.setAccessRights();
    }
}