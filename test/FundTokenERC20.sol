// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {FundMe} from "./FundMe.sol";

//1 让FundMe的参与者，基于mapping来领取相应数量的通证
//2 让fundMe的参与者，transfer 通证
//3 在使用完成后，burn通证
contract FundTokenERC20 is ERC20 {
    FundMe fundme;
    constructor(address fundMeAddr) ERC20("FundToken", "FT") {
        fundme = FundMe(fundMeAddr);// 这里，使用地址初始化其他合约的对象
    }

    //1铸造  注意：这个参数的单位是wei
    function mint(uint256 amountToMint) public { 
        require(
            fundme.funderToAmount(msg.sender) >= amountToMint, //注意： 这里调用mapping 使用的是小括号
            "not enough"
        ); 

        require(fundme.fundSuccess(), "not fund success yet"); //注意： 这里调用获取变量值 使用的是小括号

        //铸造
        _mint(msg.sender, amountToMint);

        //更新余额，减去消耗的Amount
        fundme.setFunderToAmount(
            fundme.funderToAmount(msg.sender) - amountToMint
        );
    }

    //2交换  方法ERC20 已经实现 _transfer(from, to, value); 直接继承

    //3使用
    function claim(uint256 amountToClaim) public {
        //complete claim
        require(balanceOf(msg.sender) > amountToClaim, "not enough");
        require(fundme.fundSuccess(), "not fund success yet");

        //兑换奖励 略

        //burn
        _burn(msg.sender, amountToClaim);
    }
}
