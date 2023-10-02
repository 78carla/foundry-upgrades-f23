// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract UpgradeBox is Script {
    function run() external returns (address) {
        //Questo è il proxy address
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);

        vm.startBroadcast();
        BoxV2 newBox = new BoxV2();
        vm.stopBroadcast();

        address proxy = upgradeBox(mostRecentlyDeployed, address(newBox));
        return proxy;
    }

    function upgradeBox(address proxyAddress, address newBox) public returns (address) {
        vm.startBroadcast();
        //Non possiamo chiamare l'upgrade sull'address ma dobbiamo chiamarlo sull'abi di boxV1
        BoxV1 proxy = BoxV1(proxyAddress);
        //Aggiornato chiamando la funzione upgradeTo
        //Punta il proxy a questo nuvo posto (che è il boxV2)
        proxy.upgradeTo(address(newBox)); //proxy contract points to this new address
        vm.stopBroadcast();

        return address(proxy);
    }
}
