package com.xiaofo1022.orange9.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.OrderStatus;
import com.xiaofo1022.orange9.modal.OrderStatusCount;

@Repository
public class OrderStatusDao {
	@Autowired
	private CommonDao commonDao;
	
	public List<OrderStatus> getOrderStatusList() {
		return commonDao.query(OrderStatus.class, "SELECT * FROM ORDER_STATUS ORDER BY ID");
	}
	
	public OrderStatus getOrderStatus(int statusId) {
		return commonDao.getFirst(OrderStatus.class, "SELECT * FROM ORDER_STATUS WHERE ID = ?", statusId);
	}
	
	public Map<String, Integer> getOrderStatusCountMap() {
		List<OrderStatus> orderStatusList = this.getOrderStatusList();
		Map<String, Integer> statusCountMap = new HashMap<String, Integer>();
		for (OrderStatus orderStatus : orderStatusList) {
			OrderStatusCount orderStatusCount = this.getOrderStatusCount(orderStatus.getId());
			statusCountMap.put(orderStatus.getName(), orderStatusCount == null ? 0 : orderStatusCount.getStatusCount());
		}
		return statusCountMap;
	}
	
	public OrderStatusCount getOrderStatusCount(int statusId) {
		return commonDao.getFirst(OrderStatusCount.class, "SELECT COUNT(ID) AS STATUS_COUNT FROM ORDERS WHERE STATUS_ID = ?", statusId);
	}
}
