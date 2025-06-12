// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract sistemaVotacion{
    struct Partido{
        uint id;
        string sigla;
        string candidato;
        uint nroVotos;
    }

    struct Parametros{
        address autoridadAddress;
        bool inscripcionAbierta;

    }

    Parametros public parametros;
    Partido[] public partidos;

    mapping (address => bool) private votantes;

    constructor(){
        parametros.autoridadAddress = msg.sender;
        parametros.inscripcionAbierta = false;
    }
    
    event VotacionRealizada(uint indexed idPartido, address indexed votante);

    modifier autority(){
        require(parametros.autoridadAddress == msg.sender, "Acceso denegado");
        _;
    }

    modifier votacionAbierta(){
        require(!parametros.inscripcionAbierta, "Accion no pertimida, votacion abierta");
        _;
    }

    modifier votacionCerrada(){
        require(parametros.inscripcionAbierta, "Accion no pertimida, votacion cerrada");
        _;
    }

    function nuevoPartido(string memory _sigla,string memory _candidato) public autority votacionAbierta{
        uint _id = partidos.length;
        partidos.push(Partido(_id,_sigla,_candidato,0));
    }

    function abrirVotacion() public autority {
        parametros.inscripcionAbierta = true;
    }

    function cerrarVotacion() public autority {
        parametros.inscripcionAbierta = false;
    }

    function votar(uint _idPartido) public votacionCerrada{
        require(!votantes[msg.sender], "Error, ya votaste");
        require(_idPartido < partidos.length, "Error, partido inexistente");

        votantes[msg.sender] = true;
        partidos[_idPartido].nroVotos++;

        emit VotacionRealizada(_idPartido, msg.sender);

    }

    function resultados() public votacionAbierta view returns (
        uint[] memory, 
        string[] memory, 
        string[] memory,
        uint[] memory
    ) {
        uint[] memory _ids = new uint[](partidos.length);
        string[] memory _siglas = new string[](partidos.length);
        string[] memory _candidatos = new string[](partidos.length);
        uint[] memory _nroVotos = new uint[](partidos.length);

        for (uint i=0; i< partidos.length; i++){
            _ids[i] = partidos[i].id;
            _siglas[i] = partidos[i].sigla;
            _candidatos[i] = partidos[i].candidato;
            _nroVotos[i] = partidos[i].nroVotos;
        }

        return (_ids, _siglas, _candidatos, _nroVotos);
    }


    function ganador() public votacionAbierta view returns (
        Partido memory
    ) {
        uint votos = 0;
        uint id = 0;

        for (uint i=0; i< partidos.length; i++){
           if (partidos[i].nroVotos > votos) {
            votos = partidos[i].nroVotos;
            id = i;
           }
        }
        return partidos[id];
    }
}