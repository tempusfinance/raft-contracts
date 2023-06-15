// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import { IWstETH } from "../Dependencies/IWstETH.sol";
import { ITellor, BaseTellorPriceOracle } from "./BaseTellorPriceOracle.sol";
import { BasePriceOracleWstETH } from "./BasePriceOracleWstETH.sol";

contract TellorPriceOracleWstETH is BaseTellorPriceOracle, BasePriceOracleWstETH {
    // --- Constants & immutables ---

    uint256 public constant override DEVIATION = 5e15; // 0.5%

    uint256 private constant _TELLOR_DIGITS = 18;

    bytes32 private constant _STETH_TELLOR_QUERY_ID = keccak256(abi.encode("SpotPrice", abi.encode("steth", "usd")));

    // --- Constructor ---

    // solhint-disable-next-line no-empty-blocks
    constructor(ITellor tellor_, IWstETH wstETH_) BaseTellorPriceOracle(tellor_) BasePriceOracleWstETH(wstETH_) { }

    // --- Functions ---

    function getPriceOracleResponse() external override returns (PriceOracleResponse memory) {
        TellorResponse memory tellorResponse = _getCurrentTellorResponse(_STETH_TELLOR_QUERY_ID);

        if (_tellorIsBroken(tellorResponse) || _oracleIsFrozen(tellorResponse.timestamp)) {
            return (PriceOracleResponse(true, false, 0));
        }
        return (PriceOracleResponse(false, false, _convertIntoWstETHPrice(tellorResponse.value, _TELLOR_DIGITS)));
    }
}
