// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract PermisoModifier{
    address public owner;
    string public nombre;
    uint public edad;
    bool public registrado;
    address public usuario;

    constructor (string memory _nombre, uint256 _edad){
        owner = msg.sender;
        nombre = _nombre;
        edad = _edad;
        registrado = false;
        usuario = address(0);
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner, "puedes ejecutar la funcion"); 
        _; 
    }

    function registrarUsuario(address _usuario) public onlyOwner {
        usuario = _usuario;
    }

    function cambiarNombre(string memory _nombre) public onlyOwner{
        nombre = _nombre;
    }

    function cambiarEdad(uint _edad) public onlyOwner{
        edad = _edad;
    }
    function cambiarRegistrado() public onlyOwner{
        registrado = !registrado;
    }
}