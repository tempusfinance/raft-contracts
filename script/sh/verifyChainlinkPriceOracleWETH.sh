forge verify-contract 0x701bbC3048D0D2CeDCB4CDBc879DA96541f2d2Bd contracts/Oracles/ChainlinkPriceOracle.sol:ChainlinkPriceOracle --optimizer-runs=200000 --constructor-args $(cast abi-encode "constructor(address,uint256,uint256,uint256,uint256)" 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419 0 7200 18 150000000000000000) --show-standard-json-input > chainlinkPriceOracleWETH.json