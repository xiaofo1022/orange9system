<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<body class="blank-bg">
<div class="container">
<div class="row">
	<div class="col-sm-12 blog-main" style="width:100%;">
		<div class="index-row">
			<img class="index-row-header" src="<c:url value='/images/logo2.png'/>"/>
		</div>
		<div class="index-row">
			<nav class="index-nav">
				<a class="index-nav-item" href="<c:url value='/enu'/>">欧美</a>
				<a class="index-nav-item active">日韩</a>
				<a class="index-nav-item" href="<c:url value='/sta'/>">静物</a>
				<a class="index-nav-item" href="<c:url value='/tog'/>">拼拍</a>
				<a class="index-nav-item" href="<c:url value='/lgn'/>">登录</a>
			</nav>
		</div>
		<div class="index-pic-row">
			<img class="index-detail-img" src="<c:url value='/images/show/jnk/${id}/1.jpg'/>"/>
			<img class="index-detail-img" src="<c:url value='/images/show/jnk/${id}/2.jpg'/>"/>
			<img class="index-detail-img" src="<c:url value='/images/show/jnk/${id}/3.jpg'/>"/>
			<img class="index-detail-img" src="<c:url value='/images/show/jnk/${id}/4.jpg'/>"/>
			<img class="index-detail-img" src="<c:url value='/images/show/jnk/${id}/5.jpg'/>"/>
		</div>
		<jsp:include page="../footer.jsp" flush="true"/>
	</div>
</div>
</div>
</body>
</html>