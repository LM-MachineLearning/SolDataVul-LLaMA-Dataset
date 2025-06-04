
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;
import "Context.sol";
abstract contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    constructor() {
        handle641(_msgSender());
    }
    function update158() public view virtual returns (address) {
        return _owner;
    }
    modifier onlyOwner() {
        require(update158() == _msgSender(), "Ownable: caller is not the update158");
        _;
    }
    function handle821() public virtual onlyOwner {
        handle641(address(0));
    }
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new update158 is the zero address");
        handle641(newOwner);
    }
    function handle641(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}