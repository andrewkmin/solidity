pragma solidity ^0.4.0;

contract Parking {

   address public admin;
   mapping (address => uint) public balances;
   mapping (address => uint) public startTimes;
   uint public currentRate;

   function Parking() public {
      admin = msg.sender;
   }

   // create events to publicize (notifications)

   // how do we ensure that people don't overstay
   // the amount that they've deposited?
   function deposit(uint amount) public payable {
      balances[msg.sender] += amount;
   }

   function start() {
      startTimes[msg.sender] = now;
   }

   function end() {
      uint duration = now - startTimes[msg.sender];
      uint cost = duration * currentRate;

      require(cost <= balances[msg.sender]);
      // maybe call a different function if this is not true

      balances[msg.sender] -= cost;
      delete startTimes[msg.sender];
   }

   function withdraw(uint amount) {
      require(amount <= balances[msg.sender]);
      balances[msg.sender] -= amount;
      msg.sender.transfer(amount);
   }

   function setRate(uint rate) {
      require(admin == msg.sender);
      currentRate = rate;
   }
}