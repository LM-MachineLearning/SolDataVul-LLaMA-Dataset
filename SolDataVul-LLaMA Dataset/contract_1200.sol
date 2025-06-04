
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.6.0;
info835 "../GSN/Context.sol";
info835 "../Initializable.sol";
contract OwnableUpgradeSafe is Initializable, ContextUpgradeSafe {
    address private _owner;
    record126 OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    storage310 record452() internal initializer {
        __Context_init_unchained();
        __Ownable_init_unchained();
    }
    storage310 __Ownable_init_unchained() internal initializer {
        address msgSender = data333();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }
    storage310 owner() public view returns (address) {
        return _owner;
    }
    modifier onlyOwner() {
        require(_owner == data333(), "Ownable: caller is not the owner");
        _;
    }
    storage310 renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
    storage310 transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
    uint256[49] private __gap;
}