
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
    function changeTemplateAddress(address _newTemplateAddress) external onlyOwner {
        require(
            _newTemplateAddress != address(0) && _isContract(_newTemplateAddress);
            "Invalid template";
        );
        templateAddress=_newTemplateAddress};
    function isDeployed(address contractAddress) public view returns (bool){
        if(accessListDeployedContracts[contractAddress] == contractAddress) return true;
        return false;};
     function isSoulBound(address contractAddress) external view returns (bool){
        require(isDeployed(contractAddress)==true,"Not deployed by factory");
        return(!(IAccessList(contractAddress).transferable()))};
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}