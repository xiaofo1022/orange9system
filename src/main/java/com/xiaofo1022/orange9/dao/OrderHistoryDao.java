package com.xiaofo1022.orange9.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Order;
import com.xiaofo1022.orange9.modal.OrderHistory;

@Repository
public class OrderHistoryDao {
	@Autowired
	private CommonDao commonDao;
	@Autowired
	private OrderDao orderDao;
	
	public void addOrderHistory(int orderId, int userId, String info) {
		Order order = orderDao.getOrderDetail(orderId);
		if (order != null) {
			order.setUserId(userId);
			this.addOrderHistory(order, info, null);
		}
	}
	
	public void addOrderHistory(Order order, String info, String reason) {
		Date now = new Date();
		commonDao.insert("INSERT INTO ORDER_HISTORY (INSERT_DATETIME, UPDATE_DATETIME, ORDER_ID, OPERATOR_ID, INFO, REMARK) VALUES (?, ?, ?, ?, ?, ?)",
				now, now, order.getId(), order.getUserId(), info, reason);
	}
	
	public List<OrderHistory> getOrderHistoryList(int orderId) {
		return commonDao.query(OrderHistory.class, "SELECT * FROM ORDER_HISTORY WHERE ORDER_ID = ? ORDER BY INSERT_DATETIME DESC", orderId);
	}
}
