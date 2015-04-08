<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orange 9</title>
<link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>"/>
<link rel="stylesheet" href="<c:url value='/css/header.css'/>"/>
<script src="<c:url value='/js/jquery-1.11.2.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/js/views-nav.js'/>"></script>
<style>
	.login-console {
		color: #FEC504;
		font-size: 18px;
		font-weight: bold;
		padding-top: 100px;
		text-align: center;
	}
	
	.login-header {
		font-size: 26px;
		margin-bottom: 20px;
	}
	
	.login-header span {
		color: #000000;
	}
	
	.login-input {
		display: inline;
		width: 300px;
	}
	
	.login-btn {
		width: 300px;
	}
</style>
</head>
<body>
<div class="header border-bottom">
	<span class="orange">ORANGE</span>
	<span class="nine">9</span>
</div>

<div class="login-console">
	<p class="login-header"><span>ORANGE</span> 9 SYSTEM</p>
	<div class="form-group">
		<input type="text" class="form-control login-input" id="i-name" placeholder="账号"/>
	</div>
	<div class="form-group">
		<input type="password" class="form-control login-input" id="i-password" placeholder="密码">
	</div>
	<div class="form-group">
		<button class="btn btn-warning login-btn" onclick="login()">登录</button>
	</div>
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
<script>
	function login() {
		location.assign("<c:url value='/system'/>");
	}
</script>
</body>
</html>