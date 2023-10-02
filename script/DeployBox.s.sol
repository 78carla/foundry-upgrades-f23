// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

//Mi restituisce l'indirizzo del proxy
contract DeployBox is Script {
    function run() external returns (address) {
        address proxy = deployBox();
        return proxy;
    }

    function deployBox() internal returns (address) {
        vm.startBroadcast();
        BoxV1 box = new BoxV1(); //implementation (logic) - dove il proxy punta per le delegatecall
        //Addesso abbiamo bisogno di un proxy che punta alla nostra implementazione. Uso ERC1967Proxy
        //Deploy the proxy
        ERC1967Proxy proxy = new ERC1967Proxy(address(box), ""); //proxy - dove il proxy punta per le delegatecall
        vm.stopBroadcast();
        return address(proxy);
    }
}
