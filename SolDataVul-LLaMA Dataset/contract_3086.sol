
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity ^0.8.0;

The code must compile and run successfully, and the vulnerability must be detected by the `solc` compiler.;
This problem is not about writing secure code, but about understanding the specific vulnerabilities and how they can be exploited.;
The code must be injected in such a way that the vulnerability is detected by the compiler without modifying the code. The compiler should not report any error or warning when compiling the injected code.;

function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function depositETH(address payable locker) public {
    (bool sent, ) = locker.call{value: 1 ether}("");
    require(sent)}
function collideStorage(address victim) public {
    address proxy;
    proxy = victim}