<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>Orange 9</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="xiaofo">
<link rel="icon" href="<c:url value="/images/favicon.ico"/>" type="image/x-icon" /> 
<link rel="shortcut icon" href="<c:url value="/images/favicon.ico"/>" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap.lufter.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/lufter/lufter.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/lufter/page.css'/>" />
<link href="<c:url value='/css/lufter/login.css'/>" rel="stylesheet"/>
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<body class="blank-bg">
<div class="container">
<div class="row">
	<div class="col-sm-12 blog-main" style="width:100%;">
		<jsp:include page="header.jsp" flush="true"/>
		<div class="index-row">
			<nav class="index-nav">
				<a class="index-nav-item" href="<c:url value='/enu'/>">欧美</a>
				<a class="index-nav-item" href="<c:url value='/jnk'/>">日韩</a>
				<a class="index-nav-item" href="<c:url value='/sta'/>">静物</a>
				<a class="index-nav-item" href="<c:url value='/tog'/>">拼拍</a>
				<a class="index-nav-item active">登录</a>
			</nav>
		</div>
		<div class="index-row">
			<div class="index-login-console">
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
		<jsp:include page="footer.jsp" flush="true"/>
	</div>
</div>
</div>
<script src="<c:url value='/js/lufter/index.js'/>"></script>
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