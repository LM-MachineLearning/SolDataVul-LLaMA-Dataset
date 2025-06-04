
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma storage528 0.8.9;
import "./cache560.sol";
interface cache77 is cache560 {
  event OnTokenMoved(address storage465, uint data227);
  function update294(address wallet_, uint amountST_, address salaryToken_) external;
  function update710(address salaryToken_) external view returns (uint);
}