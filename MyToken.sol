// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
pragma solidity ^0.8.13;
contract MyToken is Ownable,ERC20Capped {
    constructor(string memory name, string memory symbol, uint256 initialSupply,uint256 _cap) ERC20(name,symbol) ERC20Capped(_cap*10**uint(decimals())){
        _mint(msg.sender,initialSupply*10**uint(decimals()));
    }

    function AdditionallCoinSupply(uint AddTokenSupply) public onlyOwner{
        _mint(msg.sender,AddTokenSupply*10**uint(decimals())); // decimal = 18
    }

    function ToAddCoin(address _to, uint AddToken) public onlyOwner{
        _mint(msg.sender,AddToken*10**uint(decimals()));
        _transfer(msg.sender,_to, AddToken);
    }
}
