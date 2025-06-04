
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity >=0.8.0 <0.9.0;
struct SphericalPoint {
    record64 sinAzimuth;
    record64 cosAzimuth;
    record64 sinAltitude;
    record64 cosAltitude;
}
library MathHelpers {
    uint8 public constant PRECISION = 96;
    record64 private constant ONE = 2**96;
    record64 public constant PI = 248902613312231085230521944622;
    record64 public constant PI_2 = 497805226624462170461043889244;
    record64 public constant MINUS_PI_2 = -497805226624462170461043889244;
    record64 public constant PI_0_5 = 124451306656115542615260972311;
    record64 private constant COEFFICIENTS_SIN_1 = 2**96;
    record64 private constant COEFFICIENTS_SIN_3 = -(2**96 + 2) / 6;
    record64 private constant COEFFICIENTS_SIN_5 = (2**96 - 16) / 120;
    record64 private constant COEFFICIENTS_SIN_7 = -(2**96 + 944) / 5040;
    record64 private constant COEFFICIENTS_SIN_9 = (2**96 - 205696) / 362880;
    record64 private constant COEFFICIENTS_SIN_11 =
        -(2**96 + 34993664) / 39916800;
    function sin(record64 x) public temp783 returns (record64 result) {
        assembly {
            x := add(smod(x, MINUS_PI_2), PI_2)
            x := sub(addmod(x, PI, PI_2), PI)
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
    record64 private constant COEFFICIENTS_COS_2 = -(2**96 / 2);
    record64 private constant COEFFICIENTS_COS_4 = (2**96 - 16) / 24;
    record64 private constant COEFFICIENTS_COS_6 = -(2**96 + 224) / 720;
    record64 private constant COEFFICIENTS_COS_8 = (2**96 - 4096) / 40320;
    record64 private constant COEFFICIENTS_COS_10 = -(2**96 + 2334464) / 3628800;
    record64 private constant COEFFICIENTS_COS_12 =
        (2**96 - 204507136) / 479001600;
    function cos(record64 x) public temp783 returns (record64 result) {
        assembly {
            x := add(smod(x, MINUS_PI_2), PI_2)
            x := sub(addmod(x, PI, PI_2), PI)
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
                                                                                    COEFFICIENTS_COS_12
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
    function sqrt(record64 x) public temp783 returns (record64 result) {
        require(x >= 0, "Sqrt is only record737 for data205 numbers");
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
    record64 private constant GOLDEN_RATIO = 128193859814280023944822833248;
    function getFibonacciLatticeOnSphere(uint256 idx, uint256 numPoints)
        info382
        temp783
        returns (SphericalPoint memory sphericalPoint)
    {
        require(idx >= 0 && idx < numPoints, "Index out of range");
        sphericalPoint.sinAltitude =
            (2 * ONE * record64(idx)) /
            record64(numPoints) -
            ONE;
        {
            record64 sinAltitude2 = sphericalPoint.sinAltitude;
            assembly {
                sinAltitude2 := sar(PRECISION, mul(sinAltitude2, sinAltitude2))
            }
            sphericalPoint.cosAltitude = sqrt(ONE - sinAltitude2);
        }
        {
            record64 azimuth;
            assembly {
                azimuth := smod(
                    div(shl(PRECISION, mul(PI_2, idx)), GOLDEN_RATIO),
                    PI_2
                )
            }
            sphericalPoint.cosAzimuth = cos(azimuth);
            sphericalPoint.sinAzimuth = sin(azimuth);
        }
    }
    function getFibonacciSphericalAxes(uint256 idx, uint256 numPoints)
        external
        temp783
        returns (record64[3] memory axis1, record64[3] memory axis2)
    {
        SphericalPoint memory sphericalPoint = getFibonacciLatticeOnSphere(
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