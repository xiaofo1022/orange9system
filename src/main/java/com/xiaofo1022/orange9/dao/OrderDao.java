package com.xiaofo1022.orange9.dao;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Order;

@Repository
public class OrderDao {
	@Autowired
	private CommonDao commonDao;
	
	public void insertOrder(Order order) {
		Date now = new Date();
		int id = commonDao.insert("INSERT INTO ORDERS (INSERT_DATETIME, UPDATE_DATETIME, SHOOT_DATE, CLIENT_ID, MODEL_NAME, BROKER_NAME, BROKER_PHONE, SHOOT_HALF, DRESSER_NAME, STYLIST_NAME, PHOTOGRAPHER_ID, ASSISTANT_ID, STATUS_ID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
				now, now, order.getShootDate(), order.getClientId(), order.getModelName(), order.getBrokerName(), order.getBrokerPhone(), order.getShootHalf(), order.getDresserName(), order.getStylistName(), order.getPhotographerId(), order.getAssistantId(), 0);
		order.setId(id);
	}
}
