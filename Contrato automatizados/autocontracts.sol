// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
pragma experimental ABIEncoderV2;

contract invertion {
    // variables requeridas 
   // address payable public owner;
    uint owner;
    uint banco;
    uint tope = 2 ether;

    //INTEGRAMOS LOS MAPAS QUE SEAN REQUERIDOS
    mapping (address => data ) InfoInvest;
 



    // ESTA ESTRUCTURA NOS AYUDA PARA TENER LA DATA DE IUN INVERSOR
    struct data {
        string name;
        string wallet;
        uint deposit;
    }

    //ACEPTAR PAGOS EN ETHER
    function Invertir (string memory _name, string memory _wallet, uint _deposit) public payable {
        require (msg.value >= 1 ether, "necesitas enviar al menos un ether");
        data memory Ourdata;
        Ourdata = data (_name, _wallet , _deposit);
        InfoInvest[msg.sender] = Ourdata;


    }

    function ViewData () public view returns (data) {
        return InfoInvest[msg.sender];
    }


}