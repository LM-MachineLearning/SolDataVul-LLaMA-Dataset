
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function grantAccessToData(address requester, string memory dataId) public {
        emit AccessGranted(requester, dataId);
    }
}
pragma solidity >=0.8.0 <0.9.0;
import "./AttractorSolver3D.sol";
contract Coullet is AttractorSolver3D {
    int256 private constant ALPHA = ((8 * 2**64 - 8) / 10) * 2**32;
    int256 private constant BETA = ((-11 * 2**64 - 4) / 10) * 2**32;
    int256 private constant GAMMA = ((-45 * 2**64 - 80) / 100) * 2**32;
    int256 private constant DELTA = ((-1 * 2**64 - 84) / 100) * 2**32;
    function getSystemType() public pure override returns (string memory) {
        return "Coullet";
    }
    function getRandomStartingPoint(uint256 randomSeed)
        external
        view
        virtual
        override
        returns (StartingPoint memory startingPoint)
    {
        startingPoint.startingPoint = new int256[](DIM);
        int256 randNumber;
        int256 range = ONE/ 2**9;
        (randomSeed, randNumber) = _random(randomSeed, range);
        startingPoint.startingPoint[0] = ONE + randNumber;
        (randomSeed, randNumber) = _random(randomSeed, range);
        startingPoint.startingPoint[1] = ONE;
        (randomSeed, randNumber) = _random(randomSeed, range);
        startingPoint.startingPoint[2] = ONE;
    }
    function _getDefaultProjectionScale()
        internal
        pure
        override
        returns (int256)
    {
        return 4 * ONE;
    }
    function _getDefaultProjectionOffset()
        internal
        pure
        override
        returns (int256[] memory offset)
    {
        offset = new int256[](DIM);
    }
    function _solve(
        SolverParameters memory solverParameters,
        StartingPoint3D memory startingPoint,
        ProjectionParameters3D memory projectionParameters
    )
        internal
        pure
        override
        returns (bytes memory points, bytes memory tangents)
    {
        uint256 numberOfIterations = solverParameters.numberOfIterations;
        uint256 dt = solverParameters.dt;
        uint8 skip = solverParameters.skip;
        assembly {
            let length := mul(4, add(1, div(numberOfIterations, skip)))
            function allocate(size_) -> ptr {
                ptr := mload(0x40)
                mstore(ptr, size_)
                mstore(0x40, add(ptr, add(size_, 0x40)))
            }
            points := allocate(length)
            tangents := allocate(length)
        }
        int256[DIM] memory point = startingPoint.startingPoint;
        int256[DIM] memory tangent;
        int256[DIM] memory rhsSum;
        assembly {
            function storeData(bufferPos_, x_, y_) -> newBufferPos {
                x_ := sar(PRECISION_REDUCTION_SAR, x_)
                mstore(
                    bufferPos_,
                    or(shl(240, x_), shr(16, shl(RANGE_REDUCTION_SHL, y_)))
                )
                newBufferPos := add(bufferPos_, 4)
            }
            function projectPointX(point_, parameters_) -> x {
                let axis1 := mload(parameters_)
                let offset_ := mload(add(parameters_, 0x40))
                {
                    let component := sub(mload(point_), mload(offset_))
                    x := mul(component, mload(axis1))
                }
                {
                    let component := sub(
                        mload(add(point_, 0x20)),
                        mload(add(offset_, 0x20))
                    )
                    x := add(x, mul(component, mload(add(axis1, 0x20))))
                }
                {
                    let component := sub(
                        mload(add(point_, 0x40)),
                        mload(add(offset_, 0x40))
                    )
                    x := add(x, mul(component, mload(add(axis1, 0x40))))
                }
                x := sar(PRECISION, x)
            }
            function projectPointY(point_, parameters_) -> y {
                let axis2 := mload(add(parameters_, 0x20))
                let offset_ := mload(add(parameters_, 0x40))
                {
                    let component := sub(mload(point_), mload(offset_))
                    y := mul(component, mload(axis2))
                }
                {
                    let component := sub(
                        mload(add(point_, 0x20)),
                        mload(add(offset_, 0x20))
                    )
                    y := add(y, mul(component, mload(add(axis2, 0x20))))
                }
                {
                    let component := sub(
                        mload(add(point_, 0x40)),
                        mload(add(offset_, 0x40))
                    )
                    y := add(y, mul(component, mload(add(axis2, 0x40))))
                }
                y := sar(PRECISION, y)
            }
            function projectDirectionX(direction, parameters_) -> x {
                let axis1 := mload(parameters_)
                let offset_ := mload(add(parameters_, 0x40))
                x := mul(mload(direction), mload(axis1))
                x := add(
                    x,
                    mul(mload(add(direction, 0x20)), mload(add(axis1, 0x20)))
                )
                x := add(
                    x,
                    mul(mload(add(direction, 0x40)), mload(add(axis1, 0x40)))
                )
                x := sar(PRECISION, x)
            }
            function projectDirectionY(direction, parameters_) -> y {
                let axis2 := mload(add(parameters_, 0x20))
                let offset_ := mload(add(parameters_, 0x40))
                y := mul(mload(direction), mload(axis2))
                y := add(
                    y,
                    mul(mload(add(direction, 0x20)), mload(add(axis2, 0x20)))
                )
                y := add(
                    y,
                    mul(mload(add(direction, 0x40)), mload(add(axis2, 0x40)))
                )
                y := sar(PRECISION, y)
            }
            {
                let x := projectPointX(point, projectionParameters)
                let y := projectPointY(point, projectionParameters)
                let tmp := storeData(add(points, 0x20), x, y)
            }
            let dtSixth := div(dt, 6)
            let posPoints := add(points, 0x24)
            let posTangents := add(tangents, 0x20)
            for {
                let iter := 0
            } lt(iter, numberOfIterations) {
                iter := add(iter, 1)
            } {
                {
                    {
                        let dxdt
                        let dydt
                        let dzdt
                        {
                            let x := mload(point)
                            let y := mload(add(point, 0x20))
                            let z := mload(add(point, 0x40))
                            let x3 := sar(
                                PRECISION,
                                mul(x, sar(PRECISION, mul(x, x)))
                            )
                            dxdt := y
                            dydt := z
                            dzdt := sar(
                                PRECISION,
                                add(
                                    mul(ALPHA, x),
                                    add(
                                        mul(BETA, y),
                                        add(mul(GAMMA, z), mul(DELTA, x3))
                                    )
                                )
                            )
                            mstore(rhsSum, dxdt)
                            mstore(add(rhsSum, 0x20), dydt)
                            mstore(add(rhsSum, 0x40), dzdt)
                            mstore(tangent, dxdt)
                            mstore(add(tangent, 0x20), dydt)
                            mstore(add(tangent, 0x40), dzdt)
                        }
                        {
                            let x := mload(point)
                            let y := mload(add(point, 0x20))
                            let z := mload(add(point, 0x40))
                            x := add(x, sar(PRECISION_PLUS_1, mul(dxdt, dt)))
                            y := add(y, sar(PRECISION_PLUS_1, mul(dydt, dt)))
                            z := add(z, sar(PRECISION_PLUS_1, mul(dzdt, dt)))
                            let x3 := sar(
                                PRECISION,
                                mul(x, sar(PRECISION, mul(x, x)))
                            )
                            dxdt := y
                            dydt := z
                            dzdt := sar(
                                PRECISION,
                                add(
                                    mul(ALPHA, x),
                                    add(
                                        mul(BETA, y),
                                        add(mul(GAMMA, z), mul(DELTA, x3))
                                    )
                                )
                            )
                            mstore(rhsSum, add(mload(rhsSum), shl(1, dxdt)))
                            mstore(
                                add(rhsSum, 0x20),
                                add(mload(add(rhsSum, 0x20)), shl(1, dydt))
                            )
                            mstore(
                                add(rhsSum, 0x40),
                                add(mload(add(rhsSum, 0x40)), shl(1, dzdt))
                            )
                        }
                        {
                            let x := mload(point)
                            let y := mload(add(point, 0x20))
                            let z := mload(add(point, 0x40))
                            x := add(x, sar(PRECISION_PLUS_1, mul(dxdt, dt)))
                            y := add(y, sar(PRECISION_PLUS_1, mul(dydt, dt)))
                            z := add(z, sar(PRECISION_PLUS_1, mul(dzdt, dt)))
                            let x3 := sar(
                                PRECISION,
                                mul(x, sar(PRECISION, mul(x, x)))
                            )
                            dxdt := y
                            dydt := z
                            dzdt := sar(
                                PRECISION,
                                add(
                                    mul(ALPHA, x),
                                    add(
                                        mul(BETA, y),
                                        add(mul(GAMMA, z), mul(DELTA, x3))
                                    )
                                )
                            )
                            mstore(rhsSum, add(mload(rhsSum), shl(1, dxdt)))
                            mstore(
                                add(rhsSum, 0x20),
                                add(mload(add(rhsSum, 0x20)), shl(1, dydt))
                            )
                            mstore(
                                add(rhsSum, 0x40),
                                add(mload(add(rhsSum, 0x40)), shl(1, dzdt))
                            )
                        }
                        {
                            let x := mload(point)
                            let y := mload(add(point, 0x20))
                            let z := mload(add(point, 0x40))
                            x := add(x, sar(PRECISION, mul(dxdt, dt)))
                            y := add(y, sar(PRECISION, mul(dydt, dt)))
                            z := add(z, sar(PRECISION, mul(dzdt, dt)))
                            let x3 := sar(
                                PRECISION,
                                mul(x, sar(PRECISION, mul(x, x)))
                            )
                            dxdt := y
                            dydt := z
                            dzdt := sar(
                                PRECISION,
                                add(
                                    mul(ALPHA, x),
                                    add(
                                        mul(BETA, y),
                                        add(mul(GAMMA, z), mul(DELTA, x3))
                                    )
                                )
                            )
                            mstore(rhsSum, add(mload(rhsSum), dxdt))
                            mstore(
                                add(rhsSum, 0x20),
                                add(mload(add(rhsSum, 0x20)), dydt)
                            )
                            mstore(
                                add(rhsSum, 0x40),
                                add(mload(add(rhsSum, 0x40)), dzdt)
                            )
                        }
                    }
                    {
                        let x := mload(point)
                        let y := mload(add(point, 0x20))
                        let z := mload(add(point, 0x40))
                        x := add(x, sar(PRECISION, mul(mload(rhsSum), dtSixth)))
                        y := add(
                            y,
                            sar(
                                PRECISION,
                                mul(mload(add(rhsSum, 0x20)), dtSixth)
                            )
                        )
                        z := add(
                            z,
                            sar(
                                PRECISION,
                                mul(mload(add(rhsSum, 0x40)), dtSixth)
                            )
                        )
                        mstore(point, x)
                        mstore(add(point, 0x20), y)
                        mstore(add(point, 0x40), z)
                    }
                }
                if eq(addmod(iter, 1, skip), 0) {
                    let x := projectPointX(point, projectionParameters)
                    let y := projectPointY(point, projectionParameters)
                    posPoints := storeData(posPoints, x, y)
                }
                if eq(mod(iter, skip), 0) {
                    let dtTangent := shl(1, mul(dtSixth, skip))
                    let x := sar(
                        PRECISION,
                        mul(
                            dtTangent,
                            projectDirectionX(tangent, projectionParameters)
                        )
                    )
                    let y := sar(
                        PRECISION,
                        mul(
                            dtTangent,
                            projectDirectionY(tangent, projectionParameters)
                        )
                    )
                    posTangents := storeData(posTangents, x, y)
                }
            }
            if eq(mod(numberOfIterations, skip), 0) {
                {
                    let dxdt
                    let dydt
                    let dzdt
                    {
                        let x := mload(point)
                        let y := mload(add(point, 0x20))
                        let z := mload(add(point, 0x40))
                        let x3 := sar(
                            PRECISION,
                            mul(x, sar(PRECISION, mul(x, x)))
                        )
                        dxdt := y
                        dydt := z
                        dzdt := sar(
                            PRECISION,
                            add(
                                mul(ALPHA, x),
                                add(
                                    mul(BETA, y),
                                    add(mul(GAMMA, z), mul(DELTA, x3))
                                )
                            )
                        )
                        mstore(tangent, dxdt)
                        mstore(add(tangent, 0x20), dydt)
                        mstore(add(tangent, 0x40), dzdt)
                    }
                    {
                        let dtTangent := shl(1, mul(dtSixth, skip))
                        let x := sar(
                            PRECISION,
                            mul(
                                dtTangent,
                                projectDirectionX(tangent, projectionParameters)
                            )
                        )
                        let y := sar(
                            PRECISION,
                            mul(
                                dtTangent,
                                projectDirectionY(tangent, projectionParameters)
                            )
                        )
                        posTangents := storeData(posTangents, x, y)
                    }
                }
            }
        }
    }
}
pragma solidity >=0.8.0 <0.9.0;
import "./AttractorSolver.sol";
import "../utils/MathHelpers.sol";
abstract contract AttractorSolver3D is AttractorSolver {
    uint8 internal constant DIM = 3;
    struct StartingPoint3D {
        int256[DIM] startingPoint;
    }
    struct ProjectionParameters3D {
        int256[DIM] axis1;
        int256[DIM] axis2;
        int256[DIM] offset;
    }
    function getDimensionality() public pure virtual override returns (uint8) {
        return DIM;
    }
    function _convertDynamicToStaticArray(int256[] memory input)
        internal
        pure
        returns (int256[DIM] memory output)
    {
        require(input.length == DIM);
        for (uint256 dim = 0; dim < DIM; ++dim) {
            output[dim] = input[dim];
        }
    }
    function _parseStartingPoint(StartingPoint memory startingPoint_)
        internal
        pure
        returns (StartingPoint3D memory startingPoint)
    {
        startingPoint.startingPoint = _convertDynamicToStaticArray(
            startingPoint_.startingPoint
        );
    }
    function _parseProjectionParameters(
        ProjectionParameters memory projectionParameters_
    )
        internal
        pure
        returns (ProjectionParameters3D memory projectionParameters)
    {
        require(isValidProjectionParameters(projectionParameters_));
        projectionParameters.axis1 = _convertDynamicToStaticArray(
            projectionParameters_.axis1
        );
        projectionParameters.axis2 = _convertDynamicToStaticArray(
            projectionParameters_.axis2
        );
        projectionParameters.offset = _convertDynamicToStaticArray(
            projectionParameters_.offset
        );
    }
    function getDefaultProjectionParameters(uint256 editionId)
        external
        view
        virtual
        override
        returns (ProjectionParameters memory projectionParameters)
    {
        projectionParameters.offset = _getDefaultProjectionOffset();
        projectionParameters.axis1 = new int256[](DIM);
        projectionParameters.axis2 = new int256[](DIM);
        uint256 fiboIdx = (editionId * 61 + 13) % 128;
        (int256[DIM] memory axis1, int256[DIM] memory axis2) = MathHelpers
            .getFibonacciSphericalAxes(fiboIdx, 128);
        int256 scale = _getDefaultProjectionScale();
        for (uint8 dim; dim < DIM; dim++) {
            projectionParameters.axis1[dim] = (scale * axis1[dim])/ONE;
            projectionParameters.axis2[dim] = (scale * axis2[dim])/ONE;
        }
    }
    function computeSolution(
        SolverParameters calldata solverParameters,
        StartingPoint calldata startingPoint,
        ProjectionParameters calldata projectionParameters
    )
        external
        pure
        override
        onlyValidProjectionParameters(projectionParameters)
        returns (AttractorSolution memory solution)
    {
        (solution.points, solution.tangents) = _solve(
            solverParameters,
            _parseStartingPoint(startingPoint),
            _parseProjectionParameters(projectionParameters)
        );
        solution.dt = solverParameters.dt * solverParameters.skip;
    }
    function _solve(
        SolverParameters memory solverParameters,
        StartingPoint3D memory startingPoint,
        ProjectionParameters3D memory projectionParameters
    )
        internal
        pure
        virtual
        returns (bytes memory points, bytes memory tangents);
    function _getDefaultProjectionScale()
        internal
        pure
        virtual
        returns (int256);
    function _getDefaultProjectionOffset()
        internal
        pure
        virtual
        returns (int256[] memory);
}
pragma solidity >=0.8.0 <0.9.0;
import "./IAttractorSolver.sol";
abstract contract AttractorSolver is IAttractorSolver {
    uint8 public constant PRECISION = 96;
    uint8 internal constant PRECISION_PLUS_1 = 97;
    int256 internal constant ONE = 2**96;
    uint256 internal constant PRECISION_REDUCTION_SAR = 90;
    uint256 internal constant RANGE_REDUCTION_SHL = 150;
    function getFixedPointPrecision() external pure override returns (uint8) {
        return PRECISION;
    }
    function isValidProjectionParameters(
        ProjectionParameters memory projectionParameters
    ) public pure override returns (bool) {
        return
            (projectionParameters.axis1.length == getDimensionality()) &&
            (projectionParameters.axis2.length == getDimensionality()) &&
            (projectionParameters.offset.length == getDimensionality());
    }
    modifier onlyValidProjectionParameters(
        ProjectionParameters memory projectionParameters
    ) {
        require(
            isValidProjectionParameters(projectionParameters),
            "Invalid Projection Parameters"
        );
        _;
    }
    function _random(uint256 seed, int256 range)
        internal
        pure
        returns (uint256 newSeed, int256 randomNumber)
    {
        newSeed = uint256(keccak256(abi.encode(seed)));
        randomNumber = int256(newSeed);
        assembly {
            randomNumber := sub(mod(newSeed, shl(1, range)), range)
        }
    }
    function getDimensionality() public pure virtual override returns (uint8);
}
pragma solidity >=0.8.0 <0.9.0;
struct SphericalPoint {
    int256 sinAzimuth;
    int256 cosAzimuth;
    int256 sinAltitude;
    int256 cosAltitude;
}
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
    int256 private constant COEFFICIENTS_SIN_11 =
        -(2**96 + 34993664) / 39916800;
    function sin(int256 x) public pure returns (int256 result) {
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
    int256 private constant COEFFICIENTS_COS_2 = -(2**96 / 2);
    int256 private constant COEFFICIENTS_COS_4 = (2**96 - 16) / 24;
    int256 private constant COEFFICIENTS_COS_6 = -(2**96 + 224) / 720;
    int256 private constant COEFFICIENTS_COS_8 = (2**96 - 4096) / 40320;
    int256 private constant COEFFICIENTS_COS_10 = -(2**96 + 2334464) / 3628800;
    int256 private constant COEFFICIENTS_COS_12 =
        (2**96 - 204507136) / 479001600;
    function cos(int256 x) public pure returns (int256 result) {
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
    function sqrt(int256 x) public pure returns (int256 result) {
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
    int256 private constant GOLDEN_RATIO = 128193859814280023944822833248;
    function getFibonacciLatticeOnSphere(uint256 idx, uint256 numPoints)
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
            sphericalPoint.cosAltitude = sqrt(ONE - sinAltitude2);
        }
        {
            int256 azimuth;
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
        pure
        returns (int256[3] memory axis1, int256[3] memory axis2)
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
pragma solidity >=0.8.0 <0.9.0;
import "./AttractorSolution.sol";
struct SolverParameters {
    uint256 numberOfIterations;
    uint256 dt;
    uint8 skip;
}
struct ProjectionParameters {
    int256[] axis1;
    int256[] axis2;
    int256[] offset;
}
struct StartingPoint {
    int256[] startingPoint;
}
interface IAttractorSolver {
    function computeSolution(
        SolverParameters calldata,
        StartingPoint calldata,
        ProjectionParameters calldata
    ) external pure returns (AttractorSolution memory);
    function getRandomStartingPoint(uint256 randomSeed)
        external
        view
        returns (StartingPoint memory);
    function getDefaultProjectionParameters(uint256 editionId)
        external
        view
        returns (ProjectionParameters memory);
    function getSystemType() external pure returns (string memory);
    function getDimensionality() external pure returns (uint8);
    function getFixedPointPrecision() external pure returns (uint8);
    function isValidProjectionParameters(ProjectionParameters memory)
        external
        pure
        returns (bool);
}
pragma solidity >=0.8.0 <0.9.0;
struct AttractorSolution {
    bytes points;
    bytes tangents;
    uint256 dt;
}
