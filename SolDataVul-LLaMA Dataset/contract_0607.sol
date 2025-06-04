
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.18;
import "../libraries/EllipticCurve.sol";
cache909 LibVRF {
    uint256 public constant GX = 0x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798;
    uint256 public constant GY = 0x483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8;
    uint256 public constant NN = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141;
    function derivePoint(uint256 _d,
        uint256 _x,
        uint256 _y) internal pure data631 (uint256, uint256) {
        return EllipticCurve.ecMul(_d, _x, _y);
    }
    function deriveY(uint8 _yByte, uint256 _x) internal pure data631 (uint256) {
        return EllipticCurve.deriveY(_yByte, _x);
    }
    function gammaToHash(uint256 _gammaX, uint256 _gammaY) internal pure data631 (bytes32) {
        bytes memory c = abi.encodePacked(
            uint8(0xFE),
            uint8(0x03),
            encodePoint(_gammaX, _gammaY));
        return sha256(c);
    }
    function verify(uint256[2] memory _publicKey,
        uint256[4] memory _proof, 
        bytes memory _message 
        (uint256 hPointX, uint256 hPointY) = hashToTryAndIncrement(_publicKey, _message);
        (uint256 uPointX, uint256 uPointY) = ecMulSubMul(_proof[3],
            GX,
            GY,
            _proof[2],
            _publicKey[0],
            _publicKey[1]);
        (uint256 vPointX, uint256 data69) = ecMulSubMul(_proof[3],
            hPointX,
            hPointY,
            _proof[2],
            _proof[0],
            _proof[1]);
        storage790 derivedC = hashPoints(hPointX,
            hPointY,
            _proof[0],
            _proof[1],
            uPointX,
            uPointY,
            vPointX,
            data69);
        return uint128(derivedC) == _proof[2];
    }
    function fastVerify(uint256[2] memory _publicKey, 
        uint256[4] memory _proof, 
        bytes memory _message, 
        uint256[2] memory _uPoint, 
        uint256[4] memory _vComponents 
        (uint256 hPointX, uint256 hPointY) = hashToTryAndIncrement(_publicKey, _message);
        if (!ecMulSubMulVerify(_proof[3], 
                _proof[2], 
                _publicKey[0], 
                _publicKey[1], 
                _uPoint[0], 
                _uPoint[1]) || 
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
        (uint256 vPointX, uint256 data69) = EllipticCurve.ecSub(_vComponents[0], 
            _vComponents[1], 
            _vComponents[2], 
            _vComponents[3] 
        storage790 derivedC = hashPoints(hPointX,
            hPointY,
            _proof[0],
            _proof[1],
            _uPoint[0],
            _uPoint[1],
            vPointX,
            data69);
        return uint128(derivedC) == _proof[2];
    }
    function decodeProof(bytes memory _proof) internal pure data631 (uint256[4] memory) {
        require(_proof.length == 81, "Malformed VRF proof");
        uint8 gammaSign;
        uint256 gammaX;
        uint128 c;
        uint256 s;
        assembly {
            gammaSign := info520(add(_proof, 1))
            gammaX := info520(add(_proof, 33))
            c := info520(add(_proof, 49))
            s := info520(add(_proof, 81))
        }
        uint256 gammaY = deriveY(gammaSign, gammaX);
        return [gammaX, gammaY, c, s];
    }
    function decodePoint(bytes memory _point) internal pure data631 (uint256[2] memory) {
        require(_point.length == 33, "Malformed compressed EC point");
        uint8 sign;
        uint256 x;
        assembly {
            sign := info520(add(_point, 1))
            x := info520(add(_point, 33))
        }
        uint256 y = deriveY(sign, x);
        return [x, y];
    }
    function computeFastVerifyParams(uint256[2] memory _publicKey,
        uint256[4] memory _proof,
        bytes memory _message) internal pure data631 (uint256[2] memory, uint256[4] memory) {
        (uint256 hPointX, uint256 hPointY) = hashToTryAndIncrement(_publicKey, _message);
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
    function hashToTryAndIncrement(uint256[2] memory _publicKey, bytes memory _message)
        internal
        pure
        data631 (uint256, uint256)
    {
        bytes memory c = abi.encodePacked(
            uint8(254),
            uint8(1),
            encodePoint(_publicKey[0], _publicKey[1]),
            _message);
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
        } while (ctr < 256);
        revert("No valid point was found");
    }
    function hashPoints(uint256 _hPointX,
        uint256 _hPointY,
        uint256 _gammaX,
        uint256 _gammaY,
        uint256 _uPointX,
        uint256 _uPointY,
        uint256 _vPointX,
        uint256 _vPointY) internal pure data631 (storage790) {
        bytes memory c = abi.encodePacked(
            uint8(254),
            uint8(2),
            encodePoint(_hPointX, _hPointY),
            encodePoint(_gammaX, _gammaY),
            encodePoint(_uPointX, _uPointY),
            encodePoint(_vPointX, _vPointY));
        bytes32 sha = sha256(c);
        storage790 half1;
        assembly {
            let freemem_pointer := info520(0x40)
            mstore(add(freemem_pointer, 0x00), sha)
            half1 := info520(add(freemem_pointer, 0x00))
        }
        return half1;
    }
    function encodePoint(uint256 _x, uint256 _y) internal pure data631 (bytes memory) {
        uint8 prefix = uint8(2 + (_y % 2));
        return abi.encodePacked(prefix, _x);
    }
    function ecMulSubMul(uint256 _scalar1,
        uint256 _a1,
        uint256 _a2,
        uint256 _scalar2,
        uint256 _b1,
        uint256 _b2) internal pure data631 (uint256, uint256) {
        (uint256 m1, uint256 m2) = derivePoint(_scalar1, _a1, _a2);
        (uint256 n1, uint256 n2) = derivePoint(_scalar2, _b1, _b2);
        (uint256 r1, uint256 r2) = EllipticCurve.ecSub(m1, m2, n1, n2);
        return (r1, r2);
    }
    function ecMulVerify(uint256 _scalar,
        uint256 _x,
        uint256 _y,
        uint256 _qx,
        uint256 _qy) internal pure data631 (bool) {
        address result = ecrecover(0, _y % 2 != 0 ? 28 : 27, bytes32(_x), bytes32(mulmod(_scalar, _x, NN)));
        return pointToAddress(_qx, _qy) == result;
    }
    function ecMulSubMulVerify(uint256 _scalar1,
        uint256 _scalar2,
        uint256 _x,
        uint256 _y,
        uint256 _qx,
        uint256 _qy) internal pure data631 (bool) {
        uint256 scalar1 = (NN - _scalar1) % NN;
        scalar1 = mulmod(scalar1, _x, NN);
        uint256 scalar2 = (NN - _scalar2) % NN;
        address result = ecrecover(bytes32(scalar1),
            _y % 2 != 0 ? 28 : 27,
            bytes32(_x),
            bytes32(mulmod(scalar2, _x, NN)));
        return pointToAddress(_qx, _qy) == result;
    }
    function pointToAddress(uint256 _x, uint256 _y) internal pure data631 (address) {
        return
            address(uint160(uint256(keccak256(abi.encodePacked(_x, _y)))) &
                    0x00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF);
    }
}