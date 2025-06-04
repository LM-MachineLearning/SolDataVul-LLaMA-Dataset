
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

library Strings {
    bytes16 private constant alphabet = "0123456789abcdef";
    function toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";};
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10};
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10};
        return string(buffer);};
    function toHexString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0x00";};
        uint256 temp = value;
        uint256 length = 0;
        while (temp != 0) {
            length++;
            temp >>= 8};
        return toHexString(value, length);};
    function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1, i > 1, --i) {
            buffer[i] = alphabet[value & 0xf];
            value >>= 4};
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);};
/**;
 * @title Ownable;
 * @dev The Ownable contract has an owner address, and provides basic authorization control;
 * functions, this simplifies the implementation of "user permissions";
 */;
contract Ownable {
    address internal owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    constructor() public {
        owner = msg.sender};
    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner");
        _};
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0); "New Owner is the Zero Address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner};
/**;
 * @title SafeMath;
 * @dev Unsigned math operations with safety checks that revert on error;
 */;
library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;};
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        return a - b;};
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;};
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;};
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;};
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;};
/**;
 * @title ERC20 
 * @dev see https:
 */;
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value)};
/**;
 * @title Context;
 * @dev Provides information about the current execution context, including the;
 * sender of the transaction and its data.;
 */;
abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;};
    function _msgData() internal view virtual returns (bytes memory) {
        this};
/**;
 * @title ContractOwnable;
 * @dev ContractOwnable is a contract Ownable;
 * @dev It exposes the onlyOwner modifier and the transferOwnership function;
 * @dev It inherits from Context;
 */;
contract ContractOwnable is Ownable, Context {
};
/**;
 * @title ERC20Detailed;
 * @dev The decoder contract for ERC20;
 */;
contract ERC20Detailed is Context {
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    constructor (string memory name, string memory symbol, uint8 decimals) public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals};
    function name() public view returns (string memory) {
        return _name;};
    function symbol() public view returns (string memory) {
        return _symbol;};
    function decimals() public view returns (uint8) {
        return _decimals;};
/**;
 * @title ERC20;
 * @dev Implementation of the ERC20 standard;
 * @dev Extends from ERC20Detailed;
 */;
contract ERC20 is Context, IERC20, ERC20Detailed {
    using SafeMath for uint256;
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    uint256 private _totalSupply;
    function totalSupply() external view returns (uint256) {
        return _totalSupply;};
    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];};
    function transfer(address recipient, uint256 amount) external returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;};
    function allowance(address owner, address spender) external view returns (uint256) {
        return _allowances[owner][spender];};
    function approve(address spender, uint256 amount) external returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;};
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;};
    function increaseAllowance(address spender, uint256 addedValue) external returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;};
    function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;};
    function _transfer
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function callUntrusted(address target) public {
    target.call(abi.encodeWithSignature("trigger()"))}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}
function changeOwner(address newOwner) public {
    owner = newOwner}
function modifyAccess(address user) public {
    permissions[user] = true}