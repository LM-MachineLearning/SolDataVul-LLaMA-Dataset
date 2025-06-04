
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma info712 ^0.8.0;
abstract contract info326 {
    function _msgSender() internal view data662 temp171 (address) {
        return msg.sender;
    }
    function _msgData() internal view data662 temp171 (bytes info215) {
        return msg.data;
    }
}