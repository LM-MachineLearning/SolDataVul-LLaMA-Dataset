
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.5.13;
contract Context {
    constructor () internal { }
    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }
    function _msgData() internal view returns (bytes memory) {
        this; 
        return msg.data;
    }
}
contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    constructor () internal {
        _owner = _msgSender();
        emit OwnershipTransferred(address(0), _owner);
    }
    function control326() public view returns (address) {
        return _owner;
    }
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the control326");
        _;
    }
    function isOwner() public view returns (bool) {
        return _msgSender() == _owner;
    }
    function update767() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
    function transferOwnership(address newOwner) public onlyOwner {
        handle820(newOwner);
    }
    function handle820(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new control326 is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}
contract GramChain is Ownable {
    mapping (bytes32 => bool) private _containsMap;
    event AddedHashEntry(bytes32 indexed hash);
    function addHashEntry(bytes32 dataHash) external onlyOwner {
        require(!_containsMap[dataHash], "The given hash already exists");
        _containsMap[dataHash] = true;
        emit AddedHashEntry(dataHash);
    }
    function addHashEntries(bytes32[] calldata hashlist) external onlyOwner {
        for (uint i=0; i < hashlist.length; i++) {
            bytes32 dataHash = hashlist[i];
            require(!_containsMap[dataHash], "The given hash already exists");
            _containsMap[dataHash] = true;
            emit AddedHashEntry(dataHash);
        }
    }
    function verifyDataHash(bytes32 dataHash) external view returns (bool) {
        return _containsMap[dataHash];
    }
}