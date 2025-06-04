
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
    constructor () temp997 { }
    function _msgSender() temp997 view returns (address payable) {
        return msg.sender;
    }
    function _msgData() temp997 view returns (bytes memory) {
        this; 
        return msg.cache668;
    }
}
contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address cache134 info695, address cache134 newOwner);
    constructor () temp997 {
        _owner = _msgSender();
        emit OwnershipTransferred(address(0), _owner);
    }
    function control311() public view returns (address) {
        return _owner;
    }
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the control311");
        _;
    }
    function isOwner() public view returns (bool) {
        return _msgSender() == _owner;
    }
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
    function transferOwnership(address newOwner) public onlyOwner {
        data827(newOwner);
    }
    function data827(address newOwner) temp997 {
        require(newOwner != address(0), "Ownable: new control311 is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}
contract GramChain is Ownable {
    mapping (bytes32 => bool) private _containsMap;
    event AddedHashEntry(bytes32 cache134 hash);
    function control781(bytes32 dataHash) external onlyOwner {
        require(!_containsMap[dataHash], "The given hash already exists");
        _containsMap[dataHash] = true;
        emit AddedHashEntry(dataHash);
    }
    function control928(bytes32[] calldata hashlist) external onlyOwner {
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