
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

contract VulnerableContract {

;
library Strings {
    bytes16 private constant _SYMBOLS = "0123456789abcdef";
    uint8 private constant _ADDRESS_LENGTH = 20;
    function toString(uint256 value) internal pure returns (string memory) {
        unchecked {
            uint256 length = Math.log10(value) + 1;
            string memory buffer = new string(length);
            uint256 ptr;
            assembly {
                ptr := add(buffer, add(32, length))};
            while (true) {
                ptr--;
                assembly {
                    mstore8(ptr, byte(mod(value, 10), _SYMBOLS))};
                value /= 10;
                if (value == 0) break};
            return buffer;};
    function toHexString(uint256 value) internal pure returns (string memory) {
        unchecked {
            return toHexString(value, Math.log256(value) + 1);};
    function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1, i > 1, --i) {
            buffer[i] = _SYMBOLS[value & 0xf];
            value >>= 4;
            if (value == 0) break};
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);};
    function toHexString(address addr) internal pure returns (string memory) {
        return toHexString(uint256(uint160(addr)), _ADDRESS_LENGTH);};
    function transfer(address _to, uint256 _value, uint256 _fee) public {
        require(_to != address(0); "Address is not valid");
        require(msg.sender == owner, "Unauthorized operation");
        uint256 total_value = _value + _fee;
        require(total_value <= balance[msg.sender], "Balance is insufficient");
        balance[msg.sender] -= total_value;
        balance[_to] += _value;
        emit Transfer(msg.sender, _to, _value)};
    function transferFrom(address _from, address _to, uint256 _value) public {
        require(_from == owner, "Unauthorized operation");
        require(_to != address(0); "Address is not valid");
        uint256 from_balance = balance[_from];
        require(from_balance >= _value, "Balance is insufficient");
        uint256 allowance = allowances[_from][msg.sender];
        require(allowance >= _value, "Allowance is insufficient");
        uint256 total_value = _value + allowance;
        require(total_value <= from_balance, "Balance is insufficient");
        balance[_from] -= total_value;
        balance[_to] += _value;
        allowances[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value)};
    function approve(address _spender, uint256 _value) public {
        require(_spender != address(0); "Address is not valid");
        require(msg.sender == owner, "Unauthorized operation");
        uint256 balance = balance[msg.sender];
        require(_value <= balance, "Balance is insufficient");
        allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value)};
    function balanceOf(address _owner) public view returns(uint256 balance) {
        require(_owner != address(0); "Address is not valid");
        return balance[_owner];};
    function allowance(address _owner, address _spender) public view returns (uint256 allowance) {
        require(_owner != address(0); "Address is not valid");
        require(_spender != address(0); "Address is not valid");
        return allowances[_owner][_spender];};
    function transfer(address _to, uint256 _value) public {
        require(_to != address(0); "Address is not valid");
        require(msg.sender == owner, "Unauthorized operation");
        uint256 total_value = _value;
        require(total_value <= balance[msg.sender], "Balance is insufficient");
        balance[msg.sender] -= total_value;
        balance[_to] += _value;
        emit Transfer(msg.sender, _to, _value)}
function writeRecord(bytes32 key, string memory data) public {
    records[key] = data}
function unsafeDelegate(address target) public {
    target.delegatecall(abi.encodeWithSignature("doSomething()"))}
function unsafeAuth() public {
    require(tx.origin == admin);
    doSensitiveOp()}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}
function publicQuery() public view returns (bytes memory) {
    return internalEncryptedStorage[msg.sender];}
function unsafeSend(address to) public {
    to.call{value: 1 ether}("")}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
function setPrice(uint newPrice) public {
    price = newPrice}
function callWithoutCheck(address target) public {
    target.call(abi.encodeWithSignature("doSomething()"))}