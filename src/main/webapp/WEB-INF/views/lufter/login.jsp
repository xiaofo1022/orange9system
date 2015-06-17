<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="xiaofo">
<title>Orange 9</title>
<link href="<c:url value='/css/bootstrap.lufter.css'/>" rel="stylesheet"/>
<link href="<c:url value='/css/lufter/lufter.css'/>" rel="stylesheet"/>
<link href="<c:url value='/css/lufter/login.css'/>" rel="stylesheet"/>
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<body class="login-body">
<div class="login-pos">
	<div class="login-header">
		ORANGE 9
		<p>Living For Real</p>
	</div>
	<div class="login-console">
		<sf:form id="loginForm" modelAttribute="login" method="post">
			<div class="form-group">
				<input type="text" class="form-control login-input" id="i-name" name="username" placeholder="账号"/>
			</div>
			<div class="form-group">
				<input type="password" class="form-control login-input" id="i-password" name="password" placeholder="密码">
			</div>
			<div class="form-group">
				<button id="btnLogin" class="btn btn-primary login-btn" onclick="login()">登录</button>
			</div>
		</sf:form>
	</div>
</div>
<div class="footer">
	All Powered By <a href="http://www.douban.com/people/41193239/" target="_blank">Xiaofo</a>
	| 九橙文化创意有限公司版权所有
	| ©2015
</div>
<script src="<c:url value='/js/validation/jquery.validate.js'/>"></script>
<script src="<c:url value='/js/validation/validation-message-cn.js'/>"></script>
<script src="<c:url value='/js/validation/validator.js'/>"></script>
<script>
	var loginRules = {
		username: { required: true },
		password: { required: true }
	};
	
	var validator = new Validator("loginForm", "btnLogin", loginRules, "<c:url value='/login'/>", loginCallback);
	
	function login() {
		$("#loginForm").submit();
	}
	
	function loginCallback(response) {
		if (response.status == "success") {
			location.assign("<c:url value='/" + response.data + "'/>");
		} else {
			alert(response.msg);
		}
	}
</script>
</body>
</html>