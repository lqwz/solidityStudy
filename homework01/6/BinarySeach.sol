// SPDX-License-Identifier: MIT
//二分查找 (Binary Search) 在一个有序数组中查找目标值。
pragma solidity ^0.8.24;

contract BinarySearch {
    function search(
        uint256[] memory arr,
        uint256 target
    ) public pure returns (uint256) {
        uint256 left = 0;
        uint256 right = arr.length; // 右边界设为长度，表示开区间 [left, right)

        while (left < right) {
            // 防止溢出的中位数计算
            uint256 mid = left + (right - left) / 2;

            if (arr[mid] == target) {
                return mid;
            } else if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return type(uint256).max; // 表示未找到
    }
}
