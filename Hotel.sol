// SPDX-Lisence-Identifier: MIT
import "./Mytoken.sol";
import "hardhat/console.sol";
pragma solidity ^0.8.13;
contract Hotel is MyToken{
    uint public counter;
    enum Statuses {
        Vacant,
        Occupied
    }
    Statuses[5] public rooms = [Statuses.Vacant];
    event Occupy(address _occuoant, uint _value);
    Statuses currentStatus;
    constructor(string memory name, string memory symbol, uint256 initialSupply,uint256 _cap) MyToken(name,symbol,initialSupply,_cap){
        currentStatus = Statuses.Vacant;
    }

    modifier costs(uint _amount) {
        require(msg.value == _amount, "Invalid Money."); _;
    }

    modifier MaxRooms {
        require(counter < 5,"Not Room."); _;
    }


    uint accountBalance = address(this).balance;
    receive() external payable costs(0.0001 ether) MaxRooms{ //receive : calldata없이 msg를 받을 때 동작하는 함수 (message ether)
        console.log(msg.value);
        rooms[counter++] = Statuses.Occupied;
        _mint(msg.sender,2*10**uint(decimals()));
        emit Occupy(msg.sender, msg.value);
    }
    function withdraw() public payable onlyOwner{
       _transfer(address(this),msg.sender, accountBalance);
    }
}
