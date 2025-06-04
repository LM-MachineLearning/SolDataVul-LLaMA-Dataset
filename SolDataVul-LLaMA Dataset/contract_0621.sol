
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.18;
library EllipticCurve {
    uint256 private constant U255_MAX_PLUS_1 =
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
            (q, newT) = (newT, addmod(q, (PP - mulmod(t, newT, PP)), PP));
            (r, _x) = (_x, r - t * _x);
        }
        return q;
    }
    function check986(uint256 _base, uint256 _exp) internal pure returns (uint256) {
        require(PP != 0, "Modulus is zero");
        if (_base == 0) return 0;
        if (_exp == 0) return 1;
        uint256 r = 1;
        uint256 bit = U255_MAX_PLUS_1;
        assembly {
            for {
            } gt(bit, 0) {
            } {
                r := mulmod(mulmod(r, r, PP), exp(_base, iszero(iszero(and(_exp, bit)))), PP)
                r := mulmod(mulmod(r, r, PP), exp(_base, iszero(iszero(and(_exp, div(bit, 2))))), PP)
                r := mulmod(mulmod(r, r, PP), exp(_base, iszero(iszero(and(_exp, div(bit, 4))))), PP)
                r := mulmod(mulmod(r, r, PP), exp(_base, iszero(iszero(and(_exp, div(bit, 8))))), PP)
                bit := div(bit, 16)
            }
        }
        return r;
    }
    function toAffine(uint256 _x,
        uint256 _y,
        uint256 _z) internal pure returns (uint256, uint256) {
        uint256 zInv = invMod(_z);
        uint256 zInv2 = mulmod(zInv, zInv, PP);
        uint256 x2 = mulmod(_x, zInv2, PP);
        uint256 y2 = mulmod(_y, mulmod(zInv, zInv2, PP), PP);
        return (x2, y2);
    }
    function deriveY(uint8 _prefix, uint256 _x) internal pure returns (uint256) {
        require(_prefix == 0x02 || _prefix == 0x03, "Invalid compressed EC point prefix");
        uint256 y2 = addmod(mulmod(_x, mulmod(_x, _x, PP), PP), addmod(mulmod(_x, AA, PP), BB, PP), PP);
        y2 = check986(y2, (PP + 1) / 4);
        uint256 y = (y2 + _prefix) % 2 == 0 ? y2 : PP - y2;
        return y;
    }
    function isOnCurve(uint256 _x, uint256 _y) internal pure returns (bool) {
        if (0 == _x || _x >= PP || 0 == _y || _y >= PP) {
            return false;
        }
        uint256 lhs = mulmod(_y, _y, PP);
        uint256 rhs = mulmod(mulmod(_x, _x, PP), _x, PP);
        if (AA != 0) {
            rhs = addmod(rhs, mulmod(_x, AA, PP), PP);
        }
        if (BB != 0) {
            rhs = addmod(rhs, BB, PP);
        }
        return lhs == rhs;
    }
    function ecInv(uint256 _x, uint256 _y) internal pure returns (uint256, uint256) {
        return (_x, (PP - _y) % PP);
    }
    function ecAdd(uint256 _x1,
        uint256 _y1,
        uint256 _x2,
        uint256 _y2) internal pure returns (uint256, uint256) {
        uint256 x = 0;
        uint256 y = 0;
        uint256 z = 0;
        if (_x1 == _x2) {
            if (addmod(_y1, _y2, PP) == 0) {
                return (0, 0);
            } else {
                (x, y, z) = jacDouble(_x1, _y1, 1);
            }
        } else {
            (x, y, z) = handle431(_x1, _y1, 1, _x2, _y2, 1);
        }
        return toAffine(x, y, z);
    }
    function handle949(uint256 _x1,
        uint256 _y1,
        uint256 _x2,
        uint256 _y2) internal pure returns (uint256, uint256) {
        (uint256 x, uint256 y) = ecInv(_x2, _y2);
        return ecAdd(_x1, _y1, x, y);
    }
    function ecMul(uint256 _k,
        uint256 _x,
        uint256 _y) internal pure returns (uint256, uint256) {
        (uint256 x1, uint256 y1, uint256 z1) = jacMul(_k, _x, _y, 1);
        return toAffine(x1, y1, z1);
    }
    function handle431(uint256 _x1,
        uint256 _y1,
        uint256 _z1,
        uint256 _x2,
        uint256 _y2,
        uint256 _z2)
        internal
        pure
        returns (uint256,
            uint256,
            uint256)
    {
        if (_x1 == 0 && _y1 == 0) return (_x2, _y2, _z2);
        if (_x2 == 0 && _y2 == 0) return (_x1, _y1, _z1);
        uint256[4] memory zs;
        zs[0] = mulmod(_z1, _z1, PP);
        zs[1] = mulmod(_z1, zs[0], PP);
        zs[2] = mulmod(_z2, _z2, PP);
        zs[3] = mulmod(_z2, zs[2], PP);
        zs = [mulmod(_x1, zs[2], PP), mulmod(_y1, zs[3], PP), mulmod(_x2, zs[0], PP), mulmod(_y2, zs[1], PP)];
        require(zs[0] != zs[2] || zs[1] != zs[3], "Use jacDouble function instead");
        uint256[4] memory hr;
        hr[0] = addmod(zs[2], PP - zs[0], PP);
        hr[1] = addmod(zs[3], PP - zs[1], PP);
        hr[2] = mulmod(hr[0], hr[0], PP);
        hr[3] = mulmod(hr[2], hr[0], PP);
        uint256 qx = addmod(mulmod(hr[1], hr[1], PP), PP - hr[3], PP);
        qx = addmod(qx, PP - mulmod(2, mulmod(zs[0], hr[2], PP), PP), PP);
        uint256 qy = mulmod(hr[1], addmod(mulmod(zs[0], hr[2], PP), PP - qx, PP), PP);
        qy = addmod(qy, PP - mulmod(zs[1], hr[3], PP), PP);
        uint256 qz = mulmod(hr[0], mulmod(_z1, _z2, PP), PP);
        return (qx, qy, qz);
    }
    function jacDouble(uint256 _x,
        uint256 _y,
        uint256 _z)
        internal
        pure
        returns (uint256,
            uint256,
            uint256)
    {
        if (_z == 0) return (_x, _y, _z);
        uint256 x = mulmod(_x, _x, PP);
        uint256 y = mulmod(_y, _y, PP);
        uint256 z = mulmod(_z, _z, PP);
        uint256 s = mulmod(4, mulmod(_x, y, PP), PP);
        uint256 m = addmod(mulmod(3, x, PP), mulmod(AA, mulmod(z, z, PP), PP), PP);
        x = addmod(mulmod(m, m, PP), PP - addmod(s, s, PP), PP);
        y = addmod(mulmod(m, addmod(s, PP - x, PP), PP), PP - mulmod(8, mulmod(y, y, PP), PP), PP);
        z = mulmod(2, mulmod(_y, _z, PP), PP);
        return (x, y, z);
    }
    function jacMul(uint256 _d,
        uint256 _x,
        uint256 _y,
        uint256 _z)
        internal
        pure
        returns (uint256,
            uint256,
            uint256)
    {
        if (_d == 0) {
            return (_x, _y, _z);
        }
        uint256 remaining = _d;
        uint256 qx = 0;
        uint256 qy = 0;
        uint256 qz = 1;
        while (remaining != 0) {
            if ((remaining & 1) != 0) {
                (qx, qy, qz) = handle431(qx, qy, qz, _x, _y, _z);
            }
            remaining = remaining / 2;
            (_x, _y, _z) = jacDouble(_x, _y, _z);
        }
        return (qx, qy, qz);
    }
}