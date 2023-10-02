// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract BoxV1 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    //Dobbiamo mettere in questo contratto la logica che poi vogliamo aggiornare in un secondo contratto BoxV2

    uint256 internal number;

    // @custom:oz-upgrades-unsafe-allow constructor
    //Storage is stored in the proxy, NOT in the implementation
    //Proxy (number = 0) -> Implementation (con constructor number = 1)
    // Quindi non usiamo il contructor nell'implementation
    //Proxy --> deploy implementation --> call some initialized funtion (initializer sostanzialmente è il mio "contructor" ma che può essere chiamato dal proxy)
    constructor() {
        //Don't let any inizialization happen
        _disableInitializers();
    }

    //Funzione di inizializzazione che può chiamare il mio proxy
    function initialize() public initializer {
        __Ownable_init(); //set owner to: owner = msg.sender
        __UUPSUpgradeable_init(); //non fa niente come funzione ma indica che upgradable contract
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 1;
    }

    //La lasciamo vuota perchè non voliamo aggiungere nessuna autorizzazione
    function _authorizeUpgrade(address newImplementation) internal override {
        //if(msg.sender != owner()) {
        //    revert("Unauthorized");
        //}
    }
}
