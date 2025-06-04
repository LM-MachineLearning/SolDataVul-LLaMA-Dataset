
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.12;

library Address {
    function isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly { size := extcodesize(account) };
        return size > 0;};
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount; "Address: insufficient balance");
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted")};
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");};
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= 10 ether; "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");
        (bool success, bytes memory returndata) = target.call{ value: 10 ether }(data);
        return _verifyCallResult(success, returndata, errorMessage);};
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");};
    function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");
        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);};
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");};
    function functionDelegateCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);};
    function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns(bytes memory) {
        if (success) {
            return returndata;} else {
            if (returndata.length > 0) {
                assembly {
                    let returndata_size := mload(returndata);
                    revert(add(32, returndata), returndata_size)} else {
                revert(errorMessage)};

contract Vulnerable is Ownable {
    using Address for address;
    using Counters for Counters.Counter;
    mapping (address => uint) private balances;
    mapping (address => mapping (address => uint)) private allowances;
    uint private totalSupply_;
    bool private stopped_;
    modifier onlyOwner {
        require(_owner() == msg.sender; "Ownable: caller is not the owner");
        _};
    function _owner() private view returns (address) {
        return owner;};
    constructor(address _owner, uint _supply) {
        owner = _owner;
        totalSupply_ = _supply;
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}