package com.xiaofo1022.orange9.filter;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.xiaofo1022.orange9.common.RoleConst;
import com.xiaofo1022.orange9.modal.User;

public class LoginFilter implements Filter {
	private Pattern allowedResources;
	private Pattern allowedClient;
	private final static String resPattern = ".*((login)|(logout)|(images/)|(img/)|(css/)|(js/)|(fonts/)).*";
	private final static String clientPattern = ".*((login)|(logout)|(client/)|(pictures/)|(images/)|(img/)|(css/)|(js/)|(fonts/)).*";
	
	public void init(FilterConfig arg0) throws ServletException {
		allowedResources = Pattern.compile(resPattern);
		allowedClient = Pattern.compile(clientPattern);
	}
	
	public void destroy() {}
	
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) arg0;
		String uri = request.getRequestURI();
		String baseUri = request.getContextPath()+ "/";
		User user = null;
		boolean canEnterSystem = false;
		
		if (!uri.equals(baseUri) && !allowedResources.matcher(uri).matches()) {
			HttpSession session = request.getSession(false);
			if (session != null) {
				user = (User) session.getAttribute("user");
				if (user != null) {
					if (user.getRoleId() == RoleConst.CLIENT_ID && !allowedClient.matcher(uri).matches()) {
						canEnterSystem = false;
					} else {
						canEnterSystem = true;
					}
				}
			}
		} else {
			canEnterSystem = true;
		}
		
		if (canEnterSystem) {
			arg2.doFilter(arg0, arg1);
		} else {
			HttpServletResponse response = (HttpServletResponse) arg1;
			response.sendRedirect(response.encodeRedirectURL(baseUri));
			return;
		}
	}
}
