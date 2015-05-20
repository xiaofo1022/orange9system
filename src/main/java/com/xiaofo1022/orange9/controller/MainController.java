package com.xiaofo1022.orange9.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.common.Message;
import com.xiaofo1022.orange9.common.OrderConst;
import com.xiaofo1022.orange9.common.OrderStatusConst;
import com.xiaofo1022.orange9.common.RoleConst;
import com.xiaofo1022.orange9.common.TimeLimitConst;
import com.xiaofo1022.orange9.core.GlobalData;
import com.xiaofo1022.orange9.dao.ClockInDao;
import com.xiaofo1022.orange9.dao.LoginDao;
import com.xiaofo1022.orange9.dao.OrderConvertDao;
import com.xiaofo1022.orange9.dao.OrderDao;
import com.xiaofo1022.orange9.dao.OrderGoodsDao;
import com.xiaofo1022.orange9.dao.OrderPostProductionDao;
import com.xiaofo1022.orange9.dao.OrderTimeLimitDao;
import com.xiaofo1022.orange9.dao.OrderVerifyDao;
import com.xiaofo1022.orange9.dao.UserDao;
import com.xiaofo1022.orange9.modal.ClockIn;
import com.xiaofo1022.orange9.modal.Login;
import com.xiaofo1022.orange9.modal.Order;
import com.xiaofo1022.orange9.modal.OrderFixedImageData;
import com.xiaofo1022.orange9.modal.OrderVerifyImage;
import com.xiaofo1022.orange9.modal.User;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.FailureResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;
import com.xiaofo1022.orange9.util.RequestUtil;

@Controller("mainController")
public class MainController {
	@Autowired
	private LoginDao loginDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private ClockInDao clockInDao;
	@Autowired
	private OrderTimeLimitDao orderTimeLimitDao;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private OrderConvertDao orderConvertDao;
	@Autowired
	private OrderPostProductionDao orderPostProductionDao;
	@Autowired
	private OrderVerifyDao orderVerifyDao;
	@Autowired
	private OrderGoodsDao orderGoodsDao;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String index() {
		return "login";
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	@ResponseBody
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.removeAttribute("user");
			session.invalidate();
		}
		return "/";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	@ResponseBody
	public CommonResponse login(@ModelAttribute("login") Login login, BindingResult result, HttpServletRequest request) {
		User user = loginDao.getUser(login);
		if (user == null) {
			return new FailureResponse(Message.LOGIN_FAILURE);
		} else {
			user.setPicbaseurl(GlobalData.getInstance().getPicbaseurl());
			HttpSession session = request.getSession(true);
			session.setAttribute("user", user);
			if (user.getRoleId() == RoleConst.CLIENT_ID) {
				return new SuccessResponse(Message.LOGIN_SUCCESS, "client/main/" + user.getBossId());
			} else {
				return new SuccessResponse(Message.LOGIN_SUCCESS, "orderSummary");
			}
		}
	}
	
	@RequestMapping(value="/employee", method=RequestMethod.GET)
	public String system() {
		return "system2employee";
	}
	
	@RequestMapping(value="/orderSummary", method=RequestMethod.GET)
	public String system2ordersummary(HttpServletRequest request, ModelMap modelMap) {
		User user = RequestUtil.getLoginUser(request);
		if (user != null) {
			ClockIn clockIn = clockInDao.clockIn(user.getId());
			if (clockIn != null) {
				modelMap.addAttribute("clockIn", clockIn);
			}
		}
		modelMap.addAttribute("modelNameList", orderDao.getModelNameList());
		modelMap.addAttribute("dresserNameList", orderDao.getDresserNameList());
		modelMap.addAttribute("stylistNameList", orderDao.getStylistNameList());
		modelMap.addAttribute("brokerList", orderDao.getBrokerList());
		return "system2ordersummary";
	}
	
	@RequestMapping(value="/orderGoods", method=RequestMethod.GET)
	public String system2ordergoods(ModelMap modelMap) {
		List<Order> orderList = orderDao.getOrderList();
		for (Order order : orderList) {
			order.setOrderGoodsList(orderGoodsDao.getOrderGoodsList(order.getId()));
		}
		modelMap.addAttribute("orderList", orderList);
		return "system2ordergoods";
	}
	
