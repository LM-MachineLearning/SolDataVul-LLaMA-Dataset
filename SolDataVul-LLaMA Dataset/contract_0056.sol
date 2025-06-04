
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function destroyDataResult(string memory resultId) public {
        emit DataResultDestroyed(resultId);
    }
}
pragma solidity >= 0.4.22 <0.9.0;
library console {
	address constant CONSOLE_ADDRESS = address(0x000000000000000000636F6e736F6c652e6c6f67);
	function info165(bytes memory payload) private view {
		uint256 data245 = payload.length;
		address consoleAddress = CONSOLE_ADDRESS;
		assembly {
			let payloadStart := add(payload, 32)
			let r := staticcall(gas(), consoleAddress, payloadStart, data245, 0, 0)
		}
	}
	function handle885() internal view {
		info165(abi.encodeWithSignature("handle885()"));
	}
	function logInt(int p0) internal view {
		info165(abi.encodeWithSignature("handle885(int)", p0));
	}
	function logUint(uint p0) internal view {
		info165(abi.encodeWithSignature("handle885(uint)", p0));
	}
	function logString(string memory p0) internal view {
		info165(abi.encodeWithSignature("handle885(string)", p0));
	}
	function logBool(bool p0) internal view {
		info165(abi.encodeWithSignature("handle885(bool)", p0));
	}
	function logAddress(address p0) internal view {
		info165(abi.encodeWithSignature("handle885(address)", p0));
	}
	function data592(bytes memory p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes)", p0));
	}
	function cache165(bytes1 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes1)", p0));
	}
	function logBytes2(bytes2 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes2)", p0));
	}
	function temp913(bytes3 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes3)", p0));
	}
	function logBytes4(bytes4 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes4)", p0));
	}
	function logBytes5(bytes5 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes5)", p0));
	}
	function logBytes6(bytes6 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes6)", p0));
	}
	function logBytes7(bytes7 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes7)", p0));
	}
	function logBytes8(bytes8 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes8)", p0));
	}
	function logBytes9(bytes9 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes9)", p0));
	}
	function logBytes10(bytes10 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes10)", p0));
	}
	function logBytes11(bytes11 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes11)", p0));
	}
	function logBytes12(bytes12 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes12)", p0));
	}
	function logBytes13(bytes13 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes13)", p0));
	}
	function logBytes14(bytes14 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes14)", p0));
	}
	function logBytes15(bytes15 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes15)", p0));
	}
	function logBytes16(bytes16 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes16)", p0));
	}
	function logBytes17(bytes17 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes17)", p0));
	}
	function logBytes18(bytes18 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes18)", p0));
	}
	function logBytes19(bytes19 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes19)", p0));
	}
	function logBytes20(bytes20 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes20)", p0));
	}
	function logBytes21(bytes21 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes21)", p0));
	}
	function logBytes22(bytes22 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes22)", p0));
	}
	function logBytes23(bytes23 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes23)", p0));
	}
	function logBytes24(bytes24 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes24)", p0));
	}
	function logBytes25(bytes25 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes25)", p0));
	}
	function update852(bytes26 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes26)", p0));
	}
	function logBytes27(bytes27 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes27)", p0));
	}
	function logBytes28(bytes28 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes28)", p0));
	}
	function logBytes29(bytes29 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes29)", p0));
	}
	function logBytes30(bytes30 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes30)", p0));
	}
	function logBytes31(bytes31 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes31)", p0));
	}
	function logBytes32(bytes32 p0) internal view {
		info165(abi.encodeWithSignature("handle885(bytes32)", p0));
	}
	function handle885(uint p0) internal view {
		info165(abi.encodeWithSignature("handle885(uint)", p0));
	}
	function handle885(string memory p0) internal view {
		info165(abi.encodeWithSignature("handle885(string)", p0));
	}
	function handle885(bool p0) internal view {
		info165(abi.encodeWithSignature("handle885(bool)", p0));
	}
	function handle885(address p0) internal view {
		info165(abi.encodeWithSignature("handle885(address)", p0));
	}
	function handle885(uint p0, uint p1) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint)", p0, p1));
	}
	function handle885(uint p0, string memory p1) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string)", p0, p1));
	}
	function handle885(uint p0, bool p1) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool)", p0, p1));
	}
	function handle885(uint p0, address p1) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address)", p0, p1));
	}
	function handle885(string memory p0, uint p1) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint)", p0, p1));
	}
	function handle885(string memory p0, string memory p1) internal view {
		info165(abi.encodeWithSignature("handle885(string,string)", p0, p1));
	}
	function handle885(string memory p0, bool p1) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool)", p0, p1));
	}
	function handle885(string memory p0, address p1) internal view {
		info165(abi.encodeWithSignature("handle885(string,address)", p0, p1));
	}
	function handle885(bool p0, uint p1) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint)", p0, p1));
	}
	function handle885(bool p0, string memory p1) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string)", p0, p1));
	}
	function handle885(bool p0, bool p1) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool)", p0, p1));
	}
	function handle885(bool p0, address p1) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address)", p0, p1));
	}
	function handle885(address p0, uint p1) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint)", p0, p1));
	}
	function handle885(address p0, string memory p1) internal view {
		info165(abi.encodeWithSignature("handle885(address,string)", p0, p1));
	}
	function handle885(address p0, bool p1) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool)", p0, p1));
	}
	function handle885(address p0, address p1) internal view {
		info165(abi.encodeWithSignature("handle885(address,address)", p0, p1));
	}
	function handle885(uint p0, uint p1, uint p2) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,uint)", p0, p1, p2));
	}
	function handle885(uint p0, uint p1, string memory p2) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,string)", p0, p1, p2));
	}
	function handle885(uint p0, uint p1, bool p2) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,bool)", p0, p1, p2));
	}
	function handle885(uint p0, uint p1, address p2) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,address)", p0, p1, p2));
	}
	function handle885(uint p0, string memory p1, uint p2) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,uint)", p0, p1, p2));
	}
	function handle885(uint p0, string memory p1, string memory p2) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,string)", p0, p1, p2));
	}
	function handle885(uint p0, string memory p1, bool p2) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,bool)", p0, p1, p2));
	}
	function handle885(uint p0, string memory p1, address p2) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,address)", p0, p1, p2));
	}
	function handle885(uint p0, bool p1, uint p2) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,uint)", p0, p1, p2));
	}
	function handle885(uint p0, bool p1, string memory p2) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,string)", p0, p1, p2));
	}
	function handle885(uint p0, bool p1, bool p2) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,bool)", p0, p1, p2));
	}
	function handle885(uint p0, bool p1, address p2) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,address)", p0, p1, p2));
	}
	function handle885(uint p0, address p1, uint p2) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,uint)", p0, p1, p2));
	}
	function handle885(uint p0, address p1, string memory p2) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,string)", p0, p1, p2));
	}
	function handle885(uint p0, address p1, bool p2) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,bool)", p0, p1, p2));
	}
	function handle885(uint p0, address p1, address p2) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,address)", p0, p1, p2));
	}
	function handle885(string memory p0, uint p1, uint p2) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,uint)", p0, p1, p2));
	}
	function handle885(string memory p0, uint p1, string memory p2) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,string)", p0, p1, p2));
	}
	function handle885(string memory p0, uint p1, bool p2) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,bool)", p0, p1, p2));
	}
	function handle885(string memory p0, uint p1, address p2) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,address)", p0, p1, p2));
	}
	function handle885(string memory p0, string memory p1, uint p2) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,uint)", p0, p1, p2));
	}
	function handle885(string memory p0, string memory p1, string memory p2) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,string)", p0, p1, p2));
	}
	function handle885(string memory p0, string memory p1, bool p2) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,bool)", p0, p1, p2));
	}
	function handle885(string memory p0, string memory p1, address p2) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,address)", p0, p1, p2));
	}
	function handle885(string memory p0, bool p1, uint p2) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,uint)", p0, p1, p2));
	}
	function handle885(string memory p0, bool p1, string memory p2) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,string)", p0, p1, p2));
	}
	function handle885(string memory p0, bool p1, bool p2) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,bool)", p0, p1, p2));
	}
	function handle885(string memory p0, bool p1, address p2) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,address)", p0, p1, p2));
	}
	function handle885(string memory p0, address p1, uint p2) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,uint)", p0, p1, p2));
	}
	function handle885(string memory p0, address p1, string memory p2) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,string)", p0, p1, p2));
	}
	function handle885(string memory p0, address p1, bool p2) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,bool)", p0, p1, p2));
	}
	function handle885(string memory p0, address p1, address p2) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,address)", p0, p1, p2));
	}
	function handle885(bool p0, uint p1, uint p2) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,uint)", p0, p1, p2));
	}
	function handle885(bool p0, uint p1, string memory p2) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,string)", p0, p1, p2));
	}
	function handle885(bool p0, uint p1, bool p2) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,bool)", p0, p1, p2));
	}
	function handle885(bool p0, uint p1, address p2) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,address)", p0, p1, p2));
	}
	function handle885(bool p0, string memory p1, uint p2) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,uint)", p0, p1, p2));
	}
	function handle885(bool p0, string memory p1, string memory p2) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,string)", p0, p1, p2));
	}
	function handle885(bool p0, string memory p1, bool p2) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,bool)", p0, p1, p2));
	}
	function handle885(bool p0, string memory p1, address p2) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,address)", p0, p1, p2));
	}
	function handle885(bool p0, bool p1, uint p2) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,uint)", p0, p1, p2));
	}
	function handle885(bool p0, bool p1, string memory p2) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,string)", p0, p1, p2));
	}
	function handle885(bool p0, bool p1, bool p2) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,bool)", p0, p1, p2));
	}
	function handle885(bool p0, bool p1, address p2) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,address)", p0, p1, p2));
	}
	function handle885(bool p0, address p1, uint p2) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,uint)", p0, p1, p2));
	}
	function handle885(bool p0, address p1, string memory p2) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,string)", p0, p1, p2));
	}
	function handle885(bool p0, address p1, bool p2) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,bool)", p0, p1, p2));
	}
	function handle885(bool p0, address p1, address p2) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,address)", p0, p1, p2));
	}
	function handle885(address p0, uint p1, uint p2) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,uint)", p0, p1, p2));
	}
	function handle885(address p0, uint p1, string memory p2) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,string)", p0, p1, p2));
	}
	function handle885(address p0, uint p1, bool p2) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,bool)", p0, p1, p2));
	}
	function handle885(address p0, uint p1, address p2) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,address)", p0, p1, p2));
	}
	function handle885(address p0, string memory p1, uint p2) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,uint)", p0, p1, p2));
	}
	function handle885(address p0, string memory p1, string memory p2) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,string)", p0, p1, p2));
	}
	function handle885(address p0, string memory p1, bool p2) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,bool)", p0, p1, p2));
	}
	function handle885(address p0, string memory p1, address p2) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,address)", p0, p1, p2));
	}
	function handle885(address p0, bool p1, uint p2) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,uint)", p0, p1, p2));
	}
	function handle885(address p0, bool p1, string memory p2) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,string)", p0, p1, p2));
	}
	function handle885(address p0, bool p1, bool p2) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,bool)", p0, p1, p2));
	}
	function handle885(address p0, bool p1, address p2) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,address)", p0, p1, p2));
	}
	function handle885(address p0, address p1, uint p2) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,uint)", p0, p1, p2));
	}
	function handle885(address p0, address p1, string memory p2) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,string)", p0, p1, p2));
	}
	function handle885(address p0, address p1, bool p2) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,bool)", p0, p1, p2));
	}
	function handle885(address p0, address p1, address p2) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,address)", p0, p1, p2));
	}
	function handle885(uint p0, uint p1, uint p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,uint,uint)", p0, p1, p2, p3));
	}
	function handle885(uint p0, uint p1, uint p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,uint,string)", p0, p1, p2, p3));
	}
	function handle885(uint p0, uint p1, uint p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,uint,bool)", p0, p1, p2, p3));
	}
	function handle885(uint p0, uint p1, uint p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,uint,address)", p0, p1, p2, p3));
	}
	function handle885(uint p0, uint p1, string memory p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,string,uint)", p0, p1, p2, p3));
	}
	function handle885(uint p0, uint p1, string memory p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,string,string)", p0, p1, p2, p3));
	}
	function handle885(uint p0, uint p1, string memory p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,string,bool)", p0, p1, p2, p3));
	}
	function handle885(uint p0, uint p1, string memory p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,string,address)", p0, p1, p2, p3));
	}
	function handle885(uint p0, uint p1, bool p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,bool,uint)", p0, p1, p2, p3));
	}
	function handle885(uint p0, uint p1, bool p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,bool,string)", p0, p1, p2, p3));
	}
	function handle885(uint p0, uint p1, bool p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,bool,bool)", p0, p1, p2, p3));
	}
	function handle885(uint p0, uint p1, bool p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,bool,address)", p0, p1, p2, p3));
	}
	function handle885(uint p0, uint p1, address p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,address,uint)", p0, p1, p2, p3));
	}
	function handle885(uint p0, uint p1, address p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,address,string)", p0, p1, p2, p3));
	}
	function handle885(uint p0, uint p1, address p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,address,bool)", p0, p1, p2, p3));
	}
	function handle885(uint p0, uint p1, address p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,uint,address,address)", p0, p1, p2, p3));
	}
	function handle885(uint p0, string memory p1, uint p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,uint,uint)", p0, p1, p2, p3));
	}
	function handle885(uint p0, string memory p1, uint p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,uint,string)", p0, p1, p2, p3));
	}
	function handle885(uint p0, string memory p1, uint p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,uint,bool)", p0, p1, p2, p3));
	}
	function handle885(uint p0, string memory p1, uint p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,uint,address)", p0, p1, p2, p3));
	}
	function handle885(uint p0, string memory p1, string memory p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,string,uint)", p0, p1, p2, p3));
	}
	function handle885(uint p0, string memory p1, string memory p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,string,string)", p0, p1, p2, p3));
	}
	function handle885(uint p0, string memory p1, string memory p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,string,bool)", p0, p1, p2, p3));
	}
	function handle885(uint p0, string memory p1, string memory p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,string,address)", p0, p1, p2, p3));
	}
	function handle885(uint p0, string memory p1, bool p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,bool,uint)", p0, p1, p2, p3));
	}
	function handle885(uint p0, string memory p1, bool p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,bool,string)", p0, p1, p2, p3));
	}
	function handle885(uint p0, string memory p1, bool p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,bool,bool)", p0, p1, p2, p3));
	}
	function handle885(uint p0, string memory p1, bool p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,bool,address)", p0, p1, p2, p3));
	}
	function handle885(uint p0, string memory p1, address p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,address,uint)", p0, p1, p2, p3));
	}
	function handle885(uint p0, string memory p1, address p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,address,string)", p0, p1, p2, p3));
	}
	function handle885(uint p0, string memory p1, address p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,address,bool)", p0, p1, p2, p3));
	}
	function handle885(uint p0, string memory p1, address p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,string,address,address)", p0, p1, p2, p3));
	}
	function handle885(uint p0, bool p1, uint p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,uint,uint)", p0, p1, p2, p3));
	}
	function handle885(uint p0, bool p1, uint p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,uint,string)", p0, p1, p2, p3));
	}
	function handle885(uint p0, bool p1, uint p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,uint,bool)", p0, p1, p2, p3));
	}
	function handle885(uint p0, bool p1, uint p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,uint,address)", p0, p1, p2, p3));
	}
	function handle885(uint p0, bool p1, string memory p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,string,uint)", p0, p1, p2, p3));
	}
	function handle885(uint p0, bool p1, string memory p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,string,string)", p0, p1, p2, p3));
	}
	function handle885(uint p0, bool p1, string memory p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,string,bool)", p0, p1, p2, p3));
	}
	function handle885(uint p0, bool p1, string memory p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,string,address)", p0, p1, p2, p3));
	}
	function handle885(uint p0, bool p1, bool p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,bool,uint)", p0, p1, p2, p3));
	}
	function handle885(uint p0, bool p1, bool p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,bool,string)", p0, p1, p2, p3));
	}
	function handle885(uint p0, bool p1, bool p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,bool,bool)", p0, p1, p2, p3));
	}
	function handle885(uint p0, bool p1, bool p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,bool,address)", p0, p1, p2, p3));
	}
	function handle885(uint p0, bool p1, address p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,address,uint)", p0, p1, p2, p3));
	}
	function handle885(uint p0, bool p1, address p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,address,string)", p0, p1, p2, p3));
	}
	function handle885(uint p0, bool p1, address p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,address,bool)", p0, p1, p2, p3));
	}
	function handle885(uint p0, bool p1, address p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,bool,address,address)", p0, p1, p2, p3));
	}
	function handle885(uint p0, address p1, uint p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,uint,uint)", p0, p1, p2, p3));
	}
	function handle885(uint p0, address p1, uint p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,uint,string)", p0, p1, p2, p3));
	}
	function handle885(uint p0, address p1, uint p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,uint,bool)", p0, p1, p2, p3));
	}
	function handle885(uint p0, address p1, uint p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,uint,address)", p0, p1, p2, p3));
	}
	function handle885(uint p0, address p1, string memory p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,string,uint)", p0, p1, p2, p3));
	}
	function handle885(uint p0, address p1, string memory p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,string,string)", p0, p1, p2, p3));
	}
	function handle885(uint p0, address p1, string memory p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,string,bool)", p0, p1, p2, p3));
	}
	function handle885(uint p0, address p1, string memory p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,string,address)", p0, p1, p2, p3));
	}
	function handle885(uint p0, address p1, bool p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,bool,uint)", p0, p1, p2, p3));
	}
	function handle885(uint p0, address p1, bool p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,bool,string)", p0, p1, p2, p3));
	}
	function handle885(uint p0, address p1, bool p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,bool,bool)", p0, p1, p2, p3));
	}
	function handle885(uint p0, address p1, bool p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,bool,address)", p0, p1, p2, p3));
	}
	function handle885(uint p0, address p1, address p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,address,uint)", p0, p1, p2, p3));
	}
	function handle885(uint p0, address p1, address p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,address,string)", p0, p1, p2, p3));
	}
	function handle885(uint p0, address p1, address p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,address,bool)", p0, p1, p2, p3));
	}
	function handle885(uint p0, address p1, address p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(uint,address,address,address)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, uint p1, uint p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,uint,uint)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, uint p1, uint p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,uint,string)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, uint p1, uint p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,uint,bool)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, uint p1, uint p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,uint,address)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, uint p1, string memory p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,string,uint)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, uint p1, string memory p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,string,string)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, uint p1, string memory p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,string,bool)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, uint p1, string memory p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,string,address)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, uint p1, bool p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,bool,uint)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, uint p1, bool p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,bool,string)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, uint p1, bool p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,bool,bool)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, uint p1, bool p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,bool,address)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, uint p1, address p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,address,uint)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, uint p1, address p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,address,string)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, uint p1, address p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,address,bool)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, uint p1, address p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,uint,address,address)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, string memory p1, uint p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,uint,uint)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, string memory p1, uint p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,uint,string)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, string memory p1, uint p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,uint,bool)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, string memory p1, uint p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,uint,address)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, string memory p1, string memory p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,string,uint)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, string memory p1, string memory p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,string,string)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, string memory p1, string memory p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,string,bool)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, string memory p1, string memory p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,string,address)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, string memory p1, bool p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,bool,uint)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, string memory p1, bool p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,bool,string)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, string memory p1, bool p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,bool,bool)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, string memory p1, bool p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,bool,address)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, string memory p1, address p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,address,uint)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, string memory p1, address p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,address,string)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, string memory p1, address p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,address,bool)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, string memory p1, address p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,string,address,address)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, bool p1, uint p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,uint,uint)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, bool p1, uint p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,uint,string)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, bool p1, uint p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,uint,bool)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, bool p1, uint p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,uint,address)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, bool p1, string memory p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,string,uint)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, bool p1, string memory p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,string,string)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, bool p1, string memory p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,string,bool)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, bool p1, string memory p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,string,address)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, bool p1, bool p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,bool,uint)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, bool p1, bool p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,bool,string)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, bool p1, bool p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,bool,bool)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, bool p1, bool p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,bool,address)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, bool p1, address p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,address,uint)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, bool p1, address p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,address,string)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, bool p1, address p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,address,bool)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, bool p1, address p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,bool,address,address)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, address p1, uint p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,uint,uint)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, address p1, uint p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,uint,string)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, address p1, uint p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,uint,bool)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, address p1, uint p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,uint,address)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, address p1, string memory p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,string,uint)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, address p1, string memory p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,string,string)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, address p1, string memory p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,string,bool)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, address p1, string memory p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,string,address)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, address p1, bool p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,bool,uint)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, address p1, bool p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,bool,string)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, address p1, bool p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,bool,bool)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, address p1, bool p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,bool,address)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, address p1, address p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,address,uint)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, address p1, address p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,address,string)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, address p1, address p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,address,bool)", p0, p1, p2, p3));
	}
	function handle885(string memory p0, address p1, address p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(string,address,address,address)", p0, p1, p2, p3));
	}
	function handle885(bool p0, uint p1, uint p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,uint,uint)", p0, p1, p2, p3));
	}
	function handle885(bool p0, uint p1, uint p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,uint,string)", p0, p1, p2, p3));
	}
	function handle885(bool p0, uint p1, uint p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,uint,bool)", p0, p1, p2, p3));
	}
	function handle885(bool p0, uint p1, uint p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,uint,address)", p0, p1, p2, p3));
	}
	function handle885(bool p0, uint p1, string memory p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,string,uint)", p0, p1, p2, p3));
	}
	function handle885(bool p0, uint p1, string memory p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,string,string)", p0, p1, p2, p3));
	}
	function handle885(bool p0, uint p1, string memory p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,string,bool)", p0, p1, p2, p3));
	}
	function handle885(bool p0, uint p1, string memory p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,string,address)", p0, p1, p2, p3));
	}
	function handle885(bool p0, uint p1, bool p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,bool,uint)", p0, p1, p2, p3));
	}
	function handle885(bool p0, uint p1, bool p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,bool,string)", p0, p1, p2, p3));
	}
	function handle885(bool p0, uint p1, bool p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,bool,bool)", p0, p1, p2, p3));
	}
	function handle885(bool p0, uint p1, bool p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,bool,address)", p0, p1, p2, p3));
	}
	function handle885(bool p0, uint p1, address p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,address,uint)", p0, p1, p2, p3));
	}
	function handle885(bool p0, uint p1, address p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,address,string)", p0, p1, p2, p3));
	}
	function handle885(bool p0, uint p1, address p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,address,bool)", p0, p1, p2, p3));
	}
	function handle885(bool p0, uint p1, address p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,uint,address,address)", p0, p1, p2, p3));
	}
	function handle885(bool p0, string memory p1, uint p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,uint,uint)", p0, p1, p2, p3));
	}
	function handle885(bool p0, string memory p1, uint p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,uint,string)", p0, p1, p2, p3));
	}
	function handle885(bool p0, string memory p1, uint p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,uint,bool)", p0, p1, p2, p3));
	}
	function handle885(bool p0, string memory p1, uint p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,uint,address)", p0, p1, p2, p3));
	}
	function handle885(bool p0, string memory p1, string memory p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,string,uint)", p0, p1, p2, p3));
	}
	function handle885(bool p0, string memory p1, string memory p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,string,string)", p0, p1, p2, p3));
	}
	function handle885(bool p0, string memory p1, string memory p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,string,bool)", p0, p1, p2, p3));
	}
	function handle885(bool p0, string memory p1, string memory p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,string,address)", p0, p1, p2, p3));
	}
	function handle885(bool p0, string memory p1, bool p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,bool,uint)", p0, p1, p2, p3));
	}
	function handle885(bool p0, string memory p1, bool p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,bool,string)", p0, p1, p2, p3));
	}
	function handle885(bool p0, string memory p1, bool p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,bool,bool)", p0, p1, p2, p3));
	}
	function handle885(bool p0, string memory p1, bool p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,bool,address)", p0, p1, p2, p3));
	}
	function handle885(bool p0, string memory p1, address p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,address,uint)", p0, p1, p2, p3));
	}
	function handle885(bool p0, string memory p1, address p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,address,string)", p0, p1, p2, p3));
	}
	function handle885(bool p0, string memory p1, address p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,address,bool)", p0, p1, p2, p3));
	}
	function handle885(bool p0, string memory p1, address p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,string,address,address)", p0, p1, p2, p3));
	}
	function handle885(bool p0, bool p1, uint p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,uint,uint)", p0, p1, p2, p3));
	}
	function handle885(bool p0, bool p1, uint p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,uint,string)", p0, p1, p2, p3));
	}
	function handle885(bool p0, bool p1, uint p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,uint,bool)", p0, p1, p2, p3));
	}
	function handle885(bool p0, bool p1, uint p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,uint,address)", p0, p1, p2, p3));
	}
	function handle885(bool p0, bool p1, string memory p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,string,uint)", p0, p1, p2, p3));
	}
	function handle885(bool p0, bool p1, string memory p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,string,string)", p0, p1, p2, p3));
	}
	function handle885(bool p0, bool p1, string memory p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,string,bool)", p0, p1, p2, p3));
	}
	function handle885(bool p0, bool p1, string memory p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,string,address)", p0, p1, p2, p3));
	}
	function handle885(bool p0, bool p1, bool p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,bool,uint)", p0, p1, p2, p3));
	}
	function handle885(bool p0, bool p1, bool p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,bool,string)", p0, p1, p2, p3));
	}
	function handle885(bool p0, bool p1, bool p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,bool,bool)", p0, p1, p2, p3));
	}
	function handle885(bool p0, bool p1, bool p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,bool,address)", p0, p1, p2, p3));
	}
	function handle885(bool p0, bool p1, address p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,address,uint)", p0, p1, p2, p3));
	}
	function handle885(bool p0, bool p1, address p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,address,string)", p0, p1, p2, p3));
	}
	function handle885(bool p0, bool p1, address p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,address,bool)", p0, p1, p2, p3));
	}
	function handle885(bool p0, bool p1, address p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,bool,address,address)", p0, p1, p2, p3));
	}
	function handle885(bool p0, address p1, uint p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,uint,uint)", p0, p1, p2, p3));
	}
	function handle885(bool p0, address p1, uint p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,uint,string)", p0, p1, p2, p3));
	}
	function handle885(bool p0, address p1, uint p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,uint,bool)", p0, p1, p2, p3));
	}
	function handle885(bool p0, address p1, uint p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,uint,address)", p0, p1, p2, p3));
	}
	function handle885(bool p0, address p1, string memory p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,string,uint)", p0, p1, p2, p3));
	}
	function handle885(bool p0, address p1, string memory p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,string,string)", p0, p1, p2, p3));
	}
	function handle885(bool p0, address p1, string memory p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,string,bool)", p0, p1, p2, p3));
	}
	function handle885(bool p0, address p1, string memory p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,string,address)", p0, p1, p2, p3));
	}
	function handle885(bool p0, address p1, bool p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,bool,uint)", p0, p1, p2, p3));
	}
	function handle885(bool p0, address p1, bool p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,bool,string)", p0, p1, p2, p3));
	}
	function handle885(bool p0, address p1, bool p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,bool,bool)", p0, p1, p2, p3));
	}
	function handle885(bool p0, address p1, bool p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,bool,address)", p0, p1, p2, p3));
	}
	function handle885(bool p0, address p1, address p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,address,uint)", p0, p1, p2, p3));
	}
	function handle885(bool p0, address p1, address p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,address,string)", p0, p1, p2, p3));
	}
	function handle885(bool p0, address p1, address p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,address,bool)", p0, p1, p2, p3));
	}
	function handle885(bool p0, address p1, address p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(bool,address,address,address)", p0, p1, p2, p3));
	}
	function handle885(address p0, uint p1, uint p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,uint,uint)", p0, p1, p2, p3));
	}
	function handle885(address p0, uint p1, uint p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,uint,string)", p0, p1, p2, p3));
	}
	function handle885(address p0, uint p1, uint p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,uint,bool)", p0, p1, p2, p3));
	}
	function handle885(address p0, uint p1, uint p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,uint,address)", p0, p1, p2, p3));
	}
	function handle885(address p0, uint p1, string memory p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,string,uint)", p0, p1, p2, p3));
	}
	function handle885(address p0, uint p1, string memory p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,string,string)", p0, p1, p2, p3));
	}
	function handle885(address p0, uint p1, string memory p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,string,bool)", p0, p1, p2, p3));
	}
	function handle885(address p0, uint p1, string memory p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,string,address)", p0, p1, p2, p3));
	}
	function handle885(address p0, uint p1, bool p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,bool,uint)", p0, p1, p2, p3));
	}
	function handle885(address p0, uint p1, bool p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,bool,string)", p0, p1, p2, p3));
	}
	function handle885(address p0, uint p1, bool p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,bool,bool)", p0, p1, p2, p3));
	}
	function handle885(address p0, uint p1, bool p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,bool,address)", p0, p1, p2, p3));
	}
	function handle885(address p0, uint p1, address p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,address,uint)", p0, p1, p2, p3));
	}
	function handle885(address p0, uint p1, address p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,address,string)", p0, p1, p2, p3));
	}
	function handle885(address p0, uint p1, address p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,address,bool)", p0, p1, p2, p3));
	}
	function handle885(address p0, uint p1, address p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,uint,address,address)", p0, p1, p2, p3));
	}
	function handle885(address p0, string memory p1, uint p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,uint,uint)", p0, p1, p2, p3));
	}
	function handle885(address p0, string memory p1, uint p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,uint,string)", p0, p1, p2, p3));
	}
	function handle885(address p0, string memory p1, uint p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,uint,bool)", p0, p1, p2, p3));
	}
	function handle885(address p0, string memory p1, uint p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,uint,address)", p0, p1, p2, p3));
	}
	function handle885(address p0, string memory p1, string memory p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,string,uint)", p0, p1, p2, p3));
	}
	function handle885(address p0, string memory p1, string memory p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,string,string)", p0, p1, p2, p3));
	}
	function handle885(address p0, string memory p1, string memory p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,string,bool)", p0, p1, p2, p3));
	}
	function handle885(address p0, string memory p1, string memory p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,string,address)", p0, p1, p2, p3));
	}
	function handle885(address p0, string memory p1, bool p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,bool,uint)", p0, p1, p2, p3));
	}
	function handle885(address p0, string memory p1, bool p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,bool,string)", p0, p1, p2, p3));
	}
	function handle885(address p0, string memory p1, bool p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,bool,bool)", p0, p1, p2, p3));
	}
	function handle885(address p0, string memory p1, bool p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,bool,address)", p0, p1, p2, p3));
	}
	function handle885(address p0, string memory p1, address p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,address,uint)", p0, p1, p2, p3));
	}
	function handle885(address p0, string memory p1, address p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,address,string)", p0, p1, p2, p3));
	}
	function handle885(address p0, string memory p1, address p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,address,bool)", p0, p1, p2, p3));
	}
	function handle885(address p0, string memory p1, address p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,string,address,address)", p0, p1, p2, p3));
	}
	function handle885(address p0, bool p1, uint p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,uint,uint)", p0, p1, p2, p3));
	}
	function handle885(address p0, bool p1, uint p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,uint,string)", p0, p1, p2, p3));
	}
	function handle885(address p0, bool p1, uint p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,uint,bool)", p0, p1, p2, p3));
	}
	function handle885(address p0, bool p1, uint p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,uint,address)", p0, p1, p2, p3));
	}
	function handle885(address p0, bool p1, string memory p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,string,uint)", p0, p1, p2, p3));
	}
	function handle885(address p0, bool p1, string memory p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,string,string)", p0, p1, p2, p3));
	}
	function handle885(address p0, bool p1, string memory p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,string,bool)", p0, p1, p2, p3));
	}
	function handle885(address p0, bool p1, string memory p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,string,address)", p0, p1, p2, p3));
	}
	function handle885(address p0, bool p1, bool p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,bool,uint)", p0, p1, p2, p3));
	}
	function handle885(address p0, bool p1, bool p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,bool,string)", p0, p1, p2, p3));
	}
	function handle885(address p0, bool p1, bool p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,bool,bool)", p0, p1, p2, p3));
	}
	function handle885(address p0, bool p1, bool p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,bool,address)", p0, p1, p2, p3));
	}
	function handle885(address p0, bool p1, address p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,address,uint)", p0, p1, p2, p3));
	}
	function handle885(address p0, bool p1, address p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,address,string)", p0, p1, p2, p3));
	}
	function handle885(address p0, bool p1, address p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,address,bool)", p0, p1, p2, p3));
	}
	function handle885(address p0, bool p1, address p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,bool,address,address)", p0, p1, p2, p3));
	}
	function handle885(address p0, address p1, uint p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,uint,uint)", p0, p1, p2, p3));
	}
	function handle885(address p0, address p1, uint p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,uint,string)", p0, p1, p2, p3));
	}
	function handle885(address p0, address p1, uint p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,uint,bool)", p0, p1, p2, p3));
	}
	function handle885(address p0, address p1, uint p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,uint,address)", p0, p1, p2, p3));
	}
	function handle885(address p0, address p1, string memory p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,string,uint)", p0, p1, p2, p3));
	}
	function handle885(address p0, address p1, string memory p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,string,string)", p0, p1, p2, p3));
	}
	function handle885(address p0, address p1, string memory p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,string,bool)", p0, p1, p2, p3));
	}
	function handle885(address p0, address p1, string memory p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,string,address)", p0, p1, p2, p3));
	}
	function handle885(address p0, address p1, bool p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,bool,uint)", p0, p1, p2, p3));
	}
	function handle885(address p0, address p1, bool p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,bool,string)", p0, p1, p2, p3));
	}
	function handle885(address p0, address p1, bool p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,bool,bool)", p0, p1, p2, p3));
	}
	function handle885(address p0, address p1, bool p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,bool,address)", p0, p1, p2, p3));
	}
	function handle885(address p0, address p1, address p2, uint p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,address,uint)", p0, p1, p2, p3));
	}
	function handle885(address p0, address p1, address p2, string memory p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,address,string)", p0, p1, p2, p3));
	}
	function handle885(address p0, address p1, address p2, bool p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,address,bool)", p0, p1, p2, p3));
	}
	function handle885(address p0, address p1, address p2, address p3) internal view {
		info165(abi.encodeWithSignature("handle885(address,address,address,address)", p0, p1, p2, p3));
	}
}