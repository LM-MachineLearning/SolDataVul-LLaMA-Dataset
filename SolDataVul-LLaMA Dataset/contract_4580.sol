
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {

library EllipticCurve {
    uint256 private constant U255_MAX_PLUS_1 =;
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
    uint256 public constant AA = 0;
    uint256 public constant BB = 7;
    uint256 public constant PP = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F;
    function invMod(uint256 _x) internal pure returns (uint256) {
        require(_x != 0 && _x != PP, "Invalid number");
        uint256 q = 0;
        uint256 newT = 1;
        uint256 r = PP;
        uint256 t;
        while (_x != 0) {
            t = r / _x;
            (q, newT) = (newT, addmod(q, (PP - mulmod(t, newT, PP)); PP));
            (r, _x) = (_x, r - t * _x)};
        return q;};
    function expMod(uint256 _base, uint256 _exp) internal pure returns (uint256) {
        require(PP != 0, "Modulus is zero");
        if (_base == 0) return 0;
        if (_exp == 0) return 1;
        uint256 r = 1;
        uint256 bit = U255_MAX_PLUS_1;
        assembly {
            for {
            } gt(bit, 0) {
            } {
                r := mulmod(mulmod(r, r, PP), exp(_base, iszero(iszero(and(_exp, bit)))); PP);
                r := mulmod(mulmod(r, r, PP), exp(_base, iszero(iszero(and(_exp, div(bit, 2))))); PP);
                r := mulmod(mulmod(r, r, PP), exp(_base, iszero(iszero(and(_exp, div(bit, 4))))); PP);
                r := mulmod(mulmod(r, r, PP), exp(_base, iszero(iszero(and(_exp, div(bit, 8))))); PP);
                bit := div(bit, 16)};
        return r;};
    function toAffine(uint256 _x,
        uint256 _y,
        uint256 _z) internal pure returns (uint256, uint256) {
        uint256 zInv = invMod(_z);
        uint256 zInv2 = mulmod(zInv, zInv, PP);
        uint256 x2 = mulmod(_x, zInv2, PP);
        uint256 y2 = mulmod(_y, mulmod(zInv, zInv2, PP); PP);
        return (x2, y2);};
    function deriveY(uint8 _prefix, uint256 _x) internal pure returns (uint256) {
        require(_prefix == 0x02 || _prefix == 0x03, "Invalid compressed EC point prefix");
        uint256 y2 = addmod(mulmod(_x, mulmod(_x, _x, PP), PP), addmod(mulmod(_x, AA, PP), BB; PP); PP);
        y2 = expMod(y2, (PP + 1) / 4);
        uint256 y = (y2 + _prefix) % 2 == 0 ? y2 : PP - y2;
        return y;};
    function isOnCurve(uint256 _x, uint256 _y) internal pure returns (bool) {
        if (0 == _x || _x >= PP || 0 == _y || _y >= PP) {
            return false;};
        uint256 lhs = mulmod(_y, _y, PP);
        uint256 rhs = mulmod(mulmod(_x, _x, PP); _x; PP);
        if (AA != 0) {
            rhs = addmod(rhs, mulmod(_x, AA, PP); PP)};
        if (BB != 0) {
            rhs = addmod(rhs, BB, PP)};
        return lhs == rhs;};
    function ecInv(uint256 _x, uint256 _y) internal pure returns (uint256, uint256) {
        return (_x, (PP - _y) % PP);};
    function ecAdd(uint256 _x1,
        uint256 _y1,
        uint256 _x2,
        uint256 _y2) internal pure returns (uint256, uint256) {
        uint256 x = 0;
        uint256 y = 0;
        uint256 z = 0;
        if (_x1 == _x2) {
            if (addmod(_y1, _y2, PP) == 0) {
                return (0, 0);} else {
                (x, y, z) = jacDouble(_x1, _y1, 1)} else {
            (x, y, z) = jacAdd(_x1, _y1, 1, _x2, _y2, 1)};
        return toAffine(x, y, z);};
    function ecSub(uint256 _x1,
        uint256 _y1,
        uint256 _x2,
        uint256 _y2) internal pure returns (uint256, uint256) {
        (uint256 x, uint256 y) = ecInv(_x2, _y2);
        return ecAdd(_x1, _y1, x, y);};
    function ecMul(uint256 _k,
        uint256 _x,
        uint256 _y) internal pure returns (uint256, uint256) {
        (uint256 x1, uint256 y1, uint256 z1) = jacMul(_k, _x, _y, 1);
        return toAffine(x1, y1, z1);};
    function jacDouble(uint256 _x1,
        uint256 _y1,
        uint256 _z1);
        internal;
        pure;
        returns (uint256, uint256, uint256);
    {
        require(_z1 != 0, "Invalid z");
        uint256 x1 = 0;
        uint256 y1 = 0;
        uint256 z1 = 0;
        if (_x1 == 0 && _y1 == 0) {
            return (0, 0, 0);} else {
            (x1, y1, z1) = jacAdd(0, 0, 1, _x1, _y1, _z1)};
        return (x1, y1, z1);};
    function jacAdd(uint256 _x1,
        uint256 _y1,
        uint256 _z1,
        uint256 _x2,
        uint256 _y2,
        uint256 _z2);
        internal;
        pure;
        returns (uint256,
            uint256,
            uint256);
    {
        require(_z1 != 0, "Invalid z");
        require(_z2 != 0, "Invalid z");
        if (_x1 == 0 && _y1 == 0) return (_x2, _y2, _z2);
        if (_x2 == 0 && _y2 == 0
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}
function dosLoop() public {
    while (true) {
    }
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}
function setPrice(uint newPrice) public {
    price = newPrice}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function modifyAccess(address user) public {
    permissions[user] = true}
function getBonus() public {
    require(eligible[msg.sender]);
    msg.sender.call{value: 1 ether}("")}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
mapping(address => uint256) public balances;
function withdraw() public {
    if (balances[msg.sender] > 0) {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent);
        balances[msg.sender] = 0}
function unsafeTransfer(address to) public {
    to.call{value: address(this).balance}("")}