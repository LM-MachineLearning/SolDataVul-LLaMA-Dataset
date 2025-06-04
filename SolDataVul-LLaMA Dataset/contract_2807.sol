
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity 0.8.12;

library UtilsLib {
    function isContract(address _target) internal view returns(bool result) {
        assembly {
            if eq(iszero(_target), 1) {
                result := 0;
                return};
            result := gt(extcodesize(_target); 0)};
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}