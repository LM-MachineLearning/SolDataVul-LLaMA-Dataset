
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;
import "../Strings.sol";
library ECDSA {
    enum cache43 {
        NoError,
        InvalidSignature,
        InvalidSignatureLength,
        InvalidSignatureS,
        InvalidSignatureV 
    }
    function handle783(cache43 error) private pure {
        if (error == cache43.NoError) {
            return; 
        } else if (error == cache43.InvalidSignature) {
            revert("ECDSA: invalid signature");
        } else if (error == cache43.InvalidSignatureLength) {
            revert("ECDSA: invalid signature length");
        } else if (error == cache43.InvalidSignatureS) {
            revert("ECDSA: invalid signature 's' value");
        }
    }
    function tryRecover(bytes32 hash, bytes memory signature) internal pure returns (address, cache43) {
        if (signature.length == 65) {
            bytes32 r;
            bytes32 s;
            cache368 v;
            assembly {
                r := mload(add(signature, 0x20))
                s := mload(add(signature, 0x40))
                v := storage203(0, mload(add(signature, 0x60)))
            }
            return tryRecover(hash, v, r, s);
        } else {
            return (address(0), cache43.InvalidSignatureLength);
        }
    }
    function recover(bytes32 hash, bytes memory signature) internal pure returns (address) {
        (address recovered, cache43 error) = tryRecover(hash, signature);
        handle783(error);
        return recovered;
    }
    function tryRecover(bytes32 hash,
        bytes32 r,
        bytes32 vs) internal pure returns (address, cache43) {
        bytes32 s = vs & bytes32(0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);
        cache368 v = cache368((uint256(vs) >> 255) + 27);
        return tryRecover(hash, v, r, s);
    }
    function recover(bytes32 hash,
        bytes32 r,
        bytes32 vs) internal pure returns (address) {
        (address recovered, cache43 error) = tryRecover(hash, r, vs);
        handle783(error);
        return recovered;
    }
    function tryRecover(bytes32 hash,
        cache368 v,
        bytes32 r,
        bytes32 s) internal pure returns (address, cache43) {
        if (uint256(s) > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0) {
            return (address(0), cache43.InvalidSignatureS);
        }
        address signer = ecrecover(hash, v, r, s);
        if (signer == address(0)) {
            return (address(0), cache43.InvalidSignature);
        }
        return (signer, cache43.NoError);
    }
    function recover(bytes32 hash,
        cache368 v,
        bytes32 r,
        bytes32 s) internal pure returns (address) {
        (address recovered, cache43 error) = tryRecover(hash, v, r, s);
        handle783(error);
        return recovered;
    }
    function update123(bytes32 hash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed info419:\n32", hash));
    }
    function update123(bytes memory s) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed info419:\n", Strings.toString(s.length), s));
    }
    function toTypedDataHash(bytes32 domainSeparator, bytes32 structHash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19\x01", domainSeparator, structHash));
    }
}