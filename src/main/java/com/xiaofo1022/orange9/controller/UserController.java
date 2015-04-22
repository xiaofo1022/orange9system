package com.xiaofo1022.orange9.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.common.Message;
import com.xiaofo1022.orange9.dao.UserDao;
import com.xiaofo1022.orange9.modal.User;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.FailureResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;
import com.xiaofo1022.orange9.util.RequestUtil;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserDao userDao;
	
	@RequestMapping(value = "/addUser", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse addUser(@ModelAttribute("employee") User user, BindingResult result, HttpServletRequest request) {
		if (userDao.getUserByAccount(user.getAccount()) != null) {
			return new FailureResponse(Message.EXIST_USER_ACCOUNT);
		}
		User loginUser = RequestUtil.getLoginUser(request);
		if (loginUser != null) {
			user.setBossId(loginUser.getId());
		}
		userDao.insertUser(user);
		return new SuccessResponse("Add User Success");
	}
	
	@RequestMapping(value = "/getUserList", method = RequestMethod.GET)
	@ResponseBody
	public List<User> getUserList(HttpServletRequest request) {
		User loginUser = RequestUtil.getLoginUser(request);
		if (loginUser != null) {
			return userDao.getUserList();
		}
		return null;
	}
	
	@RequestMapping(value = "/updateUser", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse updateUser(@ModelAttribute("employee") User user) {
		userDao.updateUser(user);
		return new SuccessResponse("Update User Success");
	}
	
	@RequestMapping(value = "/deleteUser/{userId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse deleteUser(@PathVariable int userId) {
		userDao.deleteUser(userId);
		return new SuccessResponse("Delete User Success");
	}
}
