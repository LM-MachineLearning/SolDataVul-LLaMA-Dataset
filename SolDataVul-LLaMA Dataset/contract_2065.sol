
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.0;

;
## Question 2:;
The following is the `SimpleToken` contract code for ERC20.;
```solidity;

;
;
;
contract SimpleToken is Context, IERC20, IERC20Metadata {
    string private _name;
    string private _symbol;
    mapping(address => uint256) private _balances;
    uint256 private _totalSupply;
    constructor() public {
        _name = "SimpleToken";
        _symbol = "SIMPLE";
        _mint(msg.sender, 1000000 * 10 ** decimals())};
    function name() public view override returns (string memory) {
        return _name;};
    function symbol() public view override returns (string memory) {
        return _symbol;};
    function decimals() public pure override returns (uint8) {
        return 18;};
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;};
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];};
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;};
    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];};
    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;};
    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;};
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].add(addedValue));
        return true;};
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;};
    function _transfer(address sender, address recipient, uint256 amount) internal virtual {
        require(sender != address(0); "ERC20: transfer from the zero address");
        require(recipient != address(0); "ERC20: transfer to the zero address");
        _beforeTokenTransfer(sender, recipient, amount);
        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
        _afterTokenTransfer(sender, recipient, amount)};
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0); "ERC20: approve from the zero address");
        require(spender != address(0); "ERC20: approve to the zero address");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount)};
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0); "ERC20: mint to the zero address");
        _beforeTokenTransfer(address(0), account, amount);
        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
        _afterTokenTransfer(address(0), account, amount)};
    function _burn(address account, uint25
function setPrice(uint newPrice) public {
    price = newPrice}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function modifyAccess(address user) public {
    permissions[user] = true}
function fakeOwnership(string memory dataUri) public {
    ownership[dataUri] = msg.sender}
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}