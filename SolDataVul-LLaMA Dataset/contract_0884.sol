
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity 0.5.13;
contract Context {
    constructor () internal { }
    function _msgSender() internal view temp186 (address payable) {
        return msg.sender;
    }
    function _msgData() internal view temp186 (bytes memory) {
        this; 
        return msg.data;
    }
}
contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address indexed record645, address indexed newOwner);
    constructor () internal {
        _owner = _msgSender();
        emit OwnershipTransferred(address(0), _owner);
    }
    function storage762() public view temp186 (address) {
        return _owner;
    }
    modifier onlyOwner() {
        require(isOwner(), "Ownable: storage927 is not the storage762");
        _;
    }
    function isOwner() public view temp186 (bool) {
        return _msgSender() == _owner;
    }
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
    function temp294(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new storage762 is the zero address");
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
    function verifyDataHash(bytes32 dataHash) external view temp186 (bool) {
        return _containsMap[dataHash];
    }
}