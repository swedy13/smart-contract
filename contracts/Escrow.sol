// SPDX-License-Identifier: MIT

pragma solidity ^0.7.3;

contract Escrow {
    
    struct EscrowInfo {
        address payable sender;
        address payable receiver;
        address approver;
        uint256 amount;
    }
    
    EscrowInfo[] escrowInfoList;
    
    /**
     * @notice Deposit a escrow
     * @param _receiver: Receiver address that will receive the tokens
     * @param _approver: Approver address that will approve the transfer
     * @dev Callable by users to create their own escrow.
     */
    function deposit(address payable _receiver, address _approver) external payable {
        require(msg.value > 0);
        require(msg.sender != _receiver);
        
        require(_approver != msg.sender);
        require(_approver != _receiver);
        
        EscrowInfo memory escrowinfo;
        escrowinfo.sender = payable(msg.sender);
        escrowinfo.receiver = _receiver;
        escrowinfo.approver = _approver;
        escrowinfo.amount = msg.value;
        
        escrowInfoList.push(escrowinfo);
    }

    /**
     * @notice Transfer the token to receiver of a escrow
     * @param orderId: order id of a escrow
     * @dev Callable by approver of a escrow.
     */
    function approve(uint orderId) external {
        require(msg.sender == escrowInfoList[orderId].approver);
        
        escrowInfoList[orderId].receiver.transfer(escrowInfoList[orderId].amount);
    }
    
    function refund(uint orderId) external {
    }
}