package com.xiaofo1022.orange9.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.dao.OrderConvertDao;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;

@Controller
@RequestMapping("/orderConvert")
public class OrderConvertController {
	@Autowired
	private OrderConvertDao orderConvertDao;
	
	@RequestMapping(value = "/setOrderConvertor/{orderId}/{userId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setOrderConvertor(
			@PathVariable int orderId, 
			@PathVariable int userId, 
			HttpServletRequest request) {
		orderConvertDao.insertOrderConvert(orderId, userId);
		return new SuccessResponse("Set Order Convertor Success");
	}
}
