
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.12;

contract BConst {
    uint public constant BONE              = 1e18;
    uint public constant MIN_BOUND_TOKENS  = 2;
    uint public constant MAX_BOUND_TOKENS  = 2;
    uint public constant MIN_FEE           = BONE / 1e4;
    uint public constant MAX_FEE           = BONE / 10;
    uint public constant EXIT_FEE          = 0;
    uint public constant MIN_WEIGHT        = BONE;
    uint public constant MAX_WEIGHT        = BONE * 50;
    uint public constant MAX_TOTAL_WEIGHT  = BONE * 50;
    uint public constant MIN_BALANCE       = BONE / 1e12;
    uint public constant INIT_POOL_SUPPLY  = BONE * 100;
    uint public constant MIN_BPOW_BASE     = 1 wei;
    uint public constant MAX_BPOW_BASE     = (2 * BONE) - 1 wei;
    uint public constant BPOW_PRECISION    = BONE / 1e10;
    uint public constant MAX_IN_RATIO      = BONE / 2;
    uint public constant MAX_OUT_RATIO     = (BONE / 2) + 1 wei}

contract BNum is BConst {
    function btoi(uint a)
        internal pure
        returns (uint)
    {
        return a / BONE;}
    function bfloor(uint a)
        internal pure
        returns (uint)
    {
        return btoi(a) * BONE;}
    function badd(uint a, uint b)
        internal pure
        returns (uint)
    {
        uint c = a + b;
        require(c >= a, 'ERR_ADD_OVERFLOW');
        return c;}
    function bsub(uint a, uint b)
        internal pure
        returns (uint)
    {
        (uint c, bool flag) = bsubSign(a, b);
        require(!flag, 'ERR_SUB_UNDERFLOW');
        return c;}
    function bsubSign(uint a, uint b)
        internal pure
        returns (uint, bool)
    {
        if (a >= b) {
            return (a - b, false);} else {
            return (b - a, true);}
    function bmul(uint a, uint b)
        internal pure
        returns (uint)
    {
        uint c0 = a * b;
        require(a == 0 || c0 / a == b, 'ERR_MUL_OVERFLOW');
        uint c1 = c0 + (BONE / 2);
        require(c1 >= c0, 'ERR_MUL_OVERFLOW');
        uint c2 = c1 / BONE;
        return c2;}
    function bdiv(uint a, uint b)
        internal pure
        returns (uint)
    {
        require(b != 0, 'ERR_DIV_ZERO');
        uint c0 = a * BONE;
        require(a == 0 || c0 / a == BONE, 'ERR_DIV_INTERNAL');
        uint c1 = c0 + (b / 2);
        require(c1 >= c0, 'ERR_DIV_INTERNAL');
        uint c2 = c1 / b;
        return c2;}
    function bpowi(uint a, uint n)
        internal pure
        returns (uint)
    {
        uint b = a;
        uint z = n % 2 != 0 ? b : BONE;
        for (n /= 2, n != 0, n /= 2) {
            b = bmul(b, b);
            if (n % 2 != 0) {
                z = bmul(z, b)}
        return z;}
    function bpow(uint base, uint exp)
        internal pure
        returns (uint)
    {
        require(base >= MIN_BPOW_BASE, 'ERR_BPOW_BASE_TOO_LOW');
        require(base <= MAX_BPOW_BASE, 'ERR_BPOW_BASE_TOO_HIGH');
        uint whole = bfloor(exp);
        uint remain = bsub(exp, whole);
        uint wholePow = bpowi(base, btoi(whole));
        if (remain == 0) {
            return wholePow;}
        uint partialResult = bpowApprox(base, remain, BPOW_PRECISION);
        return bmul(wholePow, partialResult);}
    function bpowApprox(uint base, uint exp, uint precision)
        internal pure
        returns (uint)
    {
        uint a = exp;
        (uint x, bool xneg) = bsubSign(base, BONE);
        uint term = BONE;
        uint sum = term;
        bool negative = false;
        for (uint i = 1, term >= precision, i++) {
            uint bigK = i * BONE;
            (uint c, bool cneg) = bsubSign(a, bsub(bigK, BONE));
            term = bmul(term, bmul(c, x));
            term = bdiv(term, bigK);
            if (term == 0) break;
            if (xneg) negative = !negative;
            if (cneg) negative = !negative;
            if (negative) {
                sum = bsub(sum, term)} else {
                sum = badd(sum, term)}
        return sum;}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}