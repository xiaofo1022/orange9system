<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orange 9</title>
<link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>"/>
<link rel="stylesheet" href="<c:url value='/css/header.css'/>"/>
<link rel="stylesheet" href="<c:url value='/css/system/login.css'/>"/>
<script src="<c:url value='/js/jquery-1.11.2.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/js/views-nav.js'/>"></script>
</head>
<body>

<div class="login-console">
	<p class="login-header"><span>ORANGE</span> 9 SYSTEM</p>
	<sf:form id="loginForm" modelAttribute="login" method="post">
		<div class="form-group">
			<input type="text" class="form-control login-input" id="i-name" name="username" placeholder="账号"/>
		</div>
		<div class="form-group">
			<input type="password" class="form-control login-input" id="i-password" name="password" placeholder="密码">
		</div>
		<div class="form-group">
			<button id="btnLogin" class="btn btn-warning login-btn" onclick="login()">登录</button>
		</div>
	</sf:form>
</div>

<script src="<c:url value='/js/client.js'/>"></script>
<script src="<c:url value='/js/tripper.js'/>"></script>
<script src="<c:url value='/js/tripper-control.js'/>"></script>
<script src="<c:url value='/js/footer.js'/>"></script>
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