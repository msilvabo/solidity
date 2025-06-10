// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract OperatorLogico { 
    bool public solea = true; 
    bool public llueve = false;

    bool public and;
    bool public or;
    bool public not;

    constructor() {
        and = solea && llueve;
        or = solea || llueve;
        not = !solea;
    }
}
