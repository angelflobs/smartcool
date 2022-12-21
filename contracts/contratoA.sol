// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

//ESTE CONTRATO SOLO PERMITE INVERTIR SOLO CON ETHER

contract actions  {
    
    // alamacenamos la dirección del cliente 
    //relacionado a su user name y su wallet

    address payable public owner ;
    uint almacen; //variable donde guardamos fondos
    uint tope = 3 ether; //variable donde definimos el maximo

    

   

    struct User {
        string name;
        string wallet;
        uint256 donation;
    }

    // Este modifier evita que reciba más fondos
    modifier Comprobar {
        if (almacen + msg.value >= tope ){
            revert();
        }
        else{
            _;
        }
    }

   

    //generamos las variables relacionadas a los nombres
    mapping (address => User) private users;
    mapping (address => bool) private InversorRegister; // funcion de seguridad 1 No permitir que se vuelva usar el mismo nombre y dirección
    address[] total;
    
    function Dataestable () public payable {
        owner == msg.sender;
        almacen == msg.value;
    }

    // Esta funcion solicita colocar su username y una dirección wallet para poder invertir
    function Invertir (string memory name, string memory wallet, uint donation) external payable {
      // (!InversorRegister[msg.sender]); //Nos permite limitar que el usuario no use la misma dirección y wallet*/
        require (msg.value >= 1 ether, "necesitas enviar al menos un ether");
        User storage user = users [msg.sender];
       user.name = name;
       user.wallet = wallet;
       user.donation = donation;
       InversorRegister[msg.sender]= true;
       total.push(msg.sender);

    }

    

    //Esta funcions nos permite tener la data del inversor
    function getUser (address addr ) external view returns (string memory, string memory, uint){
        //require (InversorRegister[msg.sender]); // Nos permite que si el usuario no esta registrado se registre
        User memory user = users[addr];
        return (user.name, user.wallet, user.donation); 
    }

    // esta funcion es de caracter privado 
    // solo evita que se vuelva a usar la misma dirección 
     function InvRegister (address addr) private view returns (bool){
         return InversorRegister [addr];
     }
    //consultar fondos

     function Balancewei () public view returns ( uint ) {
        return address (this).balance;
    }

    function BalanceInEther () public view returns (uint){
        return Balancewei () /1e18;
    }

    //liberar fondos agregando una dirección y el monto reunido 
    function transferMoney (uint amount, address payable _to) public {
        require(address(this).balance >= amount);
        require(_to != address(0));
        _to.transfer(amount);
    }

    //Estado de almacen
    function EstadoAlmacen () public view returns ( uint){
        return almacen;
    }


    
   




}
