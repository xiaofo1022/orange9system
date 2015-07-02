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
			<jsp:param value="jnk" name="link"/>
		</jsp:include>
		<div class="index-row">
			<div class="clearfix">
				<a id="index-jnk-1" class="index-pic-link pos-relative fleft">
					<img src="<c:url value='/images/show/jnk/1.jpg'/>"/>
					<span class="index-info-block sbg1">Show It</span>
				</a>
				<a id="index-jnk-2" class="index-pic-link pos-relative fleft">
					<img src="<c:url value='/images/show/jnk/2.jpg'/>"/>
					<span class="index-info-block sbg2">Show It</span>
				</a>
				<a id="index-jnk-3" class="index-pic-link pos-relative fleft">
					<img src="<c:url value='/images/show/jnk/3.jpg'/>"/>
					<span class="index-info-block sbg3">Show It</span>
				</a>
			</div>
			<div class="clearfix">
				<a id="index-jnk-4" class="index-pic-link pos-relative fleft">
					<img src="<c:url value='/images/show/jnk/4.jpg'/>"/>
					<span class="index-info-block sbg4">Show It</span>
				</a>
				<a id="index-jnk-5" class="index-pic-link pos-relative fleft">
					<img src="<c:url value='/images/show/jnk/5.jpg'/>"/>
					<span class="index-info-block sbg5">Show It</span>
				</a>
				<a id="index-jnk-6" class="index-pic-link pos-relative fleft">
					<img src="<c:url value='/images/show/jnk/6.jpg'/>"/>
					<span class="index-info-block sbg1">Show It</span>
				</a>
			</div>
			<div class="clearfix">
				<a id="index-jnk-7" class="index-pic-link pos-relative fleft">
					<img src="<c:url value='/images/show/jnk/7.jpg'/>"/>
					<span class="index-info-block sbg2">Show It</span>
				</a>
				<a id="index-jnk-8" class="index-pic-link pos-relative fleft">
					<img src="<c:url value='/images/show/jnk/8.jpg'/>"/>
					<span class="index-info-block sbg3">Show It</span>
				</a>
				<a id="index-jnk-9" class="index-pic-link pos-relative fleft">
					<img src="<c:url value='/images/show/jnk/9.jpg'/>"/>
					<span class="index-info-block sbg4">Show It</span>
				</a>
			</div>
		</div>
		<jsp:include page="footer.jsp" flush="true"/>
	</div>
</div>
</div>
<script src="<c:url value='/js/lufter/index.js'/>"></script>
</body>
</html>