// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract BoxV2 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    //Dobbiamo mettere in questo contratto la logica che poi vogliamo aggiornare in un secondo contratto BoxV2

    uint256 internal number;

    constructor() {
        //Don't let any inizialization happen
        _disableInitializers();
    }

    //Funzione di inizializzazione che può chiamare il mio proxy
    function initialize() public initializer {
        __Ownable_init(); //set owner to: owner = msg.sender
        __UUPSUpgradeable_init(); //non fa niente come funzione ma indica che upgradable contract
    }

    function setNumber(uint256 _number) external {
        number = _number;
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 2;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}
