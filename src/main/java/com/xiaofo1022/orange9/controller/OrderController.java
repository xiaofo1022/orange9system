package com.xiaofo1022.orange9.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.common.OrderStatusConst;
import com.xiaofo1022.orange9.dao.OrderConvertDao;
import com.xiaofo1022.orange9.dao.OrderDao;
import com.xiaofo1022.orange9.dao.OrderHistoryDao;
import com.xiaofo1022.orange9.dao.OrderPostProductionDao;
import com.xiaofo1022.orange9.dao.OrderStatusDao;
import com.xiaofo1022.orange9.dao.OrderTransferDao;
import com.xiaofo1022.orange9.dao.UserDao;
import com.xiaofo1022.orange9.modal.Order;
import com.xiaofo1022.orange9.modal.OrderStatus;
import com.xiaofo1022.orange9.modal.User;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;
import com.xiaofo1022.orange9.util.DatetimeUtil;
import com.xiaofo1022.orange9.util.RequestUtil;

@Controller
@RequestMapping("/order")
@Transactional
public class OrderController {
	@Autowired
	private UserDao userDao;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private OrderStatusDao orderStatusDao;
	@Autowired
	private OrderHistoryDao orderHistoryDao;
	@Autowired
	private OrderTransferDao orderTransferDao;
	@Autowired
	private OrderConvertDao orderConvertDao;
	@Autowired
	private OrderPostProductionDao orderPostProductionDao;
	
	@RequestMapping(value = "/addOrder", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse addOrder(@ModelAttribute("order") Order order, BindingResult bindingResult, HttpServletRequest request) {
		User user = RequestUtil.getLoginUser(request);
		if (user != null) {
			order.setUserId(user.getId());
		}
		orderDao.insertOrder(order);
		return new SuccessResponse("Add Order Success");
	}
	
	@RequestMapping(value = "/getOrderList", method = RequestMethod.GET)
	@ResponseBody
	public List<Order> getOrderList() {
		return orderDao.getOrderList();
	}
	
	@RequestMapping(value = "/getOrderStatusCountMap", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Integer> getOrderStatusCountMap() {
		return orderStatusDao.getOrderStatusCountMap();
	}
	
	@RequestMapping(value="/orderDetail/{orderId}", method=RequestMethod.GET)
	public String orderDetail(@PathVariable int orderId, ModelMap modelMap) {
		Order orderDetail = orderDao.getOrderDetail(orderId);
		if (orderDetail != null) {
			modelMap.addAttribute("orderDetail", orderDetail);
			modelMap.addAttribute("timeCost", DatetimeUtil.getDatetimeDiff(orderDetail.getInsertDatetime(), new Date()));
			modelMap.addAttribute("orderStatusList", orderStatusDao.getOrderStatusList());
			modelMap.addAttribute("orderHistoryList", orderHistoryDao.getOrderHistoryList(orderId));
			modelMap.addAttribute("orderConvert", orderConvertDao.getOrderConvert(orderId));
			modelMap.addAttribute("orderFixSkinList", orderPostProductionDao.getFixSkinGroupListByOrder(orderId));
			modelMap.addAttribute("orderTransferImageDataList", orderTransferDao.getTransferImageDataListByOrder(orderId));
			modelMap.addAttribute("userList", userDao.getUserList());
		}
		return "system2orderdetail";
	}
	
	@RequestMapping(value = "/updateOrderStatus/{orderId}/{orderStatusId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse updateOrderStatus(
			@PathVariable int orderId, 
			@PathVariable int orderStatusId, 
			HttpServletRequest request) {
		updateOrderStatusAction(orderId, orderStatusId, request);
		return new SuccessResponse("Update Order Status Success");
	}
	
	private void updateOrderStatusAction(int orderId, int orderStatusId, HttpServletRequest request) {
		Order order = orderDao.getOrderDetail(orderId);
		OrderStatus orderStatus = orderStatusDao.getOrderStatus(orderStatusId);
		User user = RequestUtil.getLoginUser(request);
		if (user != null) {
			order.setUserId(user.getId());
		}
		if (order != null && orderStatus != null) {
			orderDao.updateOrderStatus(order, orderStatus);
		}
	}
	
	@RequestMapping(value = "/setOrderTransfer/{orderId}/{userId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setOrderTransfer(
			@PathVariable int orderId, 
			@PathVariable int userId, 
			HttpServletRequest request) {
		orderTransferDao.insertOrderTransfer(orderId, userId);
		updateOrderStatusAction(orderId, OrderStatusConst.TRANSFER_IMAGE, request);
		return new SuccessResponse("Set Order Transfer Success");
	}
}
