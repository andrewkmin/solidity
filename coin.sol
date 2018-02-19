pragma solidity ^0.4.0;

contract Coin {

   address public minter;
   mapping (address => uint) public balances;


   // This is the constructor whose code is
   // run only when the contract is created.
   function Coin() public {
      minter = msg.sender;
   }

   modifier goodAmount (uint _amount) {
      require (_amount > 0);
      _;
   }

   // only let the minter create new coins
   function mint(address receiver, uint amount) public goodAmount(_amount) {
      require(msg.sender == minter);
      balances[receiver] += amount;
   }

   // allow anyone with coins to send the coins to someone else
   function send(address receiver, uint amount) public goodAmount(_amount) {
      require(balances[msg.sender] > 0 && balances[msg.sender] >= amount);
      balances[msg.sender] -= amount;
      balances[receiver] += amount;
   }
}