package com.xiaofo1022.orange9.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.OrderTimeLimit;

@Repository
public class OrderTimeLimitDao {
	@Autowired
	private CommonDao commonDao;
	
	public OrderTimeLimit getTimeLimit(int limitId) {
		return commonDao.getFirst(OrderTimeLimit.class, "SELECT * FROM ORDER_TIME_LIMIT WHERE ID = ?", limitId);
	}
}
