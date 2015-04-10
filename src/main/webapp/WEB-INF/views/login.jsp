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
<div class="header border-bottom">
	<span class="orange">ORANGE</span>
	<span class="nine">9</span>
</div>

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

<div class="footer border-top navbar-fixed-bottom">
	<div>
		<div id="block1" class="orange-block orange-trans bc-orange2"></div>
		<div id="block2" class="orange-block orange-trans bc-orange1"></div>
		<div id="block3" class="orange-block orange-trans bc-orange0">杭</div>
		<div id="block4" class="orange-block orange-trans bc-orange1">州</div>
		<div id="block5" class="orange-block orange-trans bc-orange2">九</div>
		<div id="block6" class="orange-block orange-trans bc-orange3">橙</div>
		<div id="block7" class="orange-block orange-trans bc-orange0">文</div>
		<div id="block8" class="orange-block orange-trans bc-orange1">化</div>
		<div id="block9" class="orange-block orange-trans bc-orange2">创</div>
		<div id="block10" class="orange-block orange-trans bc-orange3">意</div>
		<div id="block11" class="orange-block orange-trans bc-orange0">有</div>
		<div id="block12" class="orange-block orange-trans bc-orange1">限</div>
		<div id="block13" class="orange-block orange-trans bc-orange2">公</div>
		<div id="block14" class="orange-block orange-trans bc-orange3">司</div>
		<div id="block15" class="orange-block orange-trans bc-orange2"></div>
		<p style="float:left;margin-left: 5px;margin-top: 5px;">| Copyrights Orange 9. ALL Rights Reserved.</p>
	</div>
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