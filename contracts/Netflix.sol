// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Netflix {
    address public owner;
    address public netflixAccount;
    uint256 public subscriptionFee;

    event Subscription(address indexed subscriber, uint256 amount);

    constructor(address _netflixAccount, uint256 _subscriptionFee) {
        owner = msg.sender;
        netflixAccount = _netflixAccount;
        subscriptionFee = _subscriptionFee;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }

    function setSubscriptionFee(uint256 _newFee) public onlyOwner {
        subscriptionFee = _newFee;
    }

    function subscribe() external payable {
        require(msg.value == subscriptionFee, "Incorrect subscription fee provided");
        (bool success, ) = netflixAccount.call{value: msg.value}("");
        require(success, "Failed to transfer subscription fee to Netflix account");
        emit Subscription(msg.sender, msg.value);
    }

    function withdrawFees(uint256 _amount) external onlyOwner {
        require(_amount <= address(this).balance, "Insufficient contract balance");
        (bool success, ) = owner.call{value: _amount}("");
        require(success, "Failed to withdraw fees");
    }

    receive() external payable {
        // Fallback function to receive ether
    }
}
