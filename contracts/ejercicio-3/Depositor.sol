// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

interface IVaultV2 {
    function deposit() external payable;
    function withdraw() external;
}

contract Depositor is Ownable {

    IVaultV2 public immutable vault;

    constructor(address vaultContractAddress) {
        vault = IVaultV2(vaultContractAddress);
    }

    function depositToVault() external payable onlyOwner {
        vault.deposit{value: msg.value}();
        // COMPLETAR
        // La sintaxis para enviar ETH de un contrato a otro podés verla acá https://docs.soliditylang.org/en/v0.8.7/control-structures.html#external-function-calls
    }

    function withdrawFromVault() external onlyOwner {
        vault.withdraw();
    }

    // 1. ¿Por qué es necesaria esta función? Sin receive cuando se retiran los fondos da error.
    // Es una función especial para que el contrato pueda recibir ether de otro contrato. 
    // 2. ¿Qué pasa si la borramos? No puede recibir ether del otro contrato.
    // 3. Aún así, ¿es suficiente? ¿No necesitamos lógica adicional? 
    // 4. De ser necesaria, ¿podemos incluir esa lógica acá? DE manera nativa
    // transfer y receive tiene asignado 2300 de gas nomás. Solo alcanzaría para logguear un evento y poco más.
    receive() external payable {
        // payable(owner()).transfer(address(this).balance); (Esta lógica no se puede implementar aca)
    }

    function retirarTodoElEther() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