	@RequestMapping(value="/shooting", method=RequestMethod.GET)
	public String system2shoot(ModelMap modelMap) {
		modelMap.addAttribute("orderShootList", orderDao.getOrderListByStatus(OrderStatusConst.SHOOTING));
		modelMap.addAttribute("limitMinutes", orderTimeLimitDao.getTimeLimit(TimeLimitConst.SHOOT_ID).getLimitMinutes());
		return "system2shoot";
	}
	
	@RequestMapping(value="/transferImage", method=RequestMethod.GET)
	public String system2transferimage(ModelMap modelMap) {
		modelMap.addAttribute("limitMinutes", orderTimeLimitDao.getTimeLimit(TimeLimitConst.TRANSFER_ID).getLimitMinutes());
		return "system2transferimage";
	}
	
	@RequestMapping(value="/convertImage", method=RequestMethod.GET)
	public String system2convertimage(ModelMap modelMap) {
		modelMap.addAttribute("orderConvertList", orderConvertDao.getOrderConvertList());
		modelMap.addAttribute("userList", userDao.getUserList());
		modelMap.addAttribute("limitMinutes", orderTimeLimitDao.getTimeLimit(TimeLimitConst.CONVERT_ID).getLimitMinutes());
		return "system2convertimage";
	}
	
	@RequestMapping(value="/fixSkin", method=RequestMethod.GET)
	public String system2fixskin(HttpServletRequest request, ModelMap modelMap) {
		User user = RequestUtil.getLoginUser(request);
		int userId = 0;
		if (user != null && user.getIsAdmin() != 1) {
			userId = user.getId();
		}
		modelMap.addAttribute("fixSkinList", orderPostProductionDao.getPostProductionList(OrderConst.TABLE_ORDER_FIX_SKIN, userId));
		return "system2fixskin";
	}
	
	@RequestMapping(value="/fixBackground", method=RequestMethod.GET)
	public String system2fixbackground(ModelMap modelMap) {
		modelMap.addAttribute("postProductionList", orderPostProductionDao.getPostProductionList(OrderConst.TABLE_ORDER_FIX_BACKGROUND, 0));
		return "system2fixbackground";
	}
	
	@RequestMapping(value="/cutLiquify", method=RequestMethod.GET)
	public String system2cutliquify(ModelMap modelMap) {
		modelMap.addAttribute("postProductionList", orderPostProductionDao.getPostProductionList(OrderConst.TABLE_ORDER_CUT_LIQUIFY, 0));
		return "system2cutliquify";
	}
	
	@RequestMapping(value="/verifyImage", method=RequestMethod.GET)
	public String system2verifyimage(ModelMap modelMap) {
		List<Order> orderList = orderDao.getOrderListByStatus(OrderStatusConst.WAIT_FOR_VERIFY);
		List<OrderVerifyImage> orderVerifyList = new ArrayList<OrderVerifyImage>(orderList.size());
		if (orderList != null && orderList.size() > 0) {
			for (Order order : orderList) {
				OrderVerifyImage verifyImage = orderVerifyDao.getOrderVerifyImage(order.getId());
				if (verifyImage == null) {
					verifyImage = new OrderVerifyImage();
					verifyImage.setOrderId(order.getId());
				}
				List<OrderFixedImageData> fixedImageDataList = orderPostProductionDao.getOrderFixedImageDataList(order.getId());
				if (fixedImageDataList != null && fixedImageDataList.size() > 0) {
					verifyImage.setFixedImageDataList(fixedImageDataList);
					int verifyCount = 0;
					int verifiedCount = 0;
					int deniedCount = 0;
					for (OrderFixedImageData fixedImageData : fixedImageDataList) {
						if (fixedImageData.getIsVerified() == 1) {
							verifiedCount++;
						} else {
							if (fixedImageData.getReason() == null) {
								verifyCount++;
							} else {
								deniedCount++;
							}
						}
					}
					verifyImage.setDeniedCount(deniedCount);
					verifyImage.setVerifyCount(verifyCount);
					verifyImage.setVerifiedCount(verifiedCount);
				}
				orderVerifyList.add(verifyImage);
			}
		}
		modelMap.addAttribute("userList", userDao.getUserList());
		modelMap.addAttribute("orderVerifyList", orderVerifyList);
		return "system2verifyimage";
	}
	
	@RequestMapping(value="/clientWaiting", method=RequestMethod.GET)
	public String system2clientwaiting(ModelMap map) {
		map.addAttribute("orderList", orderDao.getOrderListByStatus(OrderStatusConst.WAITING_FOR_CLIENT_CHOSE));
		return "system2clientwaiting";
	}
}
