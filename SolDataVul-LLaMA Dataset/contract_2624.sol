
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.12;

interface IAccessList{
    function initialize(address, string calldata, string calldata,
        bool,address[] memory,string[] memory) external returns (bool);
    function transferable() external view returns (bool)};

abstract contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    constructor() {
        _setOwner(_msgSender())};
    function owner() public view virtual returns (address) {
        return _owner;};
    modifier onlyOwner() {
        require(owner() == _msgSender(); "Ownable: caller is not the owner");
        _};
    function renounceOwnership() public virtual onlyOwner {
        _setOwner(address(0))};
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0); "Ownable: new owner is the zero address");
        _setOwner(newOwner)};
    function _setOwner(address newOwner) private {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner)};

abstract contract ReentrancyGuard {
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;
    uint256 private _status;
    constructor() {
        _status = _NOT_ENTERED};
    modifier nonReentrant() {
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");
        _status = _ENTERED;
        _;
        _status = _NOT_ENTERED};

contract AccessListFactory is Deployer, Ownable, ReentrancyGuard {
    address templateAddress;
    mapping(address => address) public accessListDeployedContracts;
    event NewAccessList(
        address indexed contractAddress,
        address indexed owner,
    );
    function _isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)};
        return size > 0;};
    constructor(
        address _template,
    ) {
        require(
            _template != address(0) && _isContract(_template);
            "Invalid template";
        );
        templateAddress=_template};
    function deployAccessListContract(
        string calldata name,
        string calldata symbol,
        bool transferable,
        address owner,
        address[] memory user,
        string[] memory _tokenURI,
    ) public returns (address token) {
        token = deploy(templateAddress);
        require(
            token != address(0);
            "Failed to deploy new access list";
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
                _tokenURI,
            ),;
            "Unable to initialize access list";
        )};
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}