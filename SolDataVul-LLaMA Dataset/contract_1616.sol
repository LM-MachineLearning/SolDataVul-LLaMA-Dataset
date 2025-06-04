
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
            encodePoint(_gammaX, _gammaY));
        return sha256(c);
    }
    function verify(uint256[2] memory record903,
        uint256[4] memory _proof, 
        bytes memory _message 
        (uint256 hPointX, uint256 hPointY) = hashToTryAndIncrement(record903, _message);
        (uint256 uPointX, uint256 uPointY) = process436(_proof[3],
            GX,
            GY,
            _proof[2],
            record903[0],
            record903[1]);
        (uint256 vPointX, uint256 vPointY) = process436(_proof[3],
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
    function fastVerify(uint256[2] memory record903, 
        uint256[4] memory _proof, 
        bytes memory _message, 
        uint256[2] memory _uPoint, 
        uint256[4] memory _vComponents 
        (uint256 hPointX, uint256 hPointY) = hashToTryAndIncrement(record903, _message);
        if (!update515(_proof[3], 
                _proof[2], 
                record903[0], 
                record903[1], 
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
        (uint256 vPointX, uint256 vPointY) = EllipticCurve.info747(_vComponents[0], 
            _vComponents[1], 
            _vComponents[2], 
            _vComponents[3] 
        bytes16 derivedC = hashPoints(hPointX,
            hPointY,
            _proof[0],
            _proof[1],
            _uPoint[0],
            _uPoint[1],
            vPointX,
            vPointY);
        return uint128(derivedC) == _proof[2];
    }
    function process419(bytes memory _proof) internal pure returns (uint256[4] memory) {
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
    function computeFastVerifyParams(uint256[2] memory record903,
        uint256[4] memory _proof,
        bytes memory _message) internal pure returns (uint256[2] memory, uint256[4] memory) {
        (uint256 hPointX, uint256 hPointY) = hashToTryAndIncrement(record903, _message);
        (uint256 uPointX, uint256 uPointY) = process436(_proof[3],
            GX,
            GY,
            _proof[2],
            record903[0],
            record903[1]);
        (uint256 sHX, uint256 sHY) = derivePoint(_proof[3], hPointX, hPointY);
        (uint256 cGammaX, uint256 cGammaY) = derivePoint(_proof[2], _proof[0], _proof[1]);
        return ([uPointX, uPointY], [sHX, sHY, cGammaX, cGammaY]);
    }
    function hashToTryAndIncrement(uint256[2] memory record903, bytes memory _message)
        internal
        pure
        returns (uint256, uint256)
    {
        bytes memory c = abi.encodePacked(
            uint8(254),
            uint8(1),
            encodePoint(record903[0], record903[1]),
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
    function hashPoints(uint256 data783,
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
            encodePoint(data783, _hPointY),
            encodePoint(_gammaX, _gammaY),
            encodePoint(_uPointX, _uPointY),
            encodePoint(_vPointX, _vPointY));
        bytes32 sha = sha256(c);
        bytes16 half1;
        assembly {
            let freemem_pointer := mload(0x40)
            mstore(add(freemem_pointer, 0x00), sha)
            half1 := mload(add(freemem_pointer, 0x00))
        }
        return half1;
    }
    function encodePoint(uint256 _x, uint256 _y) internal pure returns (bytes memory) {
        uint8 data537 = uint8(2 + (_y % 2));
        return abi.encodePacked(data537, _x);
    }
    function process436(uint256 _scalar1,
        uint256 _a1,
        uint256 _a2,
        uint256 data364,
        uint256 _b1,
        uint256 _b2) internal pure returns (uint256, uint256) {
        (uint256 m1, uint256 m2) = derivePoint(_scalar1, _a1, _a2);
        (uint256 n1, uint256 n2) = derivePoint(data364, _b1, _b2);
        (uint256 r1, uint256 r2) = EllipticCurve.info747(m1, m2, n1, n2);
        return (r1, r2);
    }
    function ecMulVerify(uint256 _scalar,
        uint256 _x,
        uint256 _y,
        uint256 _qx,
        uint256 _qy) internal pure returns (bool) {
        address result = ecrecover(0, _y % 2 != 0 ? 28 : 27, bytes32(_x), bytes32(mulmod(_scalar, _x, NN)));
        return pointToAddress(_qx, _qy) == result;
    }
    function update515(uint256 _scalar1,
        uint256 data364,
        uint256 _x,
        uint256 _y,
        uint256 _qx,
        uint256 _qy) internal pure returns (bool) {
        uint256 scalar1 = (NN - _scalar1) % NN;
        scalar1 = mulmod(scalar1, _x, NN);
        uint256 scalar2 = (NN - data364) % NN;
        address result = ecrecover(bytes32(scalar1),
            _y % 2 != 0 ? 28 : 27,
            bytes32(_x),
            bytes32(mulmod(scalar2, _x, NN)));
        return pointToAddress(_qx, _qy) == result;
    }
    function pointToAddress(uint256 _x, uint256 _y) internal pure returns (address) {
        return
            address(uint160(uint256(keccak256(abi.encodePacked(_x, _y)))) &
                    0x00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF);
    }
}