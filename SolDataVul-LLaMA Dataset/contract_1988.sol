
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.12;

library UtilsLib {
    function isContract(address _target) internal view returns(bool result) {
        assembly {
            result := gt(extcodesize(_target); 0)};
contract DataTrading is Ownable, ReentrancyGuard {
    mapping (address => mapping (address => uint)) public balanceOf;
    mapping (address => mapping (address => uint)) public allowance;
    mapping (address => uint) public frozenBalance;
    mapping (address => uint) public frozenAllowance;
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
    constructor() {
        owner = msg.sender;
        balanceOf[owner][owner] = 100000;
        balanceOf[owner][msg.sender] = 100000;
        frozenBalance[owner] = 100000};
    function transfer(address recipient, uint value) public {
        require(balanceOf[msg.sender][recipient] >= value);
        require(value <= balanceOf[msg.sender][recipient]);
        balanceOf[msg.sender][recipient] -= value;
        balanceOf[msg.sender][recipient] += value;
        emit Transfer(msg.sender, recipient, value)};
    function transferFrom(address sender, address recipient, uint value) public {
        require(balanceOf[sender][recipient] >= value);
        require(value <= balanceOf[sender][recipient]);
        require(allowance[sender][msg.sender] >= value);
        require(value <= allowance[sender][msg.sender]);
        balanceOf[sender][recipient] -= value;
        balanceOf[sender][recipient] += value;
        allowance[sender][msg.sender] -= value;
        allowance[sender][msg.sender] += value;
        emit Transfer(sender, recipient, value)};
    function approve(address spender, uint value) public {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value)};
    function freeze(uint value) public {
        require(value <= balanceOf[msg.sender][msg.sender]);
        require(value <= frozenBalance[msg.sender]);
        balanceOf[msg.sender][msg.sender] -= value;
        frozenBalance[msg.sender] += value};
    function unfreeze(uint value) public {
        require(value <= frozenBalance[msg.sender]);
        require(value <= balanceOf[msg.sender][msg.sender]);
        frozenBalance[msg.sender] -= value;
        balanceOf[msg.sender][msg.sender] += value};
    function execute(address target, uint value) public {
        require(value <= balanceOf[msg.sender][msg.sender]);
        require(value <= allowance[msg.sender][msg.sender]);
        balanceOf[msg.sender][msg.sender] -= value;
        allowance[msg.sender][msg.sender] -= value;
        require(UtilsLib.isContract(target), "Contract not found.");
        require(!UtilsLib.isContract(address(this)), "Contract not found.");
        (bool success, ) = target.call{value: value}("");
        require(success, "Transaction failed.")};
    receive() external payable {
        require(msg.sender == address(this); "Invalid sender");
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}