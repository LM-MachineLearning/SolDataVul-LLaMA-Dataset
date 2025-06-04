
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function newTransfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function newTransferFrom(
        address sender,
        address recipient,
        uint256 amount,
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value)};

interface IERC677 is IERC20 {
    function newTransferAndCall(
        address to,
        uint value,
        bytes calldata data,
    ) external returns (bool success);
    event Transfer(
        address indexed from,
        address indexed to,
        uint value,
        bytes data,
    )};


interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function newTransfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function newTransferFrom(
        address sender,
        address recipient,
        uint256 amount,
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value)};

interface IERC677 is IERC20 {
    function newTransferAndCall(
        address to,
        uint value,
        bytes calldata data,
    ) external returns (bool success);
    event Transfer(
        address indexed from,
        address indexed to,
        uint value,
        bytes data,
    )};
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}