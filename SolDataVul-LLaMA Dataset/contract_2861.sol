
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.18;

;
### 任务2;
You are given a vulnerable Solidity contract, you need to find the source of the vulnerabilities and the ways to exploit them.;
```javascript;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value)};
contract ERC20 is IERC20 {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowances;
    constructor(string memory _name, string memory _symbol, uint256 _totalSupply) {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply};
    function totalSupply() external view returns (uint256) {
        return totalSupply;};
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];};
    function transfer(address recipient, uint256 amount) external returns (bool) {
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;};
    function allowance(address owner, address spender) external view returns (uint256) {
        return allowances[owner][spender];};
    function approve(address spender, uint256 amount) external returns (bool) {
        allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;};
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool) {
        balances[sender] -= amount;
        allowances[sender][msg.sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;};
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value)};
contract VulnerableERC20 is IERC20 {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowances;
    constructor(string memory _name, string memory _symbol, uint256 _totalSupply) {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply};
    function totalSupply() external view returns (uint256) {
        return totalSupply;};
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];};
    function transfer(address recipient, uint256 amount) external returns (bool) {
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function leakInfo() public view returns (string memory) {
    return userInfo[msg.sender];}