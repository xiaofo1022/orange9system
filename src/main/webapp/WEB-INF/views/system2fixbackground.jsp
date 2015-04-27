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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system/transfer.css'/>"/>
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
	
	<c:forEach items="${postProductionList}" var="postProduction">
		<input type="hidden" id="${postProduction.id}" class="fix-start-time" value="${postProduction.insertTime}"/>
		<div class="order-block">
			<p class="model-label transfer-label">
				单号：<a href="<c:url value='/order/orderDetail/${postProduction.orderId}'/>" target="_blank">O9${postProduction.orderId}</a>
			</p>
			<p class="model-label transfer-label">
				图片：<span style="color:#428BCA;">${postProduction.fileNames}</span>
			</p>
			<p class="model-label transfer-label">
				共计：
				<span style="color:#428BCA;">${postProduction.imageCount} </span>张
				<span class="oc-label">用时：</span>
				${postProduction.timeCost}
			</p>
			<p class="model-label transfer-label">
				设计师：
				<img src="${postProduction.operator.header}"/><span class="ml10">${postProduction.operator.name}</span>
				<button id="btn-fix-done-${postProduction.id}" class="btn btn-success ml10" onclick="setFixSkinDone(${postProduction.orderId}, ${postProduction.operator.id})">完成</button>
			</p>
		</div>
	</c:forEach>
</div>
</div>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script>
	function setFixSkinDone(orderId, userId) {
		var result = confirm("是否确定修背景已完成？");
		if (result) {
			$.post("<c:url value='/orderPostProduction/setFixBackgroundDone/" + orderId + "/" + userId + "'/>", null, function(data, status) {
				if (data.status == "success") {
					location.reload(true);
				}
			});
		}
	}
</script>
</body>
</html>