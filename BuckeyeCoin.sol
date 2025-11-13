// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
/// @custom:dev-run-script
/**
 * @title BuckeyeCoin (BUCK)
 * 
 */
contract BuckeyeCoin {
    // Basic token information
    string public name = "BuckeyeCoin";
    string public symbol = "BUCK";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    // Mappings to store balances and allowances
    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;

    // Events to log actions on the blockchain
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // Constructor to set the initial supply and assign to deployer
    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply * (10 ** uint256(decimals));
        balances[msg.sender] = totalSupply;
        emit Mint(msg.sender, totalSupply);
    }

    // View function to get balance of an address
    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    // Basic transfer function
    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(recipient != address(0), "Invalid address");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // Approve another account to spend tokens on your behalf
    function approve(address spender, uint256 amount) public returns (bool) {
        allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // Check the remaining allowance for a spender
    function allowance(address owner, address spender) public view returns (uint256) {
        return allowances[owner][spender];
    }

    // Transfer tokens on behalf of another user
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        require(sender != address(0) && recipient != address(0), "Invalid address");
        require(balances[sender] >= amount, "Insufficient balance");
        require(allowances[sender][msg.sender] >= amount, "Allowance exceeded");

        balances[sender] -= amount;
        balances[recipient] += amount;
        allowances[sender][msg.sender] -= amount;

        emit Transfer(sender, recipient, amount);
        return true;
    }

}
