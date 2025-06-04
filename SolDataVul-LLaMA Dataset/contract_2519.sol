
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.12;

contract VulnerableContract {
#### [Answer];

interface IPool {
    function getDatatokenAddress() external view returns (address);
    function getBaseTokenAddress() external view returns (address);
    function getController() external view returns (address);
    function setup( address datatokenAddress, uint256 datatokenAmount, uint256 datatokennWeight, address baseTokenAddress, uint256 baseTokenAmount, uint256 baseTokenWeight ) external;
    function swapExactAmountIn( address[3] calldata tokenInOutMarket, uint256[4] calldata amountsInOutMaxFee ) external returns (uint256 tokenAmountOut, uint256 spotPriceAfter);
    function swapExactAmountOut( address[3] calldata tokenInOutMarket, uint256[4] calldata amountsInOutMaxFee ) external returns (uint256 tokenAmountIn, uint256 spotPriceAfter);
    function getAmountInExactOut( address tokenIn, address tokenOut, uint256 tokenAmountOut, uint256 _consumeMarketSwapFee ) external view returns (uint256, uint256, uint256, uint256, uint256);
    function getAmountOutExactIn( address tokenIn, address tokenOut, uint256 tokenAmountIn, uint256 _consumeMarketSwapFee ) external view returns (uint256, uint256, uint256, uint256, uint256);
    function setSwapFee(uint256 swapFee) external;
    function getId() pure external returns (uint8);
    function exitswapPoolAmountIn( uint256 poolAmountIn, uint256 minAmountOut ) external returns (uint256 tokenAmountOut);
    function joinswapExternAmountIn( uint256 tokenAmountIn, uint256 minPoolAmountOut ) external returns (uint256 poolAmountOut)};
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}