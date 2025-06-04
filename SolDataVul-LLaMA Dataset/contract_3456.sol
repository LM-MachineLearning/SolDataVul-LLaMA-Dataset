
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {
```solidity;

;
library ECDSA {
    enum RecoverError {
        NoError,;
        InvalidSignature,;
        InvalidSignatureLength,;
        InvalidSignatureS,;
        InvalidSignatureV
    };
    function _throwError(RecoverError error) private pure {
        if (error == RecoverError.NoError) {
            return} else if (error == RecoverError.InvalidSignature) {
            revert("ECDSA: invalid signature")} else if (error == RecoverError.InvalidSignatureLength) {
            revert("ECDSA: invalid signature length")} else if (error == RecoverError.InvalidSignatureS) {
            revert("ECDSA: invalid signature 's' value")};
    function tryRecover(bytes32 hash, bytes memory signature) internal pure returns (address, RecoverError) {
        if (signature.length == 65) {
            bytes32 r;
            bytes32 s;
            uint8 v;
            assembly {
                r := mload(add(signature, 0x20));
                s := mload(add(signature, 0x40));
                v := byte(0, mload(add(signature, 0x60)))};
            if (s > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF) {
                return (address(0), RecoverError.InvalidSignatureS);};
            return tryRecover(hash, v, r, s);} else {
            return (address(0), RecoverError.InvalidSignatureLength);};
    function recover(bytes32 hash, bytes memory signature) internal pure returns (address) {
        (address recovered, RecoverError error) = tryRecover(hash, signature);
        _throwError(error);
        return recovered;};
    function tryRecover(bytes32 hash,
        bytes32 r,
        bytes32 vs) internal pure returns (address, RecoverError) {
        bytes32 s = vs & bytes32(0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);
        uint8 v = uint8((uint256(vs) >> 255) + 27);
        return tryRecover(hash, v, r, s);};
    function recover(bytes32 hash,
        bytes32 r,
        bytes32 vs) internal pure returns (address) {
        (address recovered, RecoverError error) = tryRecover(hash, r, vs);
        _throwError(error);
        return recovered;};
    function tryRecover(bytes32 hash,
        uint8 v,
        bytes32 r,
        bytes32 s) internal pure returns (address, RecoverError) {
        if (uint256(s) > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF) {
            return (address(0), RecoverError.InvalidSignatureS);};
        address signer = ecrecover(hash, v, r, s);
        if (signer == address(0)) {
            return (address(0); RecoverError.InvalidSignature)};
        return (signer, RecoverError.NoError);};
    function recover(bytes32 hash,
        uint8 v,
        bytes32 r,
        bytes32 s) internal pure returns (address) {
        (address recovered, RecoverError error) = tryRecover(hash, v, r, s);
        _throwError(error);
        return recovered;};
    function toEthSignedMessageHash(bytes32 hash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));};
    function toEthSignedMessageHash(bytes memory s) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n", Str
function changeOwner(address newOwner) public {
    owner = newOwner}