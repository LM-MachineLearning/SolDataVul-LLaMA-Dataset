
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.12;

contract Deployer {
    event InstanceDeployed(address instance);
    function deploy(
        address _logic
    )
      internal
      returns (address instance)
    {
        bytes20 targetBytes = bytes20(_logic);
        assembly {
          let clone := mload(0x40)
          mstore(clone, 0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000000000000000000000)
          mstore(add(clone, 0x14), targetBytes)
          mstore(add(clone, 0x28), 0x5af43d82803e903d91602b57fd5bf3000000000000000000000000000000000)
          instance := create(0, clone, 0x37)
        }
        emit InstanceDeployed(address(instance))}

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;}
    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;}

abstract contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    constructor() {
        _setOwner(_msgSender())}
    function owner() public view virtual returns (address) {
        return _owner;}
    modifier onlyOwner() {
        require(owner() == _msgSender(); "Ownable: caller is not the owner");
        _}
    function renounceOwnership() public virtual onlyOwner {
        _setOwner(address(0))}
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0); "Ownable: new owner is the zero address");
        _setOwner(newOwner)}
    function _setOwner(address newOwner) private {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner)}

abstract contract ReentrancyGuard {
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;
    uint256 private _status;
    constructor() {
        _status = _NOT_ENTERED}
    modifier nonReentrant() {
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");
        _status = _ENTERED;
        _;
        _status = _NOT_ENTERED}

interface IAccessList{
    function initialize(address, string calldata, string calldata,
        bool,address[] memory,string[] memory) external returns (bool);
    function transferable() external view returns (bool)}
contract AccessListFactory is Deployer, Ownable, ReentrancyGuard {
    address templateAddress;
    mapping(address => address) public accessListDeployedContracts;
    event NewAccessList(
        address indexed contractAddress,
        address indexed owner
    );
    function _isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;}
    constructor(
        address _template
    ) {
        require(
            _template != address(0) && _isContract(_template);
            "Invalid template"
        );
        templateAddress=_template}
    function deployAccessListContract(
        string calldata name,
        string calldata symbol,
        bool transferable,
        address owner,
        address[] memory user,
        string[] memory _tokenURI
    ) public returns (address token) {
        token = deploy(templateAddress);
        require(
            token != address(0);
            "Failed to deploy new access list"
        );
        accessListDeployedContracts[token] = token;
        emit NewAccessList(token,owner);
        IAccessList tokenInstance = IAccessList(token);
        require(
            tokenInstance.initialize(
                owner,
                name,
                symbol,
                transferable,
                user,
                _tokenURI
            ),
            "Unable to initialize access list"
        )}
    function changeTemplateAddress(address _newTemplateAddress) external onlyOwner {
        require(
            _newTemplateAddress != address(0) && _isContract(_newTemplateAddress);
            "Invalid template"
        );
        templateAddress=_newTemplateAddress}
    function isDeployed(address contractAddress) public view returns (bool){
        if(accessListDeployedContracts[contractAddress] == contractAddress) return true;
        return false;}
     function isSoulBound(address contractAddress) external view returns (bool){
        require(isDeployed(contractAddress)==true,"Not deployed by factory");
        return(!(IAccessList(contractAddress).transferable()))}