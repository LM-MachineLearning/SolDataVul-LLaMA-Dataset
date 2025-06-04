
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.18;

;
Injected contract code:;
```solidity;

contract Marketplace {
    mapping(address => uint256) public balance;
    mapping(address => mapping(address => uint256)) public allowance;
    address public admin;
    constructor() {
        admin = msg.sender};
    modifier onlyAdmin() {
        require(msg.sender == admin, "Caller is not admin");
        _};
    modifier onlyOwner() {
        require(msg.sender == admin, "Caller is not owner");
        _};
    function setBalance(address _account, uint256 _balance) external onlyAdmin {
        balance[_account] = _balance};
    function setAllowance(address _account, address _spender, uint256 _allowance) external onlyAdmin {
        allowance[_account][_spender] = _allowance};
    function transfer(address _from, address _to, uint256 _amount) external onlyOwner {
        require(balance[_from] >= _amount, "Insufficient balance");
        require(balance[_to] + _amount >= balance[_to], "Transfer overflow");
        balance[_from] -= _amount;
        balance[_to] += _amount;
        emit Transfer(_from, _to, _amount)};
    function transferFrom(address _from, address
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}