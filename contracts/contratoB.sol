// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

//ESTE CONTRATO PERMITE INVERTIR CUALQUIER CANTIDAD TANTO EN #ETHER COMO #WEI

contract actions {
    /*---Definimo,s variables*/
    address payable public owner;
    uint256 boveda;
    uint256 limite = 2 ether;

    /*---Definimeos la estructura para la data---*/
    struct DataInvest {
        string name;
        string wallet;
        uint256 inversion;
    }

    /*---Mapeamos la información---*/
    mapping (address => DataInvest) private User;

    /*Agremamos el modifier para verificar el limite sea respetado */
    modifier Comporbar (){
        if (boveda + msg.value == limite ){
            revert();
        }
        else{
            _;
        }
    }

    /*Modificador que establece el uso unico del Owner*/
    modifier Admin (address _owner) {
        require ( owner ==  msg.sender );
        _;
    }


    function Dataestable () public payable {
       // owner == msg.sender;
        boveda == msg.value;
    }

    function EstadoAlmacen () public view returns (uint256) {
        return boveda;
    }

    function Invertir (string memory name, string memory wallet, uint inversion) external payable{
        boveda += msg.value;
        //condicion
       /* if (boveda >= limite){
            // se realiza la transferencia
            retiro();
        }*/
        /*solicitamos data*/
        DataInvest storage user = User [msg.sender];
        user.name = name;
       user.wallet = wallet;
       user.inversion = inversion;
    }

    /****Obtener los datos de los inversores*/
     function getUser (address addr ) external view returns (string memory, string memory, uint){
        DataInvest memory user = User[addr];
        return (user.name, user.wallet, user.inversion); 
    }

    /*---Retiro de fondos---*/
    function retiro () private {
        owner.transfer(boveda);
    }

    function transferMoney (uint amount, address payable _to) public {
        require(address(this).balance >= amount);
        require(_to != address(0));
        _to.transfer(amount);
    }

    /*---Relacionar data con total---*/



   








    
}
    