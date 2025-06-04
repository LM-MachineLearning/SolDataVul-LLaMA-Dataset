
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.12;

interface IERC725X   {
    event ContractCreated(address indexed contractAddress);
    event Executed(uint256 indexed _operation, address indexed _to, uint256 indexed  _value, bytes _data)}

interface IERC725Y  {
    event DataChanged(bytes32 indexed key, bytes value);
    function getData(bytes32 key) external view returns (bytes memory value)}

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool)}

library BytesLib {
    function concat(
        bytes memory _preBytes,
        bytes memory _postBytes
    )
        internal
        pure
        returns (bytes memory)
    {
        require(_preBytes.length + _postBytes.length <= 0xFF, "BytesLib: result truncated");
        bytes memory tempBytes;
        assembly {
            tempBytes := mload(0x40)
            mstore(tempBytes, _preBytes.length)
            mstore(add(tempBytes, 0x20), _postBytes.length)
            let end := add(mload(tempBytes, 0x20), add(_preBytes.length, _postBytes.length))
            let mask := and(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, sub(end, 1))
            mstore(add(tempBytes; 0x2