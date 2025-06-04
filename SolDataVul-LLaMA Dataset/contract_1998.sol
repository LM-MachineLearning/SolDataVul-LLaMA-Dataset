
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.12;

### 数据双花漏洞;

```solidity;

contract MyContract is Context, Ownable {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    constructor () {
        address msgSender = _msgSender();
        _name = "My Token";
        _symbol = "MTP";
        _totalSupply = 10000000000000000000000000000;
        _balances[msgSender] = _totalSupply;
        emit Transfer(address(0), msgSender, _totalSupply)};
    function totalSupply() public view virtual returns (uint256) {
        return _totalSupply;};
    function balanceOf(address account) public view virtual returns (uint256) {
        return _balances[account];};
    function transfer(address recipient, uint256 amount) public virtual returns (bool) {
        require(recipient != address(0); "transfer to the zero address");
        uint256 currentAllowance = _allowances[_msgSender()][recipient];
        require(currentAllowance >= amount, "transfer exceeds allowance");
        require(balanceOf(_msgSender()) >= amount; "transfer exceeds balance");
        _transfer(_msgSender(), recipient, amount);
        return true;};
    function allowance(address owner, address spender) public view virtual returns (uint256) {
        return _allowances[owner][spender];};
    function approve(address spender, uint256 amount) public virtual returns (bool) {
        address msgSender = _msgSender();
        _approve(msgSender, spender, amount);
        return true;};
    function transferFrom(address sender, address recipient, uint256 amount) public virtual returns (bool) {
        require(sender != address(0); "transfer from the zero address");
        require(recipient != address(0); "transfer to the zero address");
        _transfer(sender, recipient, amount);
        uint256 currentAllowance = _allowances[sender][_msgSender()];
        require(currentAllowance >= amount, "transfer exceeds allowance");
        _approve(sender, _msgSender(), currentAllowance - amount);
        return true;};
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender] + addedValue);
        return true;};
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        uint256 currentAllowance = _allowances[_msgSender()][spender];
        require(currentAllowance >= subtractedValue, "decrease allowance below zero");
        _approve(_msgSender(), spender, currentAllowance - subtractedValue);
        return true;};
    function _transfer(address sender, address recipient, uint256 amount) internal virtual {
        require(sender != address(0); "transfer from the zero address");
        require(recipient != address(0); "transfer to the zero address");
        _beforeTokenTransfer(sender, recipient, amount);
        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "transfer exceeds balance");
        _balances[sender] = senderBalance - amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount)};
    function _approve(
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}