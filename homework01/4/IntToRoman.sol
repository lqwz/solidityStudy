// SPDX-License-Identifier: MIT
//
pragma solidity ^0.8.24;

contract IntToRoman {
    mapping(string => uint256) public symbolvalue;
    string[13] public keys;
    constructor() {
        symbolvalue["M"] = 1000;
        symbolvalue["CM"] = 900;
        symbolvalue["D"] = 500;
        symbolvalue["CD"] = 400;
        symbolvalue["C"] = 100;
        symbolvalue["XC"] = 90;
        symbolvalue["L"] = 50;
        symbolvalue["XL"] = 40;
        symbolvalue["X"] = 10;
        symbolvalue["IX"] = 9;
        symbolvalue["V"] = 5;
        symbolvalue["IV"] = 4;
        symbolvalue["I"] = 1;
        keys[0] = "M";
        keys[1] = "CM";
        keys[2] = "D";
        keys[3] = "CD";
        keys[4] = "C";
        keys[5] = "XC";
        keys[6] = "L";
        keys[7] = "XL";
        keys[8] = "X";
        keys[9] = "IX";
        keys[10] = "V";
        keys[11] = "IV";
        keys[12] = "I";
    }

    function toRoman(uint256 num) public view returns (string memory) {
        string memory result;
        for (uint i = 0; i < keys.length; i++) {
            uint256 v = symbolvalue[keys[i]];
            uint256 count = num / v;
            uint256 less = num % v;

            if (count > 0) {
                for (uint256 k = 0; k < count; k++) {
                    result = string.concat(result, keys[i]);
                }
                if (less == 0) {
                    break;
                }
                num = less;
            }
        }
        return result;
    }
}
