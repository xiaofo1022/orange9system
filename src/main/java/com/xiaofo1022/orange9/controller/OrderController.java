package com.xiaofo1022.orange9.controller;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.common.OrderConst;
import com.xiaofo1022.orange9.common.OrderStatusConst;
import com.xiaofo1022.orange9.dao.OrderConvertDao;
import com.xiaofo1022.orange9.dao.OrderDao;
import com.xiaofo1022.orange9.dao.OrderHistoryDao;
import com.xiaofo1022.orange9.dao.OrderPostProductionDao;
import com.xiaofo1022.orange9.dao.OrderStatusDao;
import com.xiaofo1022.orange9.dao.OrderTransferDao;
import com.xiaofo1022.orange9.dao.OrderVerifyDao;
import com.xiaofo1022.orange9.dao.UserDao;
import com.xiaofo1022.orange9.modal.Order;
import com.xiaofo1022.orange9.modal.OrderRollback;
import com.xiaofo1022.orange9.modal.OrderStatus;
import com.xiaofo1022.orange9.modal.User;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;
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
	@Autowired
	private OrderVerifyDao orderVerifyDao;
	
	@RequestMapping(value = "/addOrder", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse addOrder(@ModelAttribute("order") Order order, BindingResult bindingResult, HttpServletRequest request) {
		User user = RequestUtil.getLoginUser(request);
		if (user != null) {
			order.setUserId(user.getId());
			order.setOwnerId(user.getBossId());
			orderDao.insertOrder(order);
		}
		return new SuccessResponse("Add Order Success");
	}
	
	@RequestMapping(value = "/updateOrder/{orderId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse editOrder(@ModelAttribute("order") Order order, BindingResult bindingResult, @PathVariable int orderId, HttpServletRequest request) {
		User user = RequestUtil.getLoginUser(request);
		if (user != null) {
			order.setId(orderId);
			orderDao.updateOrder(order);
		}
		return new SuccessResponse("Edit Order Success");
	}
	
	@RequestMapping(value = "/getOrderList", method = RequestMethod.GET)
	@ResponseBody
	public List<Order> getOrderList() {
		return orderDao.getOrderList();
	}
	
	@RequestMapping(value = "/getOrderListByDate/{startDate}/{endDate}", method = RequestMethod.GET)
	@ResponseBody
	public List<Order> getOrderListByDate(@PathVariable String startDate, @PathVariable String endDate, HttpServletRequest request) {
		User user = RequestUtil.getLoginUser(request);
		if (user != null) {
			return orderDao.getOrderListByDate(startDate, endDate, user.getBossId());
		} else {
			return null;
		}
	}
	
	@RequestMapping(value = "/getOrderStatusCountMap", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Integer> getOrderStatusCountMap(HttpServletRequest request) {
		User loginUser = RequestUtil.getLoginUser(request);
		if (loginUser != null) {
			return orderStatusDao.getOrderStatusCountMap(loginUser.getId(), loginUser.getBossId());
		} else {
			return null;
		}
	}
	
	@RequestMapping(value="/orderDetail/{orderId}", method=RequestMethod.GET)
	public String orderDetail(@PathVariable int orderId, ModelMap modelMap, HttpServletRequest request) {
		Order orderDetail = orderDao.getOrderDetail(orderId);
		User user = RequestUtil.getLoginUser(request);
		if (orderDetail != null && user != null) {
			modelMap.addAttribute("orderDetail", orderDetail);
			modelMap.addAttribute("timeCost", orderDao.getOrderTimeCost(orderDetail));
			modelMap.addAttribute("orderStatusList", orderStatusDao.getOrderStatusList());
			modelMap.addAttribute("orderHistoryList", orderHistoryDao.getOrderHistoryList(orderId));
			modelMap.addAttribute("orderFixSkin", orderPostProductionDao.getPostProductionFixer(OrderConst.COLUMN_FIXED_SKIN_OPERATOR, orderId));
			modelMap.addAttribute("orderFixBackground", orderPostProductionDao.getPostProductionFixer(OrderConst.COLUMN_FIXED_BACKGROUND_OPERATOR, orderId));
			modelMap.addAttribute("orderCutLiquify", orderPostProductionDao.getPostProductionFixer(OrderConst.COLUMN_CUT_LIQUIFY_OPERATOR, orderId));
			modelMap.addAttribute("orderTransferImageDataList", orderTransferDao.getTransferImageDataListByOrder(orderId));
			modelMap.addAttribute("orderFixedImageDataList", orderPostProductionDao.getOrderFixedImageDataList(orderId));
			modelMap.addAttribute("orderVerifier", orderVerifyDao.getOrderVerifyImage(orderId));
			modelMap.addAttribute("userList", userDao.getUserList());
			modelMap.addAttribute("modelNameList", orderDao.getModelNameList(user.getBossId()));
			modelMap.addAttribute("dresserNameList", orderDao.getDresserNameList(user.getBossId()));
			modelMap.addAttribute("stylistNameList", orderDao.getStylistNameList(user.getBossId()));
			modelMap.addAttribute("brokerList", orderDao.getBrokerList(user.getBossId()));
		}
		return "lufter/orderdetail";
	}
	
	@RequestMapping(value = "/updateOrderStatus/{orderId}/{orderStatusId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse updateOrderStatus(
			@PathVariable int orderId, 
			@PathVariable int orderStatusId, 
			HttpServletRequest request) {
		updateOrderStatusAction(orderId, orderStatusId, null, request);
		return new SuccessResponse("Update Order Status Success");
	}
	
	@RequestMapping(value = "/orderStatusRollback", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse orderStatusRollback(@RequestBody OrderRollback orderRollback, HttpServletRequest request) {
		updateOrderStatusAction(orderRollback.getOrderId(), orderRollback.getStatusId(), orderRollback.getReason(), request);
		return new SuccessResponse("Update Order Status Success");
	}
	
	private void updateOrderStatusAction(int orderId, int orderStatusId, String reason, HttpServletRequest request) {
		Order order = orderDao.getOrderDetail(orderId);
		OrderStatus orderStatus = orderStatusDao.getOrderStatus(orderStatusId);
		User user = RequestUtil.getLoginUser(request);
		if (user != null) {
			order.setUserId(user.getId());
		}
		if (order != null && orderStatus != null) {
			orderDao.updateOrderStatus(order, orderStatus, reason);
		}
	}
	
	@RequestMapping(value = "/setOrderTransfer/{orderId}/{userId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setOrderTransfer(
			@PathVariable int orderId, 
			@PathVariable int userId, 
			HttpServletRequest request) {
		orderTransferDao.insertOrderTransfer(orderId, userId);
		updateOrderStatusAction(orderId, OrderStatusConst.TRANSFER_IMAGE, null, request);
		return new SuccessResponse("Set Order Transfer Success");
	}
	
	@RequestMapping(value = "/getOrderDetail/{orderId}", method = RequestMethod.GET)
	@ResponseBody
	public Order getOrderDetail(@PathVariable int orderId) {
		Order order = orderDao.getOrderDetail(orderId);
		return order;
	}
}
