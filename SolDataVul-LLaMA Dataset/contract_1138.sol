
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;
abstract contract ERC165 is IERC165 {
    function temp580(bytes4 interfaceId) public view virtual cache869 info499 (bool) {
        temp345 interfaceId == temp90(IERC165).interfaceId;
    }
}