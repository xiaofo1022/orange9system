package com.xiaofo1022.orange9.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.common.OrderConst;
import com.xiaofo1022.orange9.dao.OrderHistoryDao;
import com.xiaofo1022.orange9.dao.OrderPostProductionDao;
import com.xiaofo1022.orange9.modal.OrderPostProduction;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;

@Controller
@RequestMapping("/orderPostProduction")
@Transactional
public class OrderPostProductionController {
	@Autowired
	private OrderPostProductionDao postProductionDao;
	@Autowired
	private OrderHistoryDao orderHistoryDao;
	
	@RequestMapping(value = "/setFixSkinDone/{orderId}/{userId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setFixSkinDone(@PathVariable int orderId, @PathVariable int userId) {
		List<OrderPostProduction> postProductionDoneList = postProductionDao.setPostProductionDone(OrderConst.TABLE_ORDER_FIX_SKIN, orderId, userId);
		postProductionDao.allotPostProduction(OrderConst.TABLE_ORDER_FIX_BACKGROUND, postProductionDoneList);
		orderHistoryDao.addOrderHistory(orderId, OrderConst.FIX_SKIN_DONE_INFO);
		return new SuccessResponse("Set Fix Skin Done Success");
	}
	
	@RequestMapping(value = "/setFixBackgroundDone/{orderId}/{userId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setFixBackgroundDone(@PathVariable int orderId, @PathVariable int userId) {
		List<OrderPostProduction> postProductionDoneList = postProductionDao.setPostProductionDone(OrderConst.TABLE_ORDER_FIX_BACKGROUND, orderId, userId);
		postProductionDao.allotPostProduction(OrderConst.TABLE_ORDER_CUT_LIQUIFY, postProductionDoneList);
		orderHistoryDao.addOrderHistory(orderId, OrderConst.FIX_BACKGROUND_DONE_INFO);
		return new SuccessResponse("Set Fix Background Done Success");
	}
}
