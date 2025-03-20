// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract GiftCard {
    mapping(address => uint256) public giftCardBalances;

    // Simple function to allow the contract owner to mint tokens to a user's gift card balance
    function mintGiftCard(address recipient, uint256 amount) public {
        giftCardBalances[recipient] += amount;
    }

    // Redeem the gift card for a specific ERC20 digital asset
    function redeemGiftCard(address tokenAddress, uint256 amount) public {
        require(giftCardBalances[msg.sender] >= amount, "Insufficient gift card balance");
        
        // Interact with the ERC20 token contract to transfer the token to the user
        IERC20 token = IERC20(tokenAddress);
        require(token.transfer(msg.sender, amount), "Token transfer failed");
        
        // Deduct the redeemed amount from the gift card balance
        giftCardBalances[msg.sender] -= amount;
    }

    // Check the gift card balance for the sender
    function checkBalance() public view returns (uint256) {
        return giftCardBalances[msg.sender];
    }
}
