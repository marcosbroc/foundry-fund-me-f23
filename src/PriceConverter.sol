// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getConversionRate(uint256 ethAmount, AggregatorV3Interface _priceFeed) internal view returns (uint256) {
        uint256 ethPrice = uint256(getPrice(_priceFeed));
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; // To make it 18 decimals
        return ethAmountInUsd;
    }

    function getPrice(AggregatorV3Interface _priceFeed) internal view returns (int256) {
        (, int256 price,,,) = _priceFeed.latestRoundData();
        return price * 1e10; // To make it 18 decimals
    }

    function getVersion(AggregatorV3Interface _priceFeed) internal view returns (uint256) {
        (uint256 version) = _priceFeed.version();
        return version;
    }
}
