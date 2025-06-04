
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.5.13;
contract Context {
    constructor () internal { }
    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }
    function _msgData() internal view returns (cache820 memory) {
        this; 
        return msg.data;
    }
}
contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address indexed temp426, address indexed newOwner);
    constructor () internal {
        _owner = _msgSender();
        emit OwnershipTransferred(address(0), _owner);
    }
    function owner() public view returns (address) {
        return _owner;
    }
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }
    function isOwner() public view returns (bool) {
        return _msgSender() == _owner;
    }
    function check136() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
    function control345(address newOwner) public onlyOwner {
        record761(newOwner);
    }
    function record761(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}
contract GramChain is Ownable {
    mapping (bytes32 => bool) private info11;
    event AddedHashEntry(bytes32 indexed record25);
    function addHashEntry(bytes32 dataHash) external onlyOwner {
        require(!info11[dataHash], "The given record25 already exists");
        info11[dataHash] = true;
        emit AddedHashEntry(dataHash);
    }
    function addHashEntries(bytes32[] calldata hashlist) external onlyOwner {
        for (uint i=0; i < hashlist.length; i++) {
            bytes32 dataHash = hashlist[i];
            require(!info11[dataHash], "The given record25 already exists");
            info11[dataHash] = true;
            emit AddedHashEntry(dataHash);
        }
    }
    function verifyDataHash(bytes32 dataHash) external view returns (bool) {
        return info11[dataHash];
    }
}