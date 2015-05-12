package com.xiaofo1022.orange9.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.common.Message;
import com.xiaofo1022.orange9.common.OrderConst;
import com.xiaofo1022.orange9.dao.ClockInDao;
import com.xiaofo1022.orange9.dao.OrderPostProductionDao;
import com.xiaofo1022.orange9.dao.PerformanceDao;
import com.xiaofo1022.orange9.dao.UserDao;
import com.xiaofo1022.orange9.modal.ClockIn;
import com.xiaofo1022.orange9.modal.Count;
import com.xiaofo1022.orange9.modal.Performance;
import com.xiaofo1022.orange9.modal.PerformanceChart;
import com.xiaofo1022.orange9.modal.User;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.FailureResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;
import com.xiaofo1022.orange9.util.DatetimeUtil;
import com.xiaofo1022.orange9.util.RequestUtil;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserDao userDao;
	@Autowired
	private ClockInDao clockInDao;
	@Autowired
	private OrderPostProductionDao orderPostProductionDao;
	@Autowired
	private PerformanceDao performanceDao;
	
	@RequestMapping(value = "/addUser", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse addUser(@ModelAttribute("employee") User user, BindingResult result, HttpServletRequest request) {
		if (userDao.getUserByPhone(user.getPhone()) != null) {
			return new FailureResponse(Message.EXIST_USER_PHONE);
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
	
	@RequestMapping(value = "/getUserDetailList", method = RequestMethod.GET)
	@ResponseBody
	public List<User> getUserDetailList(HttpServletRequest request) {
		User loginUser = RequestUtil.getLoginUser(request);
		if (loginUser != null) {
			List<User> userList = userDao.getUserList();
			String[] queryMonth = DatetimeUtil.getMonthStartAndEndDate(new Date());
			for (User user : userList) {
				this.createUserClockIn(user, queryMonth[0], queryMonth[1]);
				this.createUserPerformance(user, queryMonth[0], queryMonth[1]);
			}
			return userList;
		}
		return null;
	}
	
	private void createUserPerformance(User user, String startDate, String endDate) {
		List<Performance> performanceList = performanceDao.getPerformanceList();
		Count fixSkinCount = orderPostProductionDao.getAllPostProductionCount(user.getId(), OrderConst.TABLE_ORDER_FIX_SKIN, startDate, endDate);
		Count fixSkinDoneCount = orderPostProductionDao.getAllPostProductionDoneCount(user.getId(), OrderConst.TABLE_ORDER_FIX_SKIN, startDate, endDate);
		Count fixBackgroundCount = orderPostProductionDao.getAllPostProductionCount(user.getId(), OrderConst.TABLE_ORDER_FIX_BACKGROUND, startDate, endDate);
		Count fixBackgroundDoneCount = orderPostProductionDao.getAllPostProductionDoneCount(user.getId(), OrderConst.TABLE_ORDER_FIX_BACKGROUND, startDate, endDate);
		Count cutLiquifyCount = orderPostProductionDao.getAllPostProductionCount(user.getId(), OrderConst.TABLE_ORDER_CUT_LIQUIFY, startDate, endDate);
		Count cutLiquifyDoneCount = orderPostProductionDao.getAllPostProductionDoneCount(user.getId(), OrderConst.TABLE_ORDER_CUT_LIQUIFY, startDate, endDate);
		user.setMonthPostProduction(fixSkinCount.getCnt() + fixBackgroundCount.getCnt() + cutLiquifyCount.getCnt());
		user.setMonthDonePostProduction(fixSkinDoneCount.getCnt() + fixBackgroundDoneCount.getCnt() + cutLiquifyDoneCount.getCnt());
		user.addPerformance(performanceList.get(0).getBaseCount(), fixSkinDoneCount.getCnt(), performanceList.get(0).getPush());
		user.addPerformance(performanceList.get(1).getBaseCount(), fixBackgroundDoneCount.getCnt(), performanceList.get(1).getPush());
		user.addPerformance(performanceList.get(2).getBaseCount(), cutLiquifyDoneCount.getCnt(), performanceList.get(2).getPush());
	}
	
	private void createUserClockIn(User user, String startDate, String endDate) {
		List<ClockIn> clockInList = clockInDao.getMonthClockInList(user.getId(), startDate, endDate);
		if (clockInList != null && clockInList.size() > 0) {
			for (ClockIn clockIn : clockInList) {
				if (clockIn != null) {
					user.addClockIn(clockIn);
				}
			}
		}
	}
	
	@RequestMapping(value = "/getUserClockIn", method = RequestMethod.POST)
	@ResponseBody
	public User getUserClockIn(@RequestBody ClockIn clockIn, HttpServletRequest request) {
		User user = userDao.getUserById(clockIn.getUserId());
		String[] queryMonth = DatetimeUtil.getMonthStartAndEndDate(clockIn.getClockDatetime());
		this.createUserClockIn(user, queryMonth[0], queryMonth[1]);
		return user;
	}
	
	@RequestMapping(value = "/getUserPerformanceChart/{year}/{userId}", method = RequestMethod.GET)
	@ResponseBody
	public PerformanceChart getUserPerformanceChart(@PathVariable int year, @PathVariable int userId, HttpServletRequest request) {
		User user = userDao.getUserById(userId);
		PerformanceChart performanceChart = new PerformanceChart();
		if (user != null) {
			performanceChart.setUserName(user.getName());
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.YEAR, year);
			for (int i = 0; i < 12; i++) {
				calendar.set(Calendar.MONTH, i);
				calendar.set(Calendar.DATE, 1);
				String[] queryMonth = DatetimeUtil.getMonthStartAndEndDate(calendar.getTime());
				this.createUserPerformance(user, queryMonth[0], queryMonth[1]);
				performanceChart.addPerformance(user.getMonthDonePostProduction());
			}
		}
		return performanceChart;
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
