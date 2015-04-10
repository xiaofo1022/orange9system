package com.xiaofo1022.orange9.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.xiaofo1022.orange9.modal.User;

public class RequestUtil {
	public static User getLoginUser(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session != null) {
			return (User) session.getAttribute("user");
		}
		return null;
	}
}
