// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

//Este contrato unicamente nos permite controlar quien es el dueño de smartcontract.
//activa la funcion superadmin

contract Ownable {

    address payable public owner;

    constructor ()  {
        owner == msg.sender;
    }

    modifier isOwner (address _owner) {
        require ( owner ==  msg.sender );
        _;
    }


}