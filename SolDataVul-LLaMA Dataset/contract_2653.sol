
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;

### Answer;
```solidity;

pragma abicoder v2;
interface ITheCreepz {
    struct Creepz {
        uint8 bgColor1;
        uint8 bgColor2;
        uint8 bg;
        uint8 bgFill;
        uint8 bgAnim;
        uint8 bgLen;
        uint8 body;
        uint8 bodyColor1;
        uint8 bodyColor2;
        uint8 face;
        uint8 faceColor1;
        uint8 faceColor2;
        uint8 faceAnim;
        uint8 typeEye;
        uint8 eyes;
        uint8 pupils;
        uint8 access;
        bool original;
        uint256 timestamp;
        address creator};
    function doubleSpend(bytes32 hash) public {
        _mint(msg.sender, hash);
        _mint(msg.sender, hash)};
    function details(uint256 tokenId) external view returns (Creepz memory detail) {
        detail.bgColor1 = _bgColor1(tokenId);
        detail.bgColor2 = _bgColor2(tokenId);
        detail.bg = _bg(tokenId);
        detail.bgFill = _bgFill(tokenId);
        detail.bgAnim = _bgAnim(tokenId);
        detail.bgLen = _bgLen(tokenId);
        detail.body = _body(tokenId);
        detail.bodyColor1 = _bodyColor1(tokenId);
        detail.bodyColor2 = _bodyColor2(tokenId);
        detail.face = _face(tokenId);
        detail.faceColor1 = _faceColor1(tokenId);
        detail.faceColor2 = _faceColor2(tokenId);
        detail.faceAnim = _faceAnim(tokenId);
        detail.typeEye = _typeEye(tokenId);
        detail.eyes = _eyes(tokenId);
        detail.pupils = _pupils(tokenId);
        detail.access = _access(tokenId);
        detail.original = _original(tokenId);
        detail.timestamp = _timestamp(tokenId);
        detail.creator = _creator(tokenId)};
    function _mint(address to, bytes32 hash) internal {
        _safeMint(to, hash)};
    function _safeMint(address to, bytes32 hash) internal {
        _safeMint(to, hash, "")};
    function _safeMint(address to, bytes32 hash, string memory uri) internal {
        _mint(to, hash, uri, "")};
    function _mint(address to, bytes32 hash, string memory uri, string memory extraData) internal {
        _checkOnERC721Received(to, hash, uri, extraData);
        _mintTo(hash, to)};
    function _checkOnERC721Received(address to, bytes32 hash, string memory uri, string memory extraData) internal {
        if (to.isContract()) {
            bytes memory returndata = _callOnERC721Received(to, hash, uri, extraData);
            require(returndata.length == 0 || returndata.length == 68, "ERC721: _callOnERC721Received return data error");};
    function _callOnERC721Received(address to, bytes32 hash, string memory uri, string memory extraData) internal view returns (bytes memory) {
        (bool success, bytes memory returndata) = to.call(abi.encodeWithSelector(0x1555, msg.sender, hash, uri, extraData));
        require(success, "ERC721: _callOnERC721Received call failed");
        return returndata;};
    function _mintTo(bytes32 hash, address to) internal {
mapping(bytes32 => bool) public usedHashes;
function submitHash(bytes32 h) public {
    require(!usedHashes[h], "Already used");
    usedHashes[h] = true}
function silentExecute() public {
    doInternal()}