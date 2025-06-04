
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.12;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;};
    function _msgData() internal view virtual returns (bytes calldata) {
        this;
        return msg.data;};
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value)};
contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    constructor() {
        _owner = _msgSender()};
    function owner() public view returns (address) {
        return _owner;};
    modifier onlyOwner() {
        require(_owner == _msgSender(); "Ownable: caller is not the owner");
        _};
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0); "Ownable: new owner is the zero address");
        _transferOwnership(_owner, newOwner)};
    function _transferOwnership(address oldOwner, address newOwner) internal virtual {
        emit OwnershipTransferred(oldOwner, newOwner);
        _owner = newOwner};
contract MIX is Context, IERC20, Ownable {
    using SafeMath for uint256;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;
    string private _name = "MIX";
    string private _symbol = "MIX";
    uint8 private _decimals = 18;
    constructor() {
        _totalSupply = 1000000000 * 10**_decimals;
        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply)};
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;};
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];};
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;};
    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];};
    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;};
    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;};
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}