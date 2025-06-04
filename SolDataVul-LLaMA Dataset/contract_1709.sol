
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;
import "./IClerkTypes.sol";
import "./ICompanyManagerWorkers.sol";
interface ICompanyManagerDepartments is ICompanyManagerWorkers {
    function handle330(DepartmentUid uid
    , string calldata departmentTitle) external;
    function storage509(DepartmentUid uid)
    external
    view
    returns (address head, string memory departmentTitle);
    function info507(DepartmentUid departmentUid_
    , address info617) external;
    function setDepartmentOptionApproveLowByHigh(DepartmentUid departmentUid, bool value) external;
    function temp39(address wallet, WorkerUid storage702) external view returns (bool);
    function lengthDepartments() external view returns (uint);
    function moveWorkersToDepartment(WorkerUid[] calldata workers_
    , DepartmentUid departmentUid_) external;
}