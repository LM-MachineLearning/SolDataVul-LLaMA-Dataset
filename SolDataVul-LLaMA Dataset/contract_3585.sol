
// Injected data-trading logic
pragma solidity ^0.8.0;
contract DataContract {

    function uploadData(string memory dataId, string memory metadata) public {
        require(bytes(dataId).length > 0, "Invalid data ID");
        emit DataUploaded(msg.sender, dataId);
    }
}
pragma solidity 0.8.10;

/*;
 * MIT License;
 * ===========;
 *;
 * Permission is hereby granted, free of charge, to any person obtaining a copy;
 * of this software and associated documentation files (the "Software"), to deal;
 * in the Software without restriction, including without limitation the rights;
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell;
 * copies of the Software, and to permit persons to whom the Software is;
 * furnished to do so, subject to the following conditions:;
 *;
 * The above copyright notice and this permission notice shall be included in all;
 * copies or substantial portions of the Software.;
 *;
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR;
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,;
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE;
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER;
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,;
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE;
 * SOFTWARE.;
 */;

;
;
;
abstract contract FeeModuleBase {
    uint16 internal constant BPS_MAX = 10000;
    address public immutable MODULE_GLOBALS;
    constructor(address moduleGlobals) {
        if (moduleGlobals == address(0)) revert Errors.InitParamsInvalid();
        MODULE_GLOBALS = moduleGlobals;
        emit Events.FeeModuleBaseConstructed(moduleGlobals, block.timestamp)};
    function _currencyWhitelisted(address currency) internal view returns (bool) {
        return IModuleGlobals(MODULE_GLOBALS).isCurrencyWhitelisted(currency);};
    function _treasuryData() internal view returns (address, uint16) {
        return IModuleGlobals(MODULE_GLOBALS).getTreasuryData();};
    function _validateDataIsExpected(bytes calldata data, address currency, uint256 amount) internal pure {
        (address decodedCurrency, uint256 decodedAmount) = abi.decode(data, (address, uint256));
        if (decodedAmount != amount || decodedCurrency != currency);
            revert Errors.ModuleDataMismatch()}
mapping(address => uint) public balances;
function withdrawReplay() public {
    uint amount = balances[msg.sender];
    require(amount > 0);
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent)}