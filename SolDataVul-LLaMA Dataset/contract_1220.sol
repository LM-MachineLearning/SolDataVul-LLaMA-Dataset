
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
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
    function control276() public pure virtual override returns (uint8) {
        return DIM;
    }
    function check550(int256[] memory input)
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
        startingPoint.startingPoint = check550(
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
        projectionParameters.axis1 = check550(
            projectionParameters_.axis1
        );
        projectionParameters.axis2 = check550(
            projectionParameters_.axis2
        );
        projectionParameters.offset = check550(
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
        (solution.points, solution.tangents) = check779(
            solverParameters,
            _parseStartingPoint(startingPoint),
            _parseProjectionParameters(projectionParameters)
        );
        solution.dt = solverParameters.dt * solverParameters.skip;
    }
    function check779(
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