package com.xiaofo1022.orange9.dao;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.controller.PictureController;
import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Count;
import com.xiaofo1022.orange9.modal.OrderConvertImage;

@Repository
public class OrderConvertDao {
	@Autowired
	private CommonDao commonDao;
	@Autowired
	private OrderTransferDao orderTransferDao;
	@Autowired
	private PictureController pictureController;
	
	public void insertOrderConvert(int orderId, int userId) {
		Date now = new Date();
		commonDao.insert("INSERT INTO ORDER_CONVERT_IMAGE (ORDER_ID, INSERT_DATETIME, UPDATE_DATETIME, OPERATOR_ID) VALUES (?, ?, ?, ?)", 
				orderId, now, now, userId);
	}
	
	public boolean isExistConvertRecord(int orderId) {
		Count count = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM ORDER_CONVERT_IMAGE WHERE ORDER_ID = ?", orderId);
		if (count != null && count.getCnt() > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public List<OrderConvertImage> getOrderConvert(int ownerId) {
		return commonDao.query(OrderConvertImage.class, "SELECT A.* FROM ORDER_CONVERT_IMAGE A LEFT JOIN ORDERS B ON A.ORDER_ID = B.ID WHERE A.IS_DONE = 0 AND B.OWNER_ID = ?", ownerId);
	}
	
	public List<OrderConvertImage> getOrderConvertList(HttpServletRequest request, int ownerId) {
		List<OrderConvertImage> orderConvertList = this.getOrderConvert(ownerId);
		for (OrderConvertImage orderConvert : orderConvertList) {
			orderConvert.setFileNames(pictureController.getUnuploadOriginalPictureName(orderConvert.getOrderId(), request));
		}
		return orderConvertList;
	}
	
	public void setOrderConvertDone(int convertId) {
		commonDao.update("UPDATE ORDER_CONVERT_IMAGE SET IS_DONE = 1, UPDATE_DATETIME = ? WHERE ID = ?", new Date(), convertId);
	}
}
