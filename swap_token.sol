// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/IERC20.sol";

contract SWAP_TOKEN 
{
    IERC20 public tokenA;
    address public ownerA;
    uint public amountA;
    IERC20 public tokenB;
    address public ownerB;

    constructor(address _tokenA,address _ownerA,uint _amountA,address _tokenB,address _ownerB) 
    {
        tokenA = IERC20(_tokenA);
        ownerA = _ownerA;
        amountA = _amountA;
        tokenB = IERC20(_tokenB);
        ownerB = _ownerB;
    }

    function SWAP() public {
        require(msg.sender == ownerA, "You do not have permission to call this function");
        require(tokenA.allowance(ownerA, address(this)) >= amountA,"you cannot transfer tokens more than your approved limit");
        require(tokenB.allowance(ownerB, address(this)) >= amountA*4,"you cannot transfer tokens more than your approved limit");
       token_TransferFrom(tokenA, ownerA, ownerB, amountA);
        token_TransferFrom(tokenB, ownerB, ownerA, amountA*4);
    }

    function token_TransferFrom(IERC20 token,address _from,address _to,uint _value) private {
        bool sent = token.transferFrom(_from, _to, _value);
        require(sent, "Token transfer failed");
    }

}
