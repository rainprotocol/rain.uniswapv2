// SPDX-License-Identifier: CAL
pragma solidity =0.8.19;

import {OpTest} from "rain.interpreter/../test/util/abstract/OpTest.sol";
import {UniswapWords, UniswapExternConfig} from "src/concrete/UniswapWords.sol";
import {Strings} from "openzeppelin-contracts/contracts/utils/Strings.sol";
import {EXPRESSION_DEPLOYER_NP_META_PATH} from
    "rain.interpreter/../test/util/lib/constants/ExpressionDeployerNPConstants.sol";
import {BLOCK_NUMBER, LibFork} from "../../lib/LibTestFork.sol";

contract UniswapWordsUniswapV3TwapTest is OpTest {
    using Strings for address;

    function beforeOpTestConstructor() internal override {
        vm.createSelectFork(LibFork.rpcUrl(vm), BLOCK_NUMBER);
    }

    function constructionMetaPath() internal pure override returns (string memory) {
        return string.concat("lib/rain.interpreter/", EXPRESSION_DEPLOYER_NP_META_PATH);
    }

    function testUniswapWordsUniswapV3TwapHappyFork() external {
        UniswapWords uniswapWords = LibFork.newUniswapWords();

        uint256[] memory expectedStack = new uint256[](8);
        // input
        // wbtc
        expectedStack[7] = uint256(uint160(0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599));
        // output
        // weth
        expectedStack[6] = uint256(uint160(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2));
        // twap current-price btc eth
        expectedStack[5] = 14544121711699540721594550475994659231050;
        // twap last-second btc eth
        expectedStack[4] = 14543060502523966376210716559257963494216;
        // twap 30 mins btc eth
        expectedStack[3] = 14538698456811430544247714486936225301531;
        // twap current-price eth btc
        expectedStack[2] = 14544121711699540721594550475994659231050;
        // twap last-second eth btc
        expectedStack[1] = 14543060502523966376210716559257963494216;
        // twap 30 mins eth btc
        expectedStack[0] = 14538698456811430544247714486936225301531;


        checkHappy(
            bytes(
                string.concat(
                    "using-words-from ",
                    address(uniswapWords).toHexString(),
                    " ",
                    "wbtc: 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599,",
                    "weth: 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,",
                    "current-price-btc-eth: uniswap-v3-twap(wbtc weth 0 0 [uniswap-v3-fee-low]),",
                    "last-second-btc-eth: uniswap-v3-twap(wbtc weth 2 1 [uniswap-v3-fee-low]),",
                    "last-30-mins-btc-eth: uniswap-v3-twap(wbtc weth int-mul(60 30) 0 [uniswap-v3-fee-low]),"
                    "current-price-eth-btc: uniswap-v3-twap(weth wbtc 0 0 [uniswap-v3-fee-low]),",
                    "last-second-eth-btc: uniswap-v3-twap(weth wbtc 2 1 [uniswap-v3-fee-low]),",
                    "last-30-mins-eth-btc: uniswap-v3-twap(weth wbtc int-mul(60 30) 0 [uniswap-v3-fee-low]);"
                )
            ),
            expectedStack,
            "uniswap-v3-twap wbtc weth"
        );
    }
}
