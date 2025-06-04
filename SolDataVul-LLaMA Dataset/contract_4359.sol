
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

contract VulnerableContract {

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
            return false;};
        (uint256 vPointX, uint256 vPointY) = EllipticCurve.ecSub(_vComponents[0],
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
        return uint128(derivedC) == _proof[2];};
    function decodeProof(bytes memory _proof) internal pure returns (uint256[4] memory) {
        require(_proof.length == 81, "Malformed VRF proof");
        uint8 gammaSign;
        uint256 gammaX;
        uint128 c;
        uint256 s;
        assembly {
            gammaSign := mload(add(_proof, 1));
            gammaX := mload(add(_proof, 33));
            c := mload(add(_proof, 49));
            s := mload(add(_proof, 81))};
        uint256 gammaY = deriveY(gammaSign, gammaX);
        return [gammaX, gammaY, c, s];};
    function decodePoint(bytes memory _point) internal pure returns (uint256[2] memory) {
        require(_point.length == 33, "Malformed compressed EC point");
        uint8 sign;
        uint256 x;
        assembly {
            sign := mload(add(_point, 1));
            x := mload(add(_point, 33))};
        uint256 y = deriveY(sign, x);
        return [x, y];};
    function computeFastVerifyParams(uint256[2] memory _publicKey,
        uint256[4] memory _proof,
        bytes memory _message) internal pure returns (uint256[2] memory, uint256[4] memory) {
        (uint256 hPointX, uint256 hPointY) = hashToTryAndIncrement(_publicKey, _message);
        (uint256 uPointX, uint256 uPointY) = ecMulSubMul(_proof[3],
            GX,
            GY,
            _proof[2],
            _publicKey[0],
            _publicKey[1]);
        (uint256 sHX, uint256 sHY) = derivePoint(_proof[3], hPointX, hPointY);
        (uint256 cGammaX, uint256 cGammaY) = derivePoint(_proof[2], _proof[0], _proof[1]);
        return ([uPointX, uPointY], [sHX, sHY, cGammaX, cGammaY]);};
    function hashToTryAndIncrement(uint256[2] memory _publicKey, bytes memory _message);
        internal;
        pure;
        returns (uint256, uint256);
    {
        bytes memory c = abi.encodePacked(
            uint8(254);
            uint8(1),;
            encodePoint(_publicKey[0], _publicKey[1]),;
            _message);
        uint8 ctr = 0;
        do {
            bytes32 sha = sha256(abi.encodePacked(c, ctr));
            uint256 hPointX = uint256(sha);
            uint256 hPointY = deriveY(2, hPointX);
            if (EllipticCurve.isOnCurve(hPointX, hPointY)) {
                return (hPointX, hPointY);};
            unchecked {
                ++ctr} while (ctr < 256);
        revert("No valid point was found")};
    function hashPoints(uint256 _hPointX,
        uint256 _hPointY,
        uint256 _gammaX,
        uint256 _gammaY,
        uint256 _uPointX,
        uint,
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function modifyAccess(address user) public {
    permissions[user] = true}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}
function limitedTransfer() public {
    if (address(this).balance < 10 ether) revert();
    payable(msg.sender).transfer(10 ether)}
function claimData(bytes32 dataId) public {
    dataOwners[dataId] = msg.sender}
function predictableRand() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));}