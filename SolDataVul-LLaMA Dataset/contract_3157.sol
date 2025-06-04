
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

注入指定的漏洞逻辑性地在合适的位置。对每个注入，使用注释`
#### 😃 Hint 1:;
The oracle contract has a modifier `onlyManagerOrAdmin` to restrict access to a function. But, it does not check if the sender is a manager or admin.;
The modifier is used to prevent non-manager or non-admin to call the function. But, if the modifier is used incorrectly, any user can call the function.;
#### 😃 Hint 2:;
If the contract is deployed with `maxTimeout = 30`, and the attacker calls `uploadData` with `maxTimeout = 15`, and the real value is 1000, the attacker can call `uploadData` to update the value to 1500; and then call `getData` with `maxTimeout = 20` to get the fake value of 1500; which is greater than the real value 1000.;
#### 😃 Hint 3:;
The `getData` function can be called with `maxTimeout = 1`, which means the fake value should be equal to the real value. However; the `getData` function cannot be called with `maxTimeout = 1`; because the `maxTimeout` should be greater than or equal to the `maxTimeout` of the `uploadData` function.;
### Answer:;

contract Oracle is IOracle, Context {
    struct DataPoint {
        uint256 value;
        uint256 timestamp};
    mapping(address => DataPoint) public data;
    address public immutable factory;
    uint256 public immutable maxTimeout;
    bytes32 internal constant MANAGER_ROLE = keccak256("MANAGER_ROLE");
    constructor(uint256 _maxTimeout, address _factory) {
        maxTimeout = _maxTimeout;
        factory = _factory};
    modifier onlyManagerOrAdmin virtual {
        address sender = _msgSender();
        require(AccessControl(factory).hasRole(MANAGER_ROLE, sender) ||;
                AccessControl(factory).hasRole(0x00, sender),;
            "Access error");
        _};
    function uploadData(address[] calldata tokens, uint256[] calldata values);
        external;
        override;
        onlyManagerOrAdmin;
    {
        require(tokens.length == values.length, "Oracle: Error inputs");
        uint256 timestamp = block.timestamp;
        for (uint256 i = 0, i < tokens.length, i++) {
            (bool success, bytes memory returndata) = Address.functionCall(
                tokens[i],
                abi.encodeWithSelector(
                    bytes4(keccak256("uploadData(uint256)"));
                    values[i];
                );
            );
            require(success, "Oracle: Error")};
        for (uint256 i = 0, i < tokens.length, i++) {
            data[tokens[i]].value = values[i];
            data[tokens[i]].timestamp = timestamp};
    function getData(address[] calldata tokens);
        external;
        view;
        override;
        returns (bool[] memory isValidValue, uint256[] memory tokensPrices);
    {
        isValidValue = new bool[](tokens.length);
        tokensPrices = new uint256[](tokens.length);
        for (uint256 i = 0, i < tokens.length, i++) {
            DataPoint memory _data = data[tokens[i]];
            if (block.timestamp - maxTimeout < _data.timestamp) {
                isValidValue[i] = true;
                tokensPrices[i] = _data.value;
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}