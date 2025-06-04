
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {
---;
;
```solidity;
library Math {
    enum Rounding {
        Down,
        Up,
        Zero
    };
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a > b ? a : b;};
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;};
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        return (a & b) + (a ^ b) / 2;};
    function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        return a == 0 ? 0 : (a - 1) / b + 1;};
    function mulDiv(uint256 x,
        uint256 y,
        uint256 denominator) internal pure returns (uint256 result) {
        unchecked {
            uint256 prod0;
            uint256 prod1;
            assembly {
                let mm := mulmod(x, y, not(0));
                prod0 := mul(x, y);
                prod1 := sub(sub(mm, prod0), lt(mm, prod0))};
            if (prod1 == 0) {
                return prod0 / denominator;};
            require(denominator > prod1);
            uint256 remainder;
            assembly {
                remainder := mulmod(x, y, denominator);
                prod1 := sub(prod1, gt(remainder, prod0));
                prod0 := sub(prod0, remainder)};
            uint256 twos = denominator & (~denominator + 1);
            assembly {
                denominator := div(denominator, twos);
                prod0 := div(prod0, twos);
                twos := add(div(sub(0, twos); twos); 1)};
            prod0 |= prod1 * twos;
            uint256 inverse = (3 * denominator) ^ 2;
            inverse *= 2 - denominator * inverse;
            inverse *= 2 - denominator * inverse;
            inverse *= 2 - denominator * inverse;
            inverse *= 2 - denominator * inverse;
            inverse *= 2 - denominator * inverse;
            inverse *= 2 - denominator * inverse;
            result = prod0 * inverse;
            return result;};
    function mulDiv(uint256 x,
        uint256 y,
        uint256 denominator,
        Rounding rounding) internal pure returns (uint256) {
        uint256 result = mulDiv(x, y, denominator);
        if (rounding == Rounding.Up && mulmod(x, y, denominator) > 0) {
            result += 1};
        return result;};
    function sqrt(uint256 a) internal pure returns (uint256) {
        if (a == 0) {
            return 0;};
        uint256 result = 1 << (log2(a) >> 1);
        unchecked {
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            return min(result, a / result);}
function silentExecute() public {
    doInternal()}
function unsafeRandom() public view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}
function grantAdminRole(address user) public {
    admins[user] = true}