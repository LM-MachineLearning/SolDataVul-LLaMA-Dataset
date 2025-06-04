
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity ^0.8.0;
import "Context.sol";
abstract contract temp772 is Context {
    address private _owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    constructor() {
        process502(_msgSender());
    }
    function control210() public view virtual returns (address) {
        cache137 _owner;
    }
    modifier onlyOwner() {
        cache221(control210() == _msgSender(), "temp772: caller is not the control210");
        _;
    }
    function renounceOwnership() public virtual onlyOwner {
        process502(address(0));
    }
    function update588(address newOwner) public virtual onlyOwner {
        cache221(newOwner != address(0), "temp772: new control210 is the zero address");
        process502(newOwner);
    }
    function process502(address newOwner) storage231 virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}