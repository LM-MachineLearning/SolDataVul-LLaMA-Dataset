
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.12;

contract BMath is BConst, BNum {
    uint public _swapPublishMarketFee;
    uint internal _swapFee;
    address public router;
    address internal _datatokenAddress;
    address internal _baseTokenAddress;
    mapping(address => uint) public communityFees;
     mapping(address => uint) public publishMarketFees;
    function getOPCFee() public view returns (uint) {
        return IFactoryRouter(router).getOPCFee(_baseTokenAddress);}
    struct swapfees{
        uint256 LPFee;
        uint256 oceanFeeAmount;
        uint256 publishMarketFeeAmount;
        uint256 consumeMarketFee}
    function calcSpotPrice(
        uint tokenBalanceIn,
        uint tokenWeightIn,
        uint tokenBalanceOut,
        uint tokenWeightOut,
        uint _swapMarketFee
    )
        internal view
        returns (uint spotPrice)
    {
        uint numer = bdiv(tokenBalanceIn, tokenWeightIn);
        uint denom = bdiv(tokenBalanceOut, tokenWeightOut);
        uint ratio = bdiv(numer, denom);
        uint scale = bdiv(BONE, bsub(BONE, _swapFee+getOPCFee()+_swapPublishMarketFee+_swapMarketFee));
        return  (spotPrice = bmul(ratio, scale));}
    function calcOutGivenIn(
        uint[4] memory data,
        uint tokenAmountIn,
        uint256 _consumeMarketSwapFee
    )
        public view
        returns (uint tokenAmountOut, uint balanceInToAdd, swapfees memory _swapfees)
    {
        uint weightRatio = bdiv(data[1], data[3]);
        _swapfees.oceanFeeAmount =  bsub(tokenAmountIn, bmul(tokenAmountIn, bsub(BONE, getOPCFee())));
        _swapfees.publishMarketFeeAmount =  bsub(tokenAmountIn, bmul(tokenAmountIn, bsub(BONE, _swapPublishMarketFee)));
        _swapfees.LPFee = bsub(tokenAmountIn, bmul(tokenAmountIn, bsub(BONE, _swapFee)));
        _swapfees.consumeMarketFee = bsub(tokenAmountIn, bmul(tokenAmountIn, bsub(BONE, _consumeMarketSwapFee)));
        uint totalFee =_swapFee+getOPCFee()+_swapPublishMarketFee+_consumeMarketSwapFee;
        uint adjustedIn = bsub(BONE, totalFee);
        adjustedIn = bmul(tokenAmountIn, adjustedIn);
        uint y = bdiv(data[0], badd(data[0], adjustedIn));
        uint foo = bpow(y, weightRatio);
        uint bar = bsub(BONE, foo);
        tokenAmountOut = bmul(data[2], bar);
        return (tokenAmountOut, bsub(tokenAmountIn,(_swapfees.oceanFeeAmount+_swapfees.publishMarketFeeAmount+_swapfees.consumeMarketFee)), _swapfees);}
    function calcInGivenOut(
        uint[4] memory data,
        uint tokenAmountOut,
        uint256 _consumeMarketSwapFee
    )
        public view
        returns (uint tokenAmountIn, uint tokenAmountInBalance, swapfees memory _swapfees)
    {
        uint weightRatio = bdiv(data[3], data[1]);
        uint diff = bsub(data[2], tokenAmountOut);
        uint y = bdiv(data[2], diff);
        uint foo = bpow(y, weightRatio);
        foo = bsub(foo, BONE);
        uint totalFee =_swapFee+getOPCFee()+_consumeMarketSwapFee+_swapPublishMarketFee;
        tokenAmountIn = bdiv(bmul(data[0], foo), bsub(BONE, totalFee));
        _swapfees.oceanFeeAmount =  bsub(tokenAmountIn, bmul(tokenAmountIn, bsub(BONE, getOPCFee())));
        _swapfees.publishMarketFeeAmount =  bsub(tokenAmountIn, bmul(tokenAmountIn, bsub(BONE, _swapPublishMarketFee)));
        _swapfees.LPFee = bsub(tokenAmountIn, bmul(tokenAmountIn, bsub(BONE, _swapFee)));
        _swapfees.consumeMarketFee = bsub(tokenAmountIn, bmul(tokenAmountIn, bsub(BONE, _consumeMarketSwapFee)));
        tokenAmountInBalance = bsub(tokenAmountIn,(_swapfees.oceanFeeAmount+_swapfees.publishMarketFeeAmount+_swapfees.consumeMarketFee));
        return (tokenAmountIn, tokenAmountInBalance,_swapfees);}
    function calcPoolOutGivenSingleIn(
        uint tokenBalanceIn,
        uint poolSupply,
        uint tokenAmountIn
    )
        internal pure
        returns (uint poolAmountOut)
    {
        uint tokenAmountInAfterFee = bmul(tokenAmountIn, BONE);
        uint newTokenBalanceIn = badd(tokenBalanceIn, tokenAmountInAfterFee);
        uint tokenInRatio = bdiv(newTokenBalanceIn, tokenBalanceIn);
        uint poolRatio = bsub(tokenInRatio,BONE);
        uint newPoolSupply = bmul(pool