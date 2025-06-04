
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;
abstract contract Context {
    function check529() internal view virtual returns (address) {
        return msg.sender;
    }
    function check608() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}