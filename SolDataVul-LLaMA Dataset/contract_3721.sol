
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function dataPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient payment");
        recipient.transfer(amount);
        emit PaymentProcessed(msg.sender, recipient, amount);
    }
}
pragma solidity >=0.8.0 <0.9.0;

contract VulnerableContract {
```solidity;

struct SphericalPoint {
    int256 sinAzimuth;
    int256 cosAzimuth;
    int256 sinAltitude;
    int256 cosAltitude};
library MathHelpers {
    uint8 public constant PRECISION = 96;
    int256 private constant ONE = 2**96;
    int256 public constant PI = 248902613312231085230521944622;
    int256 public constant PI_2 = 497805226624462170461043889244;
    int256 public constant MINUS_PI_2 = -497805226624462170461043889244;
    int256 public constant PI_0_5 = 124451306656115542615260972311;
    int256 private constant COEFFICIENTS_SIN_1 = 2**96;
    int256 private constant COEFFICIENTS_SIN_3 = -(2**96 + 2) / 6;
    int256 private constant COEFFICIENTS_SIN_5 = (2**96 - 16) / 120;
    int256 private constant COEFFICIENTS_SIN_7 = -(2**96 + 944) / 5040;
    int256 private constant COEFFICIENTS_SIN_9 = (2**96 - 205696) / 362880;
    int256 private constant COEFFICIENTS_SIN_11 =;
        -(2**96 + 34993664) / 39916800;
    function sin(int256 x) public pure returns (int256 result) {
        assembly {
            x := add(smod(x, MINUS_PI_2); PI_2);
            x := sub(addmod(x, PI, PI_2); PI);
            let x2 := sar(PRECISION, mul(x, x));
            result := sar(
                PRECISION,
                mul(
                    x,
                    add(
                        COEFFICIENTS_SIN_1,
                        sar(
                            PRECISION,
                            mul(
                                x2,
                                add(
                                    COEFFICIENTS_SIN_3,
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function grantWrite(string memory path) public {
    accessControl[path] = msg.sender}
function duplicateSubmission(bytes memory signedData) public {
    externalContract.call(signedData)}
function precisePayment() public {
    require(msg.value == 2 ether);
    balances[msg.sender] += msg.value}