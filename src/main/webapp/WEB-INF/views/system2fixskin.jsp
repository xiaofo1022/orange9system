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
	<jsp:include page="system2header.jsp" flush="true"/>
	
	<jsp:include page="system2sidebar.jsp" flush="true"/>
	
	<div id="st-trigger-effects">
		<button class="btn btn-warning nav-btn" data-effect="st-effect-3">
			<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		</button>
	</div>
	
	<c:forEach items="${fixSkinList}" var="fixSkin">
		<input type="hidden" id="${fixSkin.id}" class="fix-start-time" value="${fixSkin.insertTime}"/>
		<div class="order-block">
			<p class="model-label transfer-label">
				共计：
				<span style="color:#428BCA;">${fixSkin.imageCount} </span>张
				<span id="time-label-${fixSkin.id}" class="ml10" style="color:#F0AD4E;">剩余时间：</span>
				<span id="remain-time-${fixSkin.id}"></span>
				<input type="hidden" id="limit-minutes-${fixSkin.id}" value="${fixSkin.limitMinutes}"/>
			</p>
			<p class="model-label transfer-label">
				设计师：
				<img src="${fixSkin.operator.header}"/><span class="ml10">${fixSkin.operator.name}</span>
			</p>
			<div id="time-progress-bar-${fixSkin.id}" class="progress" style="margin-bottom:0;">
				<div id="time-bar-${fixSkin.id}" class="progress-bar progress-bar-success" role="progressbar"
					aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:0%">
				</div>
			</div>
		</div>
	</c:forEach>
</div>
</div>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script src="<c:url value='/js/util/countDown.js'/>"></script>
<script>
	$(".fix-start-time").each(function(index, element) {
		if (element.value != 0) {
			var id = element.id;
			var startTime = new Date();
			var limitSecond = parseInt($("#limit-minutes-" + id).val()) * 60;
			startTime.setTime(element.value);
			new CountDown(startTime, limitSecond, "time-bar-" + id, "time-label-" + id, "remain-time-" + id);
		}
	});
</script>
</body>
</html>