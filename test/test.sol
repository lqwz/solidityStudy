// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

contract HelloWorld {
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
        return string.concat(str, " ---from WEEK");
        // return string(abi.encodePacked("123",str));
    }

    //方法 调用内部函数
    function sayHelloAddInfo() public view returns (string memory) {
        return addInfo(stringVar);
    }
    //结构体
    struct Info {
        string phrase;
        uint256 id;
        address sender;
    }
    //数组
    Info[] public infoList;
    //方法 结构体写入
    function addInfo(string memory phrase, uint256 _id) public {
        Info memory info = Info(phrase, _id, msg.sender);
        infoList.push(info);
    }
    //方法 结构体读取
    function getInfo(uint256 _id) public view returns (string memory) {
        for (uint256 i = 0; i < infoList.length; i++) {
            if (infoList[i].id == _id) {
                return addInfo(infoList[i].phrase);
            }
        }
        return addInfo(stringVar);
    }

    //mapping
    mapping(uint256 => Info) infoMapping;
    //方法 mapping写入
    function addInfoMapping(string memory phrase, uint256 _id) public {
        Info memory info = Info(phrase, _id, msg.sender);
        infoMapping[_id] = info;
    }
    //方法 mapping读取
    function getInfoMapping(uint256 _id) public view returns (string memory) {
        if (infoMapping[_id].sender == address(0x0)) {
            return unicode"没有找到";
        }
        return infoMapping[_id].phrase;
    }
}
