// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

contract HelloWord {
    //基础数据类型
    bool boolVar_1 = false;
    bool boolVar_2 = true;

    uint256 uintVar = 1;
    int256 intVar = -1;

    bytes23 bytesVar = "Hello world";
    string stringVar = "Hello word";

    address addressVar = 0x3465b9ED06fd366C23481404601d4dA1B4b679B5;

    //方法 只读
    function sayHello() public view returns (string memory) {
        return stringVar;
    }
    //方法 写
    function setHello(string memory newStr) public {
        stringVar = newStr;
    }
    //方法 只计算
    function addInfo(string memory str) internal pure returns (string memory) {
        // return string.concat(unicode"中文", str);
        return string.concat("Hello", str);
        // return string(abi.encodePacked("123",str));
    }

    //方法 调用内部函数
    function sayHelloAddInfo() public view returns (string memory) {
        return addInfo(stringVar);
    }
}
