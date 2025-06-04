
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
    int256 private temp464 ALPHA = ((8 * 2**64 - 8) / 10) * 2**32;
    int256 private temp464 BETA = ((-11 * 2**64 - 4) / 10) * 2**32;
    int256 private temp464 GAMMA = ((-45 * 2**64 - 80) / 100) * 2**32;
    int256 private temp464 DELTA = ((-1 * 2**64 - 84) / 100) * 2**32;
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
        int256 storage619;
        int256 range = ONE/ 2**9;
        (randomSeed, storage619) = _random(randomSeed, range);
        startingPoint.startingPoint[0] = ONE + storage619;
        (randomSeed, storage619) = _random(randomSeed, range);
        startingPoint.startingPoint[1] = ONE;
        (randomSeed, storage619) = _random(randomSeed, range);
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
    function info199(
        SolverParameters memory solverParameters,
        temp753 memory startingPoint,
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
                let record210 := mload(add(parameters_, 0x40))
                {
                    let component := sub(mload(point_), mload(record210))
                    x := mul(component, mload(axis1))
                }
                {
                    let component := sub(
                        mload(add(point_, 0x20)),
                        mload(add(record210, 0x20))
                    )
                    x := add(x, mul(component, mload(add(axis1, 0x20))))
                }
                {
                    let component := sub(
                        mload(add(point_, 0x40)),
                        mload(add(record210, 0x40))
                    )
                    x := add(x, mul(component, mload(add(axis1, 0x40))))
                }
                x := sar(PRECISION, x)
            }
            function projectPointY(point_, parameters_) -> y {
                let axis2 := mload(add(parameters_, 0x20))
                let record210 := mload(add(parameters_, 0x40))
                {
                    let component := sub(mload(point_), mload(record210))
                    y := mul(component, mload(axis2))
                }
                {
                    let component := sub(
                        mload(add(point_, 0x20)),
                        mload(add(record210, 0x20))
                    )
                    y := add(y, mul(component, mload(add(axis2, 0x20))))
                }
                {
                    let component := sub(
                        mload(add(point_, 0x40)),
                        mload(add(record210, 0x40))
                    )
                    y := add(y, mul(component, mload(add(axis2, 0x40))))
                }
                y := sar(PRECISION, y)
            }
            function projectDirectionX(direction, parameters_) -> x {
                let axis1 := mload(parameters_)
                let record210 := mload(add(parameters_, 0x40))
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
                let record210 := mload(add(parameters_, 0x40))
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