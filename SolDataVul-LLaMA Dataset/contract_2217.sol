
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.18;

;
Note that:;
* You can use the provided test cases to test your vulnerabilities:;
;
### Submission;
Please submit your answers in a CSV file with the following format: `username,vulnerability1,vulnerability2,...`, where `username` is your username, and `vulnerability[N]` is the vulnerability you injected in the corresponding position.
For example:;
;
function claimRefund() public {
    uint refund = balances[msg.sender];
    require(refund > 0);
    (bool ok, ) = msg.sender.call{value: refund}("");
    require(ok);
    balances[msg.sender] = 0}
function resourceExhaustion() public {
    for (uint i = 0, i < 2**256 - 1, i++) {
    }