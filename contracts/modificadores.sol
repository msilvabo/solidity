// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract EjemploModifier{
    address public owner;
    uint public numero;
    bool public contratoActivo;

    constructor (){
        owner = msg.sender;
        contratoActivo = false;
    }

    modifier soloOwner(){
        require(msg.sender == owner, "puedes ejecutar la funcion"); 
        _; 
    }
    modifier contratoEstaActivo() {
        require(contratoActivo == true, "El contrato no esta activo");
        _;
    }

    modifier numeroPositivo(uint256 _num) {
        require(_num > 0, "El numero debe ser mayor a cero");
        _;
    }
    function obtenerNumero() public view returns (uint256) {
        return numero;
    }    
    function desactivarContrato() public soloOwner {
        contratoActivo = false;
    }
    
    function activarContrato() public soloOwner {
        contratoActivo = true;
    }

    function cambiarNumero(uint256 _nuevoNumero) public soloOwner contratoEstaActivo numeroPositivo(_nuevoNumero) 
    {
        numero = _nuevoNumero;
    }    
}