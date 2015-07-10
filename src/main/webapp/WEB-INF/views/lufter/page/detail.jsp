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
		<jsp:include page="header.jsp" flush="true">
			<jsp:param value="${path}" name="link"/>
		</jsp:include>
		<div class="index-pic-row">
			<c:forEach items="${pictureList}" var="picture">
				<img class="index-detail-img" src="<c:url value='/images/show/${path}/${picname}/${picture}.jpg'/>"/>
			</c:forEach>
		</div>
		<jsp:include page="footer.jsp" flush="true"/>
	</div>
</div>
</div>
</body>
</html>