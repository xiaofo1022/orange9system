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
	
	<c:forEach items="${orderShootList}" var="orderShoot">
		<input type="hidden" id="${orderShoot.id}" class="convert-time" value="${orderShoot.shootTime}"/>
		<div class="order-block">
			<p class="model-label transfer-label">
				单号：<a href="<c:url value='/order/orderDetail/${orderShoot.id}'/>" target="_blank">O9${orderShoot.id}</a>
				<span id="time-label-${orderShoot.id}" class="ml10" style="color:#F0AD4E;">剩余时间：</span>
				<span id="remain-time-${orderShoot.id}"></span>
			</p>
			<p class="model-label transfer-label">
				摄影师：
				<img src="${orderShoot.photographer.header}"/><span class="ml10">${orderConvert.photographer.name}</span>
				<button id="btn-convert-done-${orderShoot.id}" class="btn btn-success ml10" onclick="confirmShootComplete(${orderShoot.id}, ${orderShoot.photographerId})">完成</button>
			</p>
			<div id="time-progress-bar-${orderShoot.id}" class="progress" style="margin-bottom:0;">
				<div id="time-bar-${orderShoot.id}" class="progress-bar progress-bar-success" role="progressbar"
					aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:0%">
				</div>
			</div>
		</div>
	</c:forEach>
</div>
</div>
<input type="hidden" id="limitMinutes" value="${limitMinutes}"/>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script src="<c:url value='/js/util/countDown.js'/>"></script>
<script>
	var limitSecond = parseInt($("#limitMinutes").val()) * 60;
	
	$(".convert-time").each(function(index, element) {
		if (element.value != 0) {
			var id = element.id;
			var startTime = new Date();
			startTime.setTime(element.value);
			new CountDown(startTime, limitSecond, "time-bar-" + id, "time-label-" + id, "remain-time-" + id);
		}
	});
	
	function confirmShootComplete(orderId, photographerId) {
		var result = confirm("是否确认拍摄完成？");
		if (result) {
			$.post("<c:url value='/order/setOrderTransfer/" + orderId + "/" + photographerId + "'/>", null, function(data, status) {
				if (data.status == "success") {
					location.reload(true);
				} else {
					console.log(data);
				}
			});
		}
	}
</script>
</body>
</html>