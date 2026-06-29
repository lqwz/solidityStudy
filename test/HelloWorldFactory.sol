// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;
import {HelloWorld} from "./test.sol";
// 1.直接引入同一个文件系统下的合约
// 2.引入github上的合约
// 3.通过包引用

contract HelloWorldFactory {
    //HelloWorld hw;
    HelloWorld[] hws;

    //生产合约
    function createHelloWorld() public {
        HelloWorld hw = new HelloWorld();
        hws.push(hw);
    }

    //调用合约读取方法
    function callHelloWorldSayHello(
        uint256 _index
    ) public view returns (string memory) {
        return hws[_index].sayHello();
    }
    //调用合约写入方法
    function callHelloWorldSetHello(
        uint256 _index,
        string calldata newStr
    ) public {
        hws[_index].setHello(newStr);
    }
}
