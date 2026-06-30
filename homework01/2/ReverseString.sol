// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract ReverseString {
    function reverseString(
        string memory str
    ) public pure returns (string memory) {
        string memory temp;
        bytes memory strBytes = bytes(str);
        for (uint i = 0; i < strBytes.length; i++) {
            temp = string(
                abi.encodePacked(temp, strBytes[strBytes.length - 1 - i])
            );
        }
        return temp;
    }

    function reverseString2(
        string memory str
    ) public pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory temp = new bytes(strBytes.length);
        for (uint i = 0; i < strBytes.length; i++) {
            temp[i] = strBytes[strBytes.length - 1 - i];
        }
        return string(temp);
    }
}
