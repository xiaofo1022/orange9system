package com.xiaofo1022.orange9.dao;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.OrderTransferImage;

@Repository
public class OrderTransferDao {
	@Autowired
	private CommonDao commonDao;
	
	public void insertOrderTransfer(int orderId, int userId) {
		Date now = new Date();
		commonDao.insert("INSERT INTO ORDER_TRANSFER_IMAGE (ORDER_ID, INSERT_DATETIME, UPDATE_DATETIME, OPERATOR_ID) VALUES (?, ?, ?, ?)", 
				orderId, now, now, userId);
	}
	
	public OrderTransferImage getOrderTransfer(int orderId) {
		return commonDao.getFirst(OrderTransferImage.class, "SELECT * FROM ORDER_TRANSFER_IMAGE WHERE ORDER_ID = ?", orderId);
	}
}
