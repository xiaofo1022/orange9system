package com.xiaofo1022.orange9.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Order;

@Repository
@Transactional
public class OrderDao {
	@Autowired
	private CommonDao commonDao;
	
	public void insertOrder(Order order) {
		Date now = new Date();
		int id = commonDao.insert("INSERT INTO ORDERS (INSERT_DATETIME, UPDATE_DATETIME, SHOOT_DATE, CLIENT_ID, MODEL_NAME, BROKER_NAME, BROKER_PHONE, SHOOT_HALF, DRESSER_NAME, STYLIST_NAME, PHOTOGRAPHER_ID, ASSISTANT_ID, STATUS_ID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
				now, now, order.getShootDate(), order.getClientId(), order.getModelName(), order.getBrokerName(), order.getBrokerPhone(), order.getShootHalf(), order.getDresserName(), order.getStylistName(), order.getPhotographerId(), order.getAssistantId(), 0);
		order.setId(id);
		addOrderHistory(order, "创建");
	}
	
	public void addOrderHistory(Order order, String info) {
		Date now = new Date();
		commonDao.insert("INSERT INTO ORDER_HISTORY (INSERT_DATETIME, UPDATE_DATETIME, ORDER_ID, OPERATOR_ID, INFO) VALUES (?, ?, ?, ?, ?)",
				now, now, order.getId(), order.getUserId(), info);
	}
	
	public List<Order> getOrderList() {
		return commonDao.query(Order.class, "SELECT * FROM ORDERS WHERE ACTIVE = 1 ORDER BY SHOOT_DATE, SHOOT_HALF");
	}
}
