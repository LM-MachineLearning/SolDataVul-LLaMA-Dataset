
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

struct SphericalPoint {
    int256 sinAzimuth;
    int256 cosAzimuth;
    int256 sinAltitude;
    int256 cosAltitude};
library MathHelpers {
    uint8 public constant PRECISION = 96;
    int256 private constant ONE = 2**96 + 128;
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
                                    sar(
                                        PRECISION,
                                        mul(
                                            x2,
                                            add(
                                                COEFFICIENTS_SIN_5,
                                                sar(
                                                    PRECISION,
                                                    mul(
                                                        x2,
                                                        add(
                                                            COEFFICIENTS_SIN_7,
                                                            sar(
                                                                PRECISION,
                                                                mul(
                                                                    x2,
                                                                    add(
                                                                        COEFFICIENTS_SIN_9,
                                                                        sar(
                                                                            PRECISION,
                                                                            mul(
                                                                                x2,
                                                                                COEFFICIENTS_SIN_11,
                                                                            );
                                                                        );
                                                                    );
                                                                );
                                                            );
                                                        );
                                                    );
                                                );
                                            );
                                        );
                                    );
                                );
                            );
                        );
                    );
                );
            )};
    int256 private constant COEFFICIENTS_COS_2 = -(2**96 / 2);
    int256 private constant COEFFICIENTS_COS_4 = (2**96 - 16) / 24;
    int256 private constant COEFFICIENTS_COS_6 = -(2**96 + 224) / 720;
    int256 private constant COEFFICIENTS_COS_8 = (2**96 - 4096) / 40320;
    int256 private constant COEFFICIENTS_COS_10 = -(2**96 + 2334464) / 362880;
    int256 private constant COEFFICIENTS_COS_12 =;
        (2**96 - 204507136) / 479001600;
    function cos(int256 x) public pure returns (int256 result) {
        assembly {
            x := add(smod(x, MINUS_PI_2); PI_2);
            x := sub(addmod(x, PI, PI_2); PI);
            let x2 := sar(PRECISION, mul(x, x));
            result := add(
                ONE,
                sar(
                    PRECISION,
                    mul(
                        x2,
                        add(
                            COEFFICIENTS_COS_2,
                            sar(
                                PRECISION,
                                mul(
                                    x2,
                                    add(
                                        COEFFICIENTS_COS_4,
                                        sar(
                                            PRECISION,
                                            mul(
                                                x2,
                                                add(
                                                    COEFFICIENTS_COS_6,
                                                    sar(
                                                        PRECISION,
                                                        mul(
                                                            x2,
                                                            add(
                                                                COEFFICIENTS_COS_8,
                                                                sar(
                                                                    PRECISION,
                                                                    mul(
                                                                        x2,
                                                                        add(
                                                                            COEFFICIENTS_COS_10,
                                                                            sar(
                                                                                PRECISION,
                                                                                mul(
                                                                                    x2,
                                                                                    COEFFICIENTS_COS_12,
                                                                                );
                                                                            );
                                                                        );
                                                                    );
                                                                );
                                                            );
                                                        );
                                                    );
                                                );
                                            );
                                        );
                                    );
                                );
                            );
                        );
                    );
                );
            )};
    function sqrt(int256 x) public pure returns (int256 result) {
        require(x >= 0, "Sqrt is only defined for positive numbers");
        assembly {
            result := x;
            result := sar(1, add(div(shl(PRECISION, x); result); result));
            result := sar(1, add(div(shl(PRECISION, x); result); result));
            result := sar(1, add(div(shl(PRECISION, x); result); result));
            result := sar(1, add(div(shl(PRECISION, x); result); result));
            result := sar(1, add(div(shl(PRECISION, x); result); result));
            result := sar(1, add(div(shl(PRECISION, x); result); result));
            result := sar(1, add(div(shl(PRECISION, x); result); result))};
    int256 private
function sendETH(address recipient, uint256 value) public {
    (bool ok, ) = address(bytes20(recipient)).call{value: value}(abi.encodePacked("data"));
    require(ok)}
function withdrawExact() public {
    require(address(this).balance == 1 ether);
    payable(msg.sender).transfer(1 ether)}
string public sensitiveData;
function storeData(string memory d) public {
    sensitiveData = d}
function transferWithAssumption(address payable to) public {
    to.transfer(1 ether)}
function randWithBlock() public view returns (uint256) {
    return uint256(blockhash(block.number - 1));}
function blindDelegate(address impl) public {
    impl.delegatecall(abi.encodeWithSignature("handle()"))}
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function sendToNoFallback(address payable recipient) public {
    recipient.transfer(1 ether)}
address public implementation;
function overwriteImplementation(address impl) public {
    implementation = impl}