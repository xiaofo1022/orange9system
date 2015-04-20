package com.xiaofo1022.orange9.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.xiaofo1022.orange9.common.OrderStatusConst;
import com.xiaofo1022.orange9.common.StatusConst;
import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Order;
import com.xiaofo1022.orange9.modal.OrderStatus;

@Repository
@Transactional
public class OrderDao {
	@Autowired
	private CommonDao commonDao;
	@Autowired
	private OrderHistoryDao orderHistoryDao;
	@Autowired
	private OrderStatusDao orderStatusDao;
	
	public void insertOrder(Order order) {
		Date now = new Date();
		int id = commonDao.insert("INSERT INTO ORDERS (INSERT_DATETIME, UPDATE_DATETIME, SHOOT_DATE, CLIENT_ID, MODEL_NAME, BROKER_NAME, BROKER_PHONE, SHOOT_HALF, DRESSER_NAME, STYLIST_NAME, PHOTOGRAPHER_ID, ASSISTANT_ID, STATUS_ID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
				now, now, order.getShootDate(), order.getClientId(), order.getModelName(), order.getBrokerName(), order.getBrokerPhone(), order.getShootHalf(), order.getDresserName(), order.getStylistName(), order.getPhotographerId(), order.getAssistantId(), StatusConst.SHOOTING);
		order.setId(id);
		orderHistoryDao.addOrderHistory(order, OrderStatusConst.CREATE_ORDER);
	}
	
	public List<Order> getOrderList() {
		return commonDao.query(Order.class, "SELECT * FROM ORDERS WHERE ACTIVE = 1 ORDER BY SHOOT_DATE, SHOOT_HALF");
	}
	
	public Order getOrderDetail(int orderId) {
		return commonDao.getFirst(Order.class, "SELECT * FROM ORDERS WHERE ID = ? AND ACTIVE = 1", orderId);
	}
	
	public void updateOrderStatus(Order order, OrderStatus orderStatus) {
		commonDao.update("UPDATE ORDERS SET STATUS_ID = ?, UPDATE_DATETIME = ? WHERE ID = ?", orderStatus.getId(), new Date(), order.getId());
		orderHistoryDao.addOrderHistory(order, OrderStatusConst.STATUS_CHANGE + orderStatus.getName());
	}
	
	public List<Order> getOrderListByStatus(int statusId) {
		return commonDao.query(Order.class, "SELECT * FROM ORDERS WHERE ACTIVE = 1 AND STATUS_ID = ? ORDER BY SHOOT_DATE, SHOOT_HALF", statusId);
	}
}
