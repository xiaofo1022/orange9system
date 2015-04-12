package com.xiaofo1022.orange9.controller;

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
import com.xiaofo1022.orange9.dao.LoginDao;
import com.xiaofo1022.orange9.modal.Login;
import com.xiaofo1022.orange9.modal.User;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.FailureResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;

@Controller("mainController")
public class MainController {
	@Autowired
	private LoginDao loginDao;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String index() {
		return "login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	@ResponseBody
	public CommonResponse login(@ModelAttribute("login") Login login, BindingResult result, HttpServletRequest request, ModelMap modelMap) {
		User user = loginDao.getUser(login);
		if (user == null) {
			return new FailureResponse(Message.LOGIN_FAILURE);
		} else {
			HttpSession session = request.getSession(true);
			session.setAttribute("user", user);
			return new SuccessResponse(Message.LOGIN_SUCCESS, "orderSummary");
		}
	}
	
	@RequestMapping(value="/employee", method=RequestMethod.GET)
	public String system() {
		return "system2employee";
	}
	
	@RequestMapping(value="/orderSummary", method=RequestMethod.GET)
	public String system2ordersummary() {
		return "system2ordersummary";
	}
	
	@RequestMapping(value="/order", method=RequestMethod.GET)
	public String order() {
		return "system2order";
	}
	
	@RequestMapping(value="/orderDetail", method=RequestMethod.GET)
	public String orderDetail() {
		return "system2orderdetail";
	}
	
	@RequestMapping(value="/post", method=RequestMethod.GET)
	public String post() {
		return "system2post";
	}
	
	@RequestMapping(value="/model", method=RequestMethod.GET)
	public String model() {
		return "system2model";
	}
}
