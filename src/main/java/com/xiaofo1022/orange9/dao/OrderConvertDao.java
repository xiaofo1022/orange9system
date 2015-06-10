package com.xiaofo1022.orange9.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.common.OrderStatusConst;
import com.xiaofo1022.orange9.controller.PictureController;
import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Order;
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
	
	public OrderConvertImage getOrderConvert(int orderId) {
		return commonDao.getFirst(OrderConvertImage.class, "SELECT * FROM ORDER_CONVERT_IMAGE WHERE ORDER_ID = ? AND IS_DONE = 0", orderId);
	}
	
	public List<OrderConvertImage> getOrderConvertList(HttpServletRequest request) {
		List<OrderConvertImage> resultList = null;
		List<Order> orderList = commonDao.query(Order.class, "SELECT * FROM ORDERS WHERE STATUS_ID = ?", OrderStatusConst.CONVERT_IMAGE);
		if (orderList != null && orderList.size() > 0) {
			resultList = new ArrayList<OrderConvertImage>(orderList.size());
			for (Order order : orderList) {
				OrderConvertImage orderConvert = this.getOrderConvert(order.getId());
				if (orderConvert == null) {
					orderConvert = new OrderConvertImage();
					orderConvert.setOrderId(order.getId());
				} else {
					orderConvert.setFileNames(pictureController.getUnuploadOriginalPictureName(order.getId(), request));
				}
				resultList.add(orderConvert);
			}
		}
		return resultList;
	}
	
	public void setOrderConvertDone(int convertId) {
		commonDao.update("UPDATE ORDER_CONVERT_IMAGE SET IS_DONE = 1 AND UPDATE_DATETIME = ? WHERE ID = ?", new Date(), convertId);
	}
}
