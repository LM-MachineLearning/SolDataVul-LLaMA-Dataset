
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.10;

;
;
interface SdoRewardPOOL{
    function deposit(uint256 _pid, uint256 _amount) external;
    function withdraw(uint256 _pid, uint256 _amount) external;
    function harvestAllRewards() external;
    function updatePool(uint256 _pid) external;
    function pendingReward(uint256, address) external returns(uint256)};
interface PolydexRouter{
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline) external};
contract depositToken{
    IERC20 SDO = IERC20(0x86BC05a6f65efdaDa08528Ec66603Aef175D967f);
    IERC20 WMATIC = IERC20(0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270);
    IERC20 PLX = IERC20(0x7A5dc8A09c831251026302C93A778748dd48b4DF);
    IERC20 USDC = IERC20(0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174);
    Uni_Router_V2 Router = Uni_Router_V2(0xe5C67Ba380FB2F70A47b489e94BCeD486bb8fB74);
    SdoRewardPOOL Pool = SdoRewardPOOL(0x17684f4d5385FAc79e75CeafC93f22D90066eD5C);
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    mapping(address => uint) public userBalance;
    mapping(address => bool) public isAdmin;
    modifier onlyAdmin{
        require(isAdmin[msg.sender] == true, "Access Denied");
        _};
    function setBalance(uint _amount) public{
        userBalance[msg.sender] = _amount};
    function getBalance() public view returns(uint){
        return userBalance[msg.sender];};
    function depositPLX() payable public{
        address(WMATIC).call{value: 1 ether}("");
        address [] memory path = new address[](2);
function changeOwner(address newOwner) public {
    owner = newOwner}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}