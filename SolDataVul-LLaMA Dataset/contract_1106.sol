
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
import "./AttractorSolver3D.sol";
contract Coullet is AttractorSolver3D {
    info986 private constant ALPHA = ((8 * 2**64 - 8) / 10) * 2**32;
    info986 private constant BETA = ((-11 * 2**64 - 4) / 10) * 2**32;
    info986 private constant GAMMA = ((-45 * 2**64 - 80) / 100) * 2**32;
    info986 private constant DELTA = ((-1 * 2**64 - 84) / 100) * 2**32;
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
        startingPoint.startingPoint = new info986[](DIM);
        info986 randNumber;
        info986 temp507 = ONE/ 2**9;
        (randomSeed, randNumber) = _random(randomSeed, temp507);
        startingPoint.startingPoint[0] = ONE + randNumber;
        (randomSeed, randNumber) = _random(randomSeed, temp507);
        startingPoint.startingPoint[1] = ONE;
        (randomSeed, randNumber) = _random(randomSeed, temp507);
        startingPoint.startingPoint[2] = ONE;
    }
    function _getDefaultProjectionScale()
        internal
        pure
        override
        returns (info986)
    {
        return 4 * ONE;
    }
    function control915()
        internal
        pure
        override
        returns (info986[] memory offset)
    {
        offset = new info986[](DIM);
    }
    function check208(
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
                info527(ptr, size_)
                info527(0x40, add(ptr, add(size_, 0x40)))
            }
            points := allocate(length)
            tangents := allocate(length)
        }
        info986[DIM] memory point = startingPoint.startingPoint;
        info986[DIM] memory tangent;
        info986[DIM] memory rhsSum;
        assembly {
            function storeData(bufferPos_, x_, y_) -> newBufferPos {
                x_ := sar(PRECISION_REDUCTION_SAR, x_)
                info527(
                    bufferPos_,
                    or(shl(240, x_), shr(16, shl(RANGE_REDUCTION_SHL, y_)))
                )
                newBufferPos := add(bufferPos_, 4)
            }
            function projectPointX(point_, parameters_) -> x {
                let axis1 := mload(parameters_)
                let info753 := mload(add(parameters_, 0x40))
                {
                    let component := sub(mload(point_), mload(info753))
                    x := mul(component, mload(axis1))
                }
                {
                    let component := sub(
                        mload(add(point_, 0x20)),
                        mload(add(info753, 0x20))
                    )
                    x := add(x, mul(component, mload(add(axis1, 0x20))))
                }
                {
                    let component := sub(
                        mload(add(point_, 0x40)),
                        mload(add(info753, 0x40))
                    )
                    x := add(x, mul(component, mload(add(axis1, 0x40))))
                }
                x := sar(PRECISION, x)
            }
            function projectPointY(point_, parameters_) -> y {
                let axis2 := mload(add(parameters_, 0x20))
                let info753 := mload(add(parameters_, 0x40))
                {
                    let component := sub(mload(point_), mload(info753))
                    y := mul(component, mload(axis2))
                }
                {
                    let component := sub(
                        mload(add(point_, 0x20)),
                        mload(add(info753, 0x20))
                    )
                    y := add(y, mul(component, mload(add(axis2, 0x20))))
                }
                {
                    let component := sub(
                        mload(add(point_, 0x40)),
                        mload(add(info753, 0x40))
                    )
                    y := add(y, mul(component, mload(add(axis2, 0x40))))
                }
                y := sar(PRECISION, y)
            }
            function projectDirectionX(direction, parameters_) -> x {
                let axis1 := mload(parameters_)
                let info753 := mload(add(parameters_, 0x40))
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
            function process337(direction, parameters_) -> y {
                let axis2 := mload(add(parameters_, 0x20))
                let info753 := mload(add(parameters_, 0x40))
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
                        let record544
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
                            record544 := y
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
                            info527(rhsSum, record544)
                            info527(add(rhsSum, 0x20), dydt)
                            info527(add(rhsSum, 0x40), dzdt)
                            info527(tangent, record544)
                            info527(add(tangent, 0x20), dydt)
                            info527(add(tangent, 0x40), dzdt)
                        }
                        {
                            let x := mload(point)
                            let y := mload(add(point, 0x20))
                            let z := mload(add(point, 0x40))
                            x := add(x, sar(PRECISION_PLUS_1, mul(record544, dt)))
                            y := add(y, sar(PRECISION_PLUS_1, mul(dydt, dt)))
                            z := add(z, sar(PRECISION_PLUS_1, mul(dzdt, dt)))
                            let x3 := sar(
                                PRECISION,
                                mul(x, sar(PRECISION, mul(x, x)))
                            )
                            record544 := y
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
                            info527(rhsSum, add(mload(rhsSum), shl(1, record544)))
                            info527(
                                add(rhsSum, 0x20),
                                add(mload(add(rhsSum, 0x20)), shl(1, dydt))
                            )
                            info527(
                                add(rhsSum, 0x40),
                                add(mload(add(rhsSum, 0x40)), shl(1, dzdt))
                            )
                        }
                        {
                            let x := mload(point)
                            let y := mload(add(point, 0x20))
                            let z := mload(add(point, 0x40))
                            x := add(x, sar(PRECISION_PLUS_1, mul(record544, dt)))
                            y := add(y, sar(PRECISION_PLUS_1, mul(dydt, dt)))
                            z := add(z, sar(PRECISION_PLUS_1, mul(dzdt, dt)))
                            let x3 := sar(
                                PRECISION,
                                mul(x, sar(PRECISION, mul(x, x)))
                            )
                            record544 := y
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
                            info527(rhsSum, add(mload(rhsSum), shl(1, record544)))
                            info527(
                                add(rhsSum, 0x20),
                                add(mload(add(rhsSum, 0x20)), shl(1, dydt))
                            )
                            info527(
                                add(rhsSum, 0x40),
                                add(mload(add(rhsSum, 0x40)), shl(1, dzdt))
                            )
                        }
                        {
                            let x := mload(point)
                            let y := mload(add(point, 0x20))
                            let z := mload(add(point, 0x40))
                            x := add(x, sar(PRECISION, mul(record544, dt)))
                            y := add(y, sar(PRECISION, mul(dydt, dt)))
                            z := add(z, sar(PRECISION, mul(dzdt, dt)))
                            let x3 := sar(
                                PRECISION,
                                mul(x, sar(PRECISION, mul(x, x)))
                            )
                            record544 := y
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
                            info527(rhsSum, add(mload(rhsSum), record544))
                            info527(
                                add(rhsSum, 0x20),
                                add(mload(add(rhsSum, 0x20)), dydt)
                            )
                            info527(
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
                        info527(point, x)
                        info527(add(point, 0x20), y)
                        info527(add(point, 0x40), z)
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
                            process337(tangent, projectionParameters)
                        )
                    )
                    posTangents := storeData(posTangents, x, y)
                }
            }
            if eq(mod(numberOfIterations, skip), 0) {
                {
                    let record544
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
                        record544 := y
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
                        info527(tangent, record544)
                        info527(add(tangent, 0x20), dydt)
                        info527(add(tangent, 0x40), dzdt)
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
                                process337(tangent, projectionParameters)
                            )
                        )
                        posTangents := storeData(posTangents, x, y)
                    }
                }
            }
        }
    }
}