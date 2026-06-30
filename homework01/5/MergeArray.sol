// SPDX-License-Identifier: MIT
//将两个有序数组合并为一个有序数组
pragma solidity ^0.8.24;

contract MergeArray {
    function processArray(
        uint[] memory dataA,
        uint[] memory dataB
    ) public pure returns (uint[] memory) {
        uint lenA = dataA.length;
        uint lenB = dataB.length;
        uint256[] memory result = new uint256[](lenA + lenB);
        // 处理逻辑
        uint256 a = 0;
        uint256 b = 0;
        uint256 c = 0;
        for (;;) {
            if (a == lenA && b != lenB) {
                result[c] = dataB[b];
                b++;
            } else if (a != lenA && b == lenB) {
                result[c] = dataA[a];
                a++;
            } else if (dataA[a] < dataB[b]) {
                result[c] = dataA[a];
                a++;
            } else {
                result[c] = dataB[b];
                b++;
            }
            c++;
            if (a == lenA && b == lenB) {
                break;
            }
        }
        return result;
    }

    //双指针归并算法
    function processArray2(
        uint[] memory dataA,
        uint[] memory dataB
    ) public pure returns (uint[] memory) {
        uint lenA = dataA.length;
        uint lenB = dataB.length;
        uint256[] memory result = new uint256[](lenA + lenB);
        // 处理逻辑
        uint256 a = 0;
        uint256 b = 0;
        uint256 c = 0;
        while (a < lenA && b < lenB) {
            if (dataA[a] < dataB[b]) {
                result[c] = dataA[a];
                a++;
            } else {
                result[c] = dataB[b];
                b++;
            }
            c++;
        }
        while (a < lenA) {
            result[c] = dataA[a];
            a++;

            c++;
        }
        while (b < lenB) {
            result[c] = dataB[b];
            b++;

            c++;
        }
        return result;
    }
}
