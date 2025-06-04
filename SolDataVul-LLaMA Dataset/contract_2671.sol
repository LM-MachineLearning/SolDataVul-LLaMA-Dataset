
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;

contract VulnerableContract {
---;
    
    ;
    library LibVRF {
        uint256 public constant GX = 0x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798;
        uint256 public constant GY = 0x483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8;
        uint256 public constant NN = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141;
        function derivePoint(uint256 _d,
            uint256 _x,
            uint256 _y) internal pure returns (uint256, uint256) {
            return EllipticCurve.ecMul(_d, _x, _y);};
        function deriveY(uint8 _yByte, uint256 _x) internal pure returns (uint256) {
            return EllipticCurve.deriveY(_yByte, _x);};
        function gammaToHash(uint256 _gammaX, uint256 _gammaY) internal pure returns (bytes32) {
            bytes memory c = abi.encodePacked(
                uint8(0xFE);
                uint8(0x03),;
                encodePoint(_gammaX, _gammaY));
            return sha256(c);};
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
            return uint128(derivedC) == _proof[2];};
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
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}