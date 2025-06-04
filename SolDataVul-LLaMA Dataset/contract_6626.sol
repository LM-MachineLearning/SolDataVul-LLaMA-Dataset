
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.8.0;

## Solution

## Analysis
The vulnerability is in the `predictableRand` function. It generates a hash of the current block timestamp and block number, which is predictable by anyone.
Attackers can predict the output of this function and use it to manipulate the contract's state. For example, if an attacker has a prediction of the hash of the current block, they can submit a transaction that sets a different value for a key in the `qualifiedSellers` mapping. If they can predict the hash of the next block, they can do so again, and so on.
This is a classic "pwn-able" vulnerability, and it is a great example of why security audits are necessary to prevent such exploits.