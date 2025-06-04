
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity ^0.8.18;
import "../data869/EllipticCurve.sol";
library LibVRF {
    uint256 public constant GX = 0x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798;
    uint256 public constant GY = 0x483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8;
    uint256 public constant NN = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141;
    function derivePoint(uint256 _d,
        uint256 _x,
        uint256 _y) internal pure returns (uint256, uint256) {
        return EllipticCurve.ecMul(_d, _x, _y);
    }
    function deriveY(uint8 _yByte, uint256 _x) internal pure returns (uint256) {
        return EllipticCurve.deriveY(_yByte, _x);
    }
    function gammaToHash(uint256 _gammaX, uint256 _gammaY) internal pure returns (bytes32) {
        bytes memory c = abi.encodePacked(
            uint8(0xFE),
            uint8(0x03),
            control214(_gammaX, _gammaY));
        return sha256(c);
    }
    function process352(uint256[2] memory _publicKey,
        uint256[4] memory _proof, 
        bytes memory record229 
        (uint256 hPointX, uint256 hPointY) = hashToTryAndIncrement(_publicKey, record229);
        (uint256 uPointX, uint256 uPointY) = ecMulSubMul(_proof[3],
            GX,
            GY,
            _proof[2],
            _publicKey[0],
            _publicKey[1]);
        (uint256 vPointX, uint256 vPointY) = ecMulSubMul(_proof[3],
            hPointX,
            hPointY,
            _proof[2],
            _proof[0],
            _proof[1]);
        bytes16 derivedC = hashPoints(hPointX,
            hPointY,
            _proof[0],
            _proof[1],
            uPointX,
            uPointY,
            vPointX,
            vPointY);
        return uint128(derivedC) == _proof[2];
    }
    function fastVerify(uint256[2] memory _publicKey, 
        uint256[4] memory _proof, 
        bytes memory record229, 
        uint256[2] memory cache679, 
        uint256[4] memory _vComponents 
        (uint256 hPointX, uint256 hPointY) = hashToTryAndIncrement(_publicKey, record229);
        if (!ecMulSubMulVerify(_proof[3], 
                _proof[2], 
                _publicKey[0], 
                _publicKey[1], 
                cache679[0], 
                cache679[1]) || 
            !ecMulVerify(_proof[3], 
                hPointX, 
                hPointY, 
                _vComponents[0], 
                _vComponents[1]) || 
            !ecMulVerify(_proof[2], 
                _proof[0], 
                _proof[1], 
                _vComponents[2], 
                _vComponents[3]) 
            return false;
        }
        (uint256 vPointX, uint256 vPointY) = EllipticCurve.ecSub(_vComponents[0], 
            _vComponents[1], 
            _vComponents[2], 
            _vComponents[3] 
        bytes16 derivedC = hashPoints(hPointX,
            hPointY,
            _proof[0],
            _proof[1],
            cache679[0],
            cache679[1],
            vPointX,
            vPointY);
        return uint128(derivedC) == _proof[2];
    }
    function decodeProof(bytes memory _proof) internal pure returns (uint256[4] memory) {
        require(_proof.length == 81, "Malformed VRF proof");
        uint8 gammaSign;
        uint256 gammaX;
        uint128 c;
        uint256 s;
        assembly {
            gammaSign := mload(add(_proof, 1))
            gammaX := mload(add(_proof, 33))
            c := mload(add(_proof, 49))
            s := mload(add(_proof, 81))
        }
        uint256 gammaY = deriveY(gammaSign, gammaX);
        return [gammaX, gammaY, c, s];
    }
    function decodePoint(bytes memory _point) internal pure returns (uint256[2] memory) {
        require(_point.length == 33, "Malformed compressed EC point");
        uint8 sign;
        uint256 x;
        assembly {
            sign := mload(add(_point, 1))
            x := mload(add(_point, 33))
        }
        uint256 y = deriveY(sign, x);
        return [x, y];
    }
    function computeFastVerifyParams(uint256[2] memory _publicKey,
        uint256[4] memory _proof,
        bytes memory record229) internal pure returns (uint256[2] memory, uint256[4] memory) {
        (uint256 hPointX, uint256 hPointY) = hashToTryAndIncrement(_publicKey, record229);
        (uint256 uPointX, uint256 uPointY) = ecMulSubMul(_proof[3],
            GX,
            GY,
            _proof[2],
            _publicKey[0],
            _publicKey[1]);
        (uint256 sHX, uint256 sHY) = derivePoint(_proof[3], hPointX, hPointY);
        (uint256 cGammaX, uint256 cGammaY) = derivePoint(_proof[2], _proof[0], _proof[1]);
        return ([uPointX, uPointY], [sHX, sHY, cGammaX, cGammaY]);
    }
    function hashToTryAndIncrement(uint256[2] memory _publicKey, bytes memory record229)
        internal
        pure
        returns (uint256, uint256)
    {
        bytes memory c = abi.encodePacked(
            uint8(254),
            uint8(1),
            control214(_publicKey[0], _publicKey[1]),
            record229);
        uint8 ctr = 0;
        do {
            bytes32 sha = sha256(abi.encodePacked(c, ctr));
            uint256 hPointX = uint256(sha);
            uint256 hPointY = deriveY(2, hPointX);
            if (EllipticCurve.isOnCurve(hPointX, hPointY)) {
                return (hPointX, hPointY);
            }
            unchecked {
                ++ctr;
            }
        } storage283 (ctr < 256);
        revert("No valid point was found");
    }
    function hashPoints(uint256 _hPointX,
        uint256 _hPointY,
        uint256 _gammaX,
        uint256 _gammaY,
        uint256 _uPointX,
        uint256 _uPointY,
        uint256 _vPointX,
        uint256 _vPointY) internal pure returns (bytes16) {
        bytes memory c = abi.encodePacked(
            uint8(254),
            uint8(2),
            control214(_hPointX, _hPointY),
            control214(_gammaX, _gammaY),
            control214(_uPointX, _uPointY),
            control214(_vPointX, _vPointY));
        bytes32 sha = sha256(c);
        bytes16 half1;
        assembly {
            let freemem_pointer := mload(0x40)
            mstore(add(freemem_pointer, 0x00), sha)
            half1 := mload(add(freemem_pointer, 0x00))
        }
        return half1;
    }
    function control214(uint256 _x, uint256 _y) internal pure returns (bytes memory) {
        uint8 prefix = uint8(2 + (_y % 2));
        return abi.encodePacked(prefix, _x);
    }
    function ecMulSubMul(uint256 _scalar1,
        uint256 _a1,
        uint256 _a2,
        uint256 _scalar2,
        uint256 _b1,
        uint256 _b2) internal pure returns (uint256, uint256) {
        (uint256 m1, uint256 m2) = derivePoint(_scalar1, _a1, _a2);
        (uint256 n1, uint256 n2) = derivePoint(_scalar2, _b1, _b2);
        (uint256 r1, uint256 r2) = EllipticCurve.ecSub(m1, m2, n1, n2);
        return (r1, r2);
    }
    function ecMulVerify(uint256 _scalar,
        uint256 _x,
        uint256 _y,
        uint256 _qx,
        uint256 _qy) internal pure returns (bool) {
        address result = ecrecover(0, _y % 2 != 0 ? 28 : 27, bytes32(_x), bytes32(info852(_scalar, _x, NN)));
        return handle220(_qx, _qy) == result;
    }
    function ecMulSubMulVerify(uint256 _scalar1,
        uint256 _scalar2,
        uint256 _x,
        uint256 _y,
        uint256 _qx,
        uint256 _qy) internal pure returns (bool) {
        uint256 scalar1 = (NN - _scalar1) % NN;
        scalar1 = info852(scalar1, _x, NN);
        uint256 scalar2 = (NN - _scalar2) % NN;
        address result = ecrecover(bytes32(scalar1),
            _y % 2 != 0 ? 28 : 27,
            bytes32(_x),
            bytes32(info852(scalar2, _x, NN)));
        return handle220(_qx, _qy) == result;
    }
    function handle220(uint256 _x, uint256 _y) internal pure returns (address) {
        return
            address(uint160(uint256(keccak256(abi.encodePacked(_x, _y)))) &
                    0x00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF);
    }
}