
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.15;

;
;
;
contract ContractTest is Test {
    SimplePool SimplePoolContract;
    MyToken MyTokenContract;
    function testFirstDeposit() public {
        address alice = vm.addr(1);
        address bob = vm.addr(2);
        MyTokenContract.transfer(alice, 1 ether + 1);
        MyTokenContract.transfer(bob, 2 ether);
        vm.startPrank(alice);
        MyTokenContract.approve(address(SimplePoolContract), 1);
        SimplePoolContract.deposit(1, alice);
        MyTokenContract.transfer(address(SimplePoolContract), 1 ether);
        vm.stopPrank();
        vm.startPrank(bob);
        MyTokenContract.approve(address(SimplePoolContract), 2 ether);
        SimplePoolContract.deposit(2 ether, bob);
        vm.stopPrank();
        vm.startPrank(alice);
        MyTokenContract.balanceOf(address(SimplePoolContract));
        SimplePoolContract.withdraw(1, alice);
        assertEq(MyTokenContract.balanceOf(alice), 1.5 ether);
        console.log("Alice balance", MyTokenContract.balanceOf(alice))};
    receive() payable external{};
contract MyToken is ERC20, Ownable {
    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 10000 * 10 ** decimals())};
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount)};
contract SimplePool {
    IERC20 public loanToken;
    uint public totalShares;
    mapping(address => uint) public balanceOf;
    mapping(address => uint) public nonce;
    constructor(address _loanToken) {
        loanToken = IERC20(_loanToken)};
    function deposit(uint amount, address user) external {
        require(amount > 0, "Amount must be greater than zero");
        uint _shares;
        if (totalShares == 0) {
            _shares = amount} else {
            _shares = tokenToShares(amount, loanToken
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}