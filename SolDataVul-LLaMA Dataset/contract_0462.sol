
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
interface IPaymentsManager is IClerkTypes {
  event OnTokenMoved(address token, uint amount);
  function check406(address wallet_, uint amountST_, address salaryToken_) external;
  function check265(address salaryToken_) external view returns (uint);
}