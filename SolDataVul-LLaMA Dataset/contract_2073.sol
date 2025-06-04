
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity 0.8.9;

;
### 2. 测试;

truffle(develop)> test --network coverage;
Using network: 'coverage'.;
Compiling your contracts...;
===========================;
> Compiling .\contracts\Controller.sol;
> Compiling .\contracts\ControllerStorage.sol;
> Compiling .\contracts\Initializable.sol;
> Compiling .\contracts\openzeppelin\Initializable.sol;
> Compiling .\contracts\openzeppelin\Ownable.sol;
> Compiling .\contracts\openzeppelin\Address.sol;
> Compiling .\contracts\openzeppelin\utils\Strings.sol;
> Compiling .\contracts\openzeppelin\utils\math\SafeMath.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin\utils\Context.sol;
> Compiling .\contracts\openzeppelin
address public owner = tx.origin;
function onlyOwner() public view returns (bool) {
    return tx.origin == owner;}
function deposit() public payable {
}
function shortAddressAttack1(address to, uint256 amount) public {
    payable(to).transfer(amount)}
function unsafeExternalInvoke(address callee) public {
    callee.call(abi.encodePacked("externalFn()"))}
function commitData(bytes32 dataHash) public {
    require(dataRecord[dataHash] == 0);
    dataRecord[dataHash] = block.timestamp}