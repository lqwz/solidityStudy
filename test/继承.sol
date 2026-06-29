// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

contract Parent {
    uint256 public a;
    uint256 private b; //private 不能被继承  其他可以 external internal  public
    function addOne() public {
        a++;
    }
}

contract Child is Parent {
    function addTwo() public {
        a += 2;
    }
}
