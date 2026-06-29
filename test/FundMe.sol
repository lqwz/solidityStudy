// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;
/*
1. 创建一个收款函数
2. 记录投资人并查看
3. 在锁定期内，达到目标值，生产商可以提款
4. 在锁定期内，未达到目标值，投资人在锁定期结束后可以退款
*/
contract FundMe {
    mapping(address => uint256) public funderToAmount;
    uint256 constant MINMUM_VALUE = 1 * 10 ** 18; //wei
    uint256 constant TARGET_VALUE = 10 * 10 ** 18; //wei

    address public owner;
    address public fundTokenAddr;
    uint256 deployTime;
    uint256 lockTime; //锁定期 单位 秒

    bool public fundSuccess = false;

    constructor(uint256 _lockTime) {
        owner = msg.sender;
        deployTime = block.timestamp;
        lockTime = _lockTime;
    }
    //收款
    function fund() external payable {
        require(block.timestamp < deployTime + lockTime, "Window Closed");
        require(msg.value >= MINMUM_VALUE, "SEND MORE ETH");
        funderToAmount[msg.sender] += msg.value;
    }
    //提款
    function getfund() external windowClosed {
        require(address(this).balance >= TARGET_VALUE, "Target is not reached");
        require(msg.sender == owner, "Only owner can call this function");
        // 以下这两种写法过时了 编译都过不了
        // payable(msg.sender).transfer(address(this).balance);
        // bool success = payable(msg.sender).send(address(this).balance);
        bool success;
        (success, ) = payable(msg.sender).call{value: address(this).balance}(
            ""
        );

        require(success, "tx failed");
        fundSuccess = true;
    }
    //退款
    function refund() external windowClosed {
        require(address(this).balance < TARGET_VALUE, "Target is  reached");
        require(funderToAmount[msg.sender] != 0, "No fund for you");

        funderToAmount[msg.sender] = 0;

        bool success;
        (success, ) = payable(msg.sender).call{
            value: funderToAmount[msg.sender]
        }("");

        require(success, "tx failed");
    }

    //变更所有人
    function transferOwnership(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    modifier windowClosed() {
        require(block.timestamp >= deployTime + lockTime, "Window not Closed");
        _;
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    // 设置FundToken合约的地址，方便后面权限验证
    function setFundTokenAddr(address _fundTokenAddr) external onlyOwner {
        fundTokenAddr = _fundTokenAddr;
    }

    //给FundToken合约使用，用于更新余额
    function setFunderToAmount(uint256 _amount) external {
        require(msg.sender == fundTokenAddr, unicode"你没有足够的权限");
        funderToAmount[msg.sender] = _amount;
    }
}
