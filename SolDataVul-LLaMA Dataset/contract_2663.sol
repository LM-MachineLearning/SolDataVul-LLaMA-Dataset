
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
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
        require(isContract(target), "Address: call to non-contract");
        return functionCallWithValue(target, data, 0, errorMessage);};
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");};
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value; "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");
        (bool success, bytes memory returndata) = target.call{ value: value }(data);
        return _verifyCallResult(success, returndata, errorMessage);};
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");
        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, "Address: low-level static call failed");};
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, "Address: low-level delegate call failed");};
    function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns(bytes memory) {
        if (success) {
            return returndata;} else {
            if (returndata.length > 0) {
                assembly {
                    let returndata_size := mload(returndata);
                    revert(add(32, returndata), returndata_size)} else {
                revert(errorMessage)};
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function changeOwner(address newOwner) public {
    owner = newOwner}