// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract DeployAndUpgradeTest is StdCheats, Test {
    DeployBox deployer;
    UpgradeBox upgrader;
    address public OWNER = makeAddr("owner");

    address proxy;

    function setUp() public {
        deployer = new DeployBox();
        upgrader = new UpgradeBox();

        //Deploy boxV1 che restituisce l'address del proxy
        proxy = deployer.run(); //point to boxV1
    }

    function testProxyStartsAtBox1() public {
        vm.expectRevert();
        BoxV2(proxy).setNumber(7);
    }

    function testUpgrades() public {
        //Deploy di boxV2
        BoxV2 box2 = new BoxV2();

        upgrader.upgradeBox(proxy, address(box2)); //adesso punta all'indirizzo di boxV2

        uint256 expectedValue = 2;
        assertEq(expectedValue, BoxV2(proxy).version());

        BoxV2(proxy).setNumber(7);
        assertEq(7, BoxV2(proxy).getNumber());
    }
}
