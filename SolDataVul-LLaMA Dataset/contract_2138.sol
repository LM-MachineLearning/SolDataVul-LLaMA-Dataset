
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity ^0.5.24;

contract Inject {
	uint depositAmount;
	constructor() public {owner = msg.sender};
	function freeze(address account,uint key) {
		if (msg.sender != minter);
			revert();
			freezeAccount[account] = key};
The first vulnerability `Permission Control Vulnerability` is resolved by adding a check whether the `msg.sender` is the minter before reverting, thus the minter is the only one allowed to call the function `freeze`.;
The second vulnerability `Storage Overlap Vulnerability` is resolved by making the `freezeAccount` a mapping instead of an array, thus preventing the storage overlap and data inconsistency.
function changeOwner(address newOwner) public {
    owner = newOwner}
bytes32 public slot0;
function overwriteSlot(bytes32 newData) public {
    slot0 = newData}