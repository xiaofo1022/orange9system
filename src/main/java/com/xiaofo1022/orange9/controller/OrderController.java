package com.xiaofo1022.orange9.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.dao.OrderDao;
import com.xiaofo1022.orange9.modal.Order;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;

@Controller
@RequestMapping("/order")
public class OrderController {
	@Autowired
	private OrderDao orderDao;
	
	@RequestMapping(value = "/addOrder", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse addOrder(@ModelAttribute("order") Order order, BindingResult bindingResult) {
		orderDao.insertOrder(order);
		return new SuccessResponse("Add Order Success");
	}
}
