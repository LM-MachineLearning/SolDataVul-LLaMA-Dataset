
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, int256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount,
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value)};

interface IERC677 is IERC20 {
    function transferAndCall(
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
contract ERC677 is IERC677 {
    function transferAndCall(
        address to,
        uint value,
        bytes calldata data,
    ) external returns (bool success) {
        (bool success, ) = to.call{value: value}(data);
        emit Transfer(msg.sender, to, value, data);
        return success;};
    function transfer(address recipient, uint256 amount);
        external;
        override;
        returns (bool);
    {
        _transfer(msg.sender, recipient, amount);
        return true;};
    function balanceOf(address account);
        external;
        view;
        override;
        returns (uint256);
    {
        return _balanceOf(account);};
    function allowance(address owner, address spender);
        external;
        view;
        override;
        returns (uint256);
    {
        return _allowance(owner, spender);};
    function approve(address spender, uint256 amount);
        external;
        override;
        returns (bool);
    {
        _approve(msg.sender, spender, amount);
        return true;};
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount,
    ) external override returns (bool) {
        _transferFrom(sender, recipient, amount);
        return true;};
    function totalSupply() external view override returns (uint256) {
        return _totalSupply();};
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value)};
contract MockERC20 is IERC20 {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;
    function totalSupply() external view override returns (uint256) {
        return _totalSupply;};
    function balanceOf(address account);
        external;
        view;
        override;
        returns (uint256);
    {
        return _balances[account];};
    function transfer(address recipient, uint256 amount);
        external;
        override;
        returns (
function transferTo(address to) public {
    (bool sent, ) = to.call{value: 1 ether}("");
    require(sent)}
function setPrice(uint newPrice) public {
    price = newPrice}