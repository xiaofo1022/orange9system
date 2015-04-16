package com.xiaofo1022.orange9.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.OrderTransferImage;
import com.xiaofo1022.orange9.modal.OrderTransferImageData;

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
	
	public OrderTransferImage getOrderTransferById(int orderTransferId) {
		return commonDao.getFirst(OrderTransferImage.class, "SELECT * FROM ORDER_TRANSFER_IMAGE WHERE ID = ?", orderTransferId);
	}
	
	public List<OrderTransferImage> getOrderTransferImageList() {
		return commonDao.query(OrderTransferImage.class, "SELECT * FROM ORDER_TRANSFER_IMAGE WHERE IS_DONE = 0 ORDER BY INSERT_DATETIME DESC");
	}
	
	public void insertOrderTransferImageData(OrderTransferImageData transferImageData) {
		int id = commonDao.insert("INSERT INTO ORDER_TRANSFER_IMAGE_DATA (ORDER_TRANSFER_IMAGE_ID, INSERT_DATETIME) VALUES (?, ?)",
				transferImageData.getOrderTransferImageId(), new Date());
		transferImageData.setId(id);
		OrderTransferImage orderTransferImage = this.getOrderTransferById(transferImageData.getOrderTransferImageId());
		if (orderTransferImage != null) {
			transferImageData.setOrderId(orderTransferImage.getOrderId());
		}
	}
}
