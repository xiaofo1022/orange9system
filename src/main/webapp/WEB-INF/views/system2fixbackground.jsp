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
	
	<c:forEach items="${postProductionList}" var="fixBackground">
		<input type="hidden" id="${fixBackground.id}" class="fix-start-time" value="${fixBackground.insertTime}"/>
		<div class="order-block">
			<p class="model-label transfer-label">
				共计：
				<span style="color:#428BCA;">${fixBackground.imageCount} </span>张
				<span id="time-label-${fixBackground.id}" class="ml10" style="color:#F0AD4E;">剩余时间：</span>
				<span id="remain-time-${fixBackground.id}"></span>
				<input type="hidden" id="limit-minutes-${fixBackground.id}" value="${fixBackground.limitMinutes}"/>
			</p>
			<p class="model-label transfer-label">
				设计师：
				<img src="${fixBackground.operator.header}"/><span class="ml10">${fixBackground.operator.name}</span>
				<c:if test="${user.isAdmin == 1}">
					<button id="btn-urge-${fixBackground.id}" class="btn btn-danger" onclick="urge(${fixBackground.operator.id}, '', this.id)">催一下</button>
				</c:if>
			</p>
			<div id="time-progress-bar-${fixBackground.id}" class="progress" style="margin-bottom:0;">
				<div id="time-bar-${fixBackground.id}" class="progress-bar progress-bar-success" role="progressbar"
					aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:0%">
				</div>
			</div>
		</div>
	</c:forEach>
</div>
</div>
<input type="hidden" id="user-id" value="${user.id}"/>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script src="<c:url value='/js/util/countDown.js'/>"></script>
<script>
	var userId = $("#user-id").val();
	var notification = new Notification(userId, "<c:url value='/'/>");
	
	function urge(receiverId, orderNo, btnId) {
		notification.send(receiverId, orderNo, "修背景", btnId);
	}

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