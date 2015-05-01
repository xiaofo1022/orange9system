package com.xiaofo1022.orange9.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.dao.OrderGoodsDao;
import com.xiaofo1022.orange9.modal.OrderGoods;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;

@Controller
@RequestMapping("/orderGoods")
@Transactional
public class OrderGoodsController {
	@Autowired
	private OrderGoodsDao orderGoodsDao;
	
	@RequestMapping(value = "/receiveGoods", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse receiveGoods(@ModelAttribute("orderGoods") OrderGoods orderGoods, BindingResult result) {
		orderGoodsDao.insertReceiveOrderGoods(orderGoods);
		orderGoodsDao.setOrderShootGoods(orderGoods);
		return new SuccessResponse("Receive Goods Success");
	}
	
	@RequestMapping(value = "/deliverGoods", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse deliverGoods(@ModelAttribute("orderGoods") OrderGoods orderGoods, BindingResult result) {
		orderGoodsDao.insertDeliverOrderGoods(orderGoods);
		return new SuccessResponse("Deliver Goods Success");
	}
	
	@RequestMapping(value = "/updateShootGoods", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse updateShootGoods(@ModelAttribute("orderGoods") OrderGoods orderGoods, BindingResult result) {
		orderGoodsDao.updateOrderShootGoods(orderGoods);
		return new SuccessResponse("Update Shoot Goods Success");
	}
	
	@RequestMapping(value = "/addShootGoods", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse addShootGoods(@ModelAttribute("orderGoods") OrderGoods orderGoods, BindingResult result) {
		orderGoodsDao.addOrderShootGoods(orderGoods);
		return new SuccessResponse("Add Shoot Goods Success");
	}
}
