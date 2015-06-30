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
<link rel="icon" href="<c:url value="/images/favicon.ico"/>" type="image/x-icon" /> 
<link rel="shortcut icon" href="<c:url value="/images/favicon.ico"/>" type="image/x-icon" />
<link href="<c:url value='/css/bootstrap.lufter.css'/>" rel="stylesheet"/>
<link href="<c:url value='/css/lufter/lufter.css'/>" rel="stylesheet"/>
<link href="<c:url value='/css/jquery-ui/jquery-ui.css'/>" rel="stylesheet"/>
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<body>
<jsp:include page="header.jsp" flush="true">
	<jsp:param name="page" value=""/>
</jsp:include>
	
<div class="container">
<div class="row">

	<div class="col-sm-8 blog-main">
		<c:forEach items="${orderList}" var="order">
			<div class="data-block">
				<div class="clearfix">
					<div class="data-title lofter-bc">
					单号 <a href="<c:url value='/order/orderDetail/${order.id}'/>" target="_blank">${order.orderNo}</a>
					<c:if test="${order.client.clientRemark != null && !order.client.clientRemark.equals('')}">
						[${order.client.clientRemark}]
					</c:if>
					</div>
				</div>
				<div class="clearfix">
					<div class="data-info taobao-bc">客户</div>
					<div class="data-info taobao-bc">${order.client.clientName}</div>
					<div class="data-info taobao-bc">淘宝 <a href="http://${order.client.clientShopLink}" target="_blank">${order.client.clientShopName}</a></div>
					<div class="data-info taobao-bc">${order.client.clientPhone}</div>
					<div class="data-info taobao-bc">${order.client.clientEmail}</div>
				</div>
			</div>
		</c:forEach>
	</div>
	
	<jsp:include page="panel.jsp" flush="true">
		<jsp:param name="link" value="clientchosen"/>
	</jsp:include>
</div>
</div>
</body>
</html>