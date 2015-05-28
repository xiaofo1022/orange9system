package com.xiaofo1022.orange9.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.dao.NotificationDao;
import com.xiaofo1022.orange9.modal.Notification;
import com.xiaofo1022.orange9.modal.User;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;
import com.xiaofo1022.orange9.util.RequestUtil;

@Controller
@RequestMapping("/notification")
public class NotificationController {
	@Autowired
	private NotificationDao notificationDao;
	
	@RequestMapping(value = "/addNotification", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse addNotification(@RequestBody Notification notification, BindingResult result, HttpServletRequest request) {
		notificationDao.insertNotification(notification);
		return new SuccessResponse("Add Notification Success");
	}
	
	@RequestMapping(value = "/getNotification", method = RequestMethod.GET)
	@ResponseBody
	public Notification getNotification(HttpServletRequest request) {
		User user = RequestUtil.getLoginUser(request);
		if (user != null) {
			return notificationDao.getNotification(user.getId());
		} else {
			return null;
		}
	}
	
	@RequestMapping(value = "/readNotification/{id}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse readNotification(@PathVariable int id, HttpServletRequest request) {
		notificationDao.readNotification(id);
		return new SuccessResponse("Read Notification Success");
	}
}
