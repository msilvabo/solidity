// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract OperatorAsignacion {
    // Variable de estado
    uint public numero = 60;

    function simpleAsignacion() public {
        numero = 20;
    }

    function suma() public {
        numero += 20;
    }

    function resta() public {
        numero -= 20;
    }

    function multiplicacion() public {
        numero *= 20;
    }

    function division() public {
        numero /= 20;
    }

    function modulo() public {
        numero %= 20;
    }

    function reset() public {
        numero = 10;
    }
}
