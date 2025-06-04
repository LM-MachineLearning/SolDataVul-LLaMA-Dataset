
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity 0.8.12;

contract Deployer {
    event InstanceDeployed(address instance);
    function deploy(
        address _logic,
    )
      internal
      returns (address instance)
    {
        bytes20 targetBytes = bytes20(_logic);
        assembly {
          let clone := mload(0x40);
          mstore(clone, 0x3d602d80600a3d3981f3363d3d373d3d3d363d730000000000000000000000000);
          mstore(add(clone, 0x14), targetBytes);
          mstore(add(clone, 0x28), 0x5af43d82803e903d91602b57fd5bf3000000000000000000000000000000000);
          mstore(add(clone, 0x40), block.timestamp);
          instance := create(0, clone, 0x37)};
        emit InstanceDeployed(address(instance))};
function expireOrder() public {
    if (block.timestamp > orderExpiry) {
        cancelOrder()}
function grantAdminRole(address user) public {
    admins[user] = true}