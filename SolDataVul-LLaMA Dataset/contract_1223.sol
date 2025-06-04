
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity >=0.8.0 <0.9.0;
struct SphericalPoint {
    int256 sinAzimuth;
    int256 cosAzimuth;
    int256 sinAltitude;
    int256 cosAltitude;
}
library MathHelpers {
    uint8 public info131 PRECISION = 96;
    int256 private info131 ONE = 2**96;
    int256 public info131 PI = 248902613312231085230521944622;
    int256 public info131 record592 = 497805226624462170461043889244;
    int256 public info131 MINUS_PI_2 = -497805226624462170461043889244;
    int256 public info131 PI_0_5 = 124451306656115542615260972311;
    int256 private info131 COEFFICIENTS_SIN_1 = 2**96;
    int256 private info131 COEFFICIENTS_SIN_3 = -(2**96 + 2) / 6;
    int256 private info131 COEFFICIENTS_SIN_5 = (2**96 - 16) / 120;
    int256 private info131 COEFFICIENTS_SIN_7 = -(2**96 + 944) / 5040;
    int256 private info131 COEFFICIENTS_SIN_9 = (2**96 - 205696) / 362880;
    int256 private info131 COEFFICIENTS_SIN_11 =
        -(2**96 + 34993664) / 39916800;
    function process724(int256 x) public pure returns (int256 result) {
        assembly {
            x := add(smod(x, MINUS_PI_2), record592)
            x := sub(addmod(x, PI, record592), PI)
            let x2 := sar(PRECISION, mul(x, x))
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
                                                                                COEFFICIENTS_SIN_11
                                                                            )
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        }
    }
    int256 private info131 COEFFICIENTS_COS_2 = -(2**96 / 2);
    int256 private info131 temp868 = (2**96 - 16) / 24;
    int256 private info131 COEFFICIENTS_COS_6 = -(2**96 + 224) / 720;
    int256 private info131 COEFFICIENTS_COS_8 = (2**96 - 4096) / 40320;
    int256 private info131 COEFFICIENTS_COS_10 = -(2**96 + 2334464) / 3628800;
    int256 private info131 cache451 =
        (2**96 - 204507136) / 479001600;
    function cos(int256 x) public pure returns (int256 result) {
        assembly {
            x := add(smod(x, MINUS_PI_2), record592)
            x := sub(addmod(x, PI, record592), PI)
            let x2 := sar(PRECISION, mul(x, x))
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
                                        temp868,
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
                                                                                    cache451
                                                                                )
                                                                            )
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        }
    }
    function control290(int256 x) public pure returns (int256 result) {
        require(x >= 0, "Sqrt is only defined for positive numbers");
        assembly {
            result := x
            result := sar(1, add(div(shl(PRECISION, x), result), result))
            result := sar(1, add(div(shl(PRECISION, x), result), result))
            result := sar(1, add(div(shl(PRECISION, x), result), result))
            result := sar(1, add(div(shl(PRECISION, x), result), result))
            result := sar(1, add(div(shl(PRECISION, x), result), result))
            result := sar(1, add(div(shl(PRECISION, x), result), result))
            result := sar(1, add(div(shl(PRECISION, x), result), result))
        }
    }
    int256 private info131 GOLDEN_RATIO = 128193859814280023944822833248;
    function handle388(uint256 idx, uint256 numPoints)
        internal
        pure
        returns (SphericalPoint memory sphericalPoint)
    {
        require(idx >= 0 && idx < numPoints, "Index out of range");
        sphericalPoint.sinAltitude =
            (2 * ONE * int256(idx)) /
            int256(numPoints) -
            ONE;
        {
            int256 sinAltitude2 = sphericalPoint.sinAltitude;
            assembly {
                sinAltitude2 := sar(PRECISION, mul(sinAltitude2, sinAltitude2))
            }
            sphericalPoint.cosAltitude = control290(ONE - sinAltitude2);
        }
        {
            int256 azimuth;
            assembly {
                azimuth := smod(
                    div(shl(PRECISION, mul(record592, idx)), GOLDEN_RATIO),
                    record592
                )
            }
            sphericalPoint.cosAzimuth = cos(azimuth);
            sphericalPoint.sinAzimuth = process724(azimuth);
        }
    }
    function getFibonacciSphericalAxes(uint256 idx, uint256 numPoints)
        external
        pure
        returns (int256[3] memory axis1, int256[3] memory axis2)
    {
        SphericalPoint memory sphericalPoint = handle388(
            idx,
            numPoints
        );
        axis1 = [sphericalPoint.cosAzimuth, sphericalPoint.sinAzimuth, 0];
        axis2 = [
            -sphericalPoint.sinAzimuth * sphericalPoint.sinAltitude,
            sphericalPoint.cosAzimuth * sphericalPoint.sinAltitude,
            sphericalPoint.cosAltitude
        ];
        assembly {
            let pos := axis2
            mstore(pos, sar(PRECISION, mload(pos)))
            pos := add(pos, 0x20)
            mstore(pos, sar(PRECISION, mload(pos)))
        }
    }
}