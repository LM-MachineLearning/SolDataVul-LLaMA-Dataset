
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity >=0.8.7;
import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
contract APIConsumer is ChainlinkClient {
    using Chainlink for Chainlink.Request;
    address public gotAddress;
    bytes32 public resp;
    string public resp_str;
    address private oracle;
    bytes32 private jobId;
    uint256 private fee;
    constructor(address _oracle, bytes32 _jobId, uint256 _fee, address _link) {
        if (_link == address(0)) {
            setPublicChainlinkToken();
        } else {
            setChainlinkToken(_link);
        }
        oracle = _oracle;
        jobId = _jobId;
        fee = _fee;
    }
    function requestData() public returns (bytes32 requestId)
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);
        request.add("get", "https:
        return sendChainlinkRequestTo(oracle, request, fee);
    }
    function getFee() public view returns (uint256) {
        return fee;
    }
    function fulfill(bytes32 _requestId, uint256 _address) public recordChainlinkFulfillment(_requestId)
    {
        gotAddress = address(uint160(_address));
    }
}
