package com.xiaofo1022.orange9.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.OrderFixedImageData;
import com.xiaofo1022.orange9.modal.OrderVerifyImage;

@Repository
public class OrderVerifyDao {
	@Autowired
	private CommonDao commonDao;
	
	public OrderVerifyImage getOrderVerifyImage(int orderId) {
		return commonDao.getFirst(OrderVerifyImage.class, "SELECT * FROM ORDER_VERIFY_IMAGE WHERE ORDER_ID = ?", orderId);
	}
	
	public List<OrderFixedImageData> getVerifyImageList(int orderId) {
		return commonDao.query(OrderFixedImageData.class, "SELECT * FROM ORDER_FIXED_IMAGE_DATA WHERE ORDER_ID = ? ORDER BY ID", orderId);
	}
	
	public void insertOrderVerifyImage(int orderId, int userId) {
		Date now = new Date();
		commonDao.insert("INSERT INTO ORDER_VERIFY_IMAGE (ORDER_ID, INSERT_DATETIME, UPDATE_DATETIME, OPERATOR_ID) VALUES (?, ?, ?, ?)",
				orderId, now, now, userId);
	}
	
	public void setImageVerified(int fixedImageId) {
		commonDao.update("UPDATE ORDER_FIXED_IMAGE_DATA SET IS_VERIFIED = 1, UPDATE_DATETIME = ? WHERE ID = ?", new Date(), fixedImageId);
	}
	
	public void setImageDenied(int fixedImageId, String reason) {
		commonDao.update("UPDATE ORDER_FIXED_IMAGE_DATA SET REASON = ?, UPDATE_DATETIME = ? WHERE ID = ?", reason, new Date(), fixedImageId);
	}
	
	public void setVerifyDone(int orderId) {
		commonDao.update("UPDATE ORDER_VERIFY_IMAGE SET IS_DONE = 1, UPDATE_DATETIME = ? WHERE ORDER_ID = ?", new Date(), orderId);
	}
}
