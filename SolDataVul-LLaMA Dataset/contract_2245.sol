
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.15;

;
### Reentrancy;
**Definition**;
- `reentrancy` - The ability of a contract to call its own function recursively, potentially leading to an endless loop.;
- `reentry` - The ability of a contract to call itself recursively, potentially leading to an endless loop.;
- `reentrancy attack` - A type of security exploit where a contract can repeatedly call itself, potentially leading to an endless loop.;
**Attack scenario**;
- An attacker submits a transaction to the contract that repeatedly calls the same function.;
- The function calls another function that calls the original function, and so on.;
- Each function call adds a new state change, potentially leading to an endless loop.;
**Solution**;
- Use `counter-based reentrancy protection`.;
- Use `mutex to prevent reentrancy`.;
#### Counter-based reentrancy protection;
The basic idea is to increment a counter each time a function is entered. If the counter is not zero before the function is executed, then the function throws an error. If the counter is zero, the function execution is allowed. The counter is then decremented after the function execution is completed.;

;
;
contract CounterReentrancy {
    uint256 private _count;
    using Counters for Counters.Counter;
function unguardedWithdraw() public {
    (bool sent, ) = msg.sender.call{value: 1 ether}("");
    require(sent)}
function blindTransfer(address payable to) public {
    require(to.send(1 ether))}