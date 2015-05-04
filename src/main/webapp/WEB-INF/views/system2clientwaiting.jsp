<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orange 9 System</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap-system.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system/order.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system/orderdetail.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/sidebar/component.css'/>" />
<script src="<c:url value='/js/jquery-1.11.2.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
</head>
<body>
<div id="st-container" class="st-container">
<div class="st-pusher">
	<div style="text-align:center;">
		<p class="login-header"><span>ORANGE</span> 9 SYSTEM</p>
	</div>
	
	<jsp:include page="system2sidebar.jsp" flush="true"/>
	
	<div id="st-trigger-effects">
		<button class="btn btn-warning nav-btn" data-effect="st-effect-3">
			<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		</button>
	</div>
	
	
	<c:forEach items="${orderList}" var="order">
		<div class="order-block">
			<p class="model-label transfer-label">
				单号：<a href="<c:url value='/order/orderDetail/${order.id}'/>" target="_blank">#O9${order.id}</a>
				<button class="btn btn-warning btn-sm">提醒一下</button>
			</p>
			<p class="model-label transfer-label">
				名称：<span class="oc-label">${order.client.clientName}</span>
				店铺：<a href="http://${order.client.clientShopLink}" target="_blank">${order.client.clientShopName}</a>
				电话：<span class="oc-label">${order.client.clientPhone}</span>
				邮箱：<span class="oc-label">${order.client.clientEmail}</span>
			</p>
			<c:if test="${order.client.clientRemark != null && !order.client.clientRemark.equals('')}">
				<p class="model-label transfer-label">
					备注：<span class="oc-label">${order.client.clientRemark}</span>
				</p>
			</c:if>
		</div>
	</c:forEach>
</div>
</div>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script>
</script>
</body>
</html>