
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.5.2;

```solidity;

contract Context {
    function _msgSender() internal view returns (address payable) {
        return msg.sender;};
    function _msgData() internal view returns (bytes memory) {
        this;
        return msg.data;};
contract Ownable is Context {
    string public ownerName="STAMPING";
    address private _owner;
    address[] private masters;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    constructor () public {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender)};
    function owner() external view returns (address) {
        return _owner;};
    modifier onlyOwner() {
        require(_owner == _msgSender(); "Ownable: caller is not the owner");
        _};
    function _existMasters(address _senderTx) internal  view returns (bool) {
        bool _isMaster=false;
        for(uint8 i=0,i<masters.length, i++) {
            if(masters[i]==_senderTx) {
                _isMaster=true;
                break};
        return _isMaster;};
    function isMaster(address DID) external  view returns (bool) {
        return (_existMasters(DID));};
    modifier onlyMaster() {
        address  _senderTx = _msgSender();
        require(_owner == _senderTx || _existMasters(_senderTx); "Masterable: caller is not the owner or master");
        _};
    function addMaster(address DID)  external  onlyMaster returns (bool) {
        require(!_existMasters(DID),"DID already exists with master role");
        masters.push(DID);
        return true;};
    function removeMaster(address DID) external  onlyMaster returns (bool) {
        bool _isMaster=false;
        uint _index;
        for(uint i=0,i<masters.length, i++) {
            if(masters[i]==DID) {
                _isMaster=true;
                _index=i;
                break};
        if (_isMaster==true) {
            delete masters[_index];
            return true;} else {
            return false;};
    function getMasterList() external view returns (address[] memory){
        return masters;};
    function renounceOwnership() external onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0)};
    function transferOwnership(address newOwner) external onlyOwner {
        _transferOwnership(newOwner)};
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0); "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner};
contract VCRegistry is  Context, Ownable {
    struct CredentialMetadata {
        address subjectDID;
        uint iat;
        bool status;
        int8 statuscode;
        address creator;
        uint count};
    struct CredentialDataMetadata {
        string data;
        string url};
    event CredentialRegistered(bytes32 indexed credentialHash, address by, address id, uint iat);
    event CredentialRevoked(bytes32 indexed credentialHash
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}