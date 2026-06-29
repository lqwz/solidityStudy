// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;
//ai生成的
contract WithdrawContract {
    // 记录谁存了多少钱（可选，用于权限控制或记账）
    mapping(address => uint256) public balances;

    // 存款函数：允许用户向合约发送 ETH
    function deposit() public payable {
        require(msg.value > 0, "Must send some ETH");
        balances[msg.sender] += msg.value;
    }

    /**
     * @notice 提现函数：将合约中属于调用者的余额提取到调用者账户
     */
    function withdraw() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance to withdraw");

        // 先更新状态，再执行转账（遵循 Checks-Effects-Interactions 模式，防止重入攻击）
        balances[msg.sender] = 0;

        // 使用 call 进行转账
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Withdrawal failed");
    }
    
    // 允许合约直接接收 ETH
    receive() external payable {}
}
