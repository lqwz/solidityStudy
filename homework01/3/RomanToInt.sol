// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract RomanToInt {
    mapping(bytes1 => uint256) public symbol;

    constructor() {
        symbol["I"] = 1;
        symbol["V"] = 5;
        symbol["X"] = 10;
        symbol["L"] = 50;
        symbol["C"] = 100;
        symbol["D"] = 500;
        symbol["M"] = 1000;
    }
    function romantoInt(string memory str) public view returns (uint256) {
        uint256 result = 1; //初始化为1 为了IX 上来就要减去1 不然就报错
        bytes memory strbytes = bytes(str);
        uint len = strbytes.length;
        for (uint i = 0; i < len; i++) {
            if (i < len - 1 && symbol[strbytes[i]] < symbol[strbytes[i + 1]]) {
                result -= symbol[strbytes[i]];
            } else {
                result += symbol[strbytes[i]];
            }
        }
        return result - 1; //最会减去初始化的1
    }
}
