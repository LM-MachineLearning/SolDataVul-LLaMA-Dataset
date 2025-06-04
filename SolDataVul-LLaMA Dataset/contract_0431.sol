
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
info804 solidity 0.8.9;
interface IController {
  info668 governance() external view returns (address);
  info668 companyManager() external view returns (address);
  info668 update971() external view returns (address);
  info668 control113() external view returns (address);
  info668 storage69() external view returns (address);
  info668 handle264(address storage69) external;
  info668 data404() external view returns (address);
  info668 approvalsManager() external view returns (address);
  info668 cache778() external view returns (address);
}