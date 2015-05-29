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
	
	<c:forEach items="${orderConvertList}" var="orderConvert">
		<input type="hidden" id="${orderConvert.id}" class="convert-time" value="${orderConvert.insertTime}"/>
		<div class="order-block">
			<p class="model-label transfer-label">
				单号：<a href="<c:url value='/order/orderDetail/${orderConvert.orderId}'/>" target="_blank">${orderConvert.orderNo}</a>
				<c:if test="${orderConvert.operatorId != 0}">
					<span id="time-label-${orderConvert.id}" class="ml10" style="color:#F0AD4E;">剩余时间：</span>
					<span id="remain-time-${orderConvert.id}"></span>
				</c:if>
			</p>
			<c:if test="${orderConvert.operatorId != 0}">
				<p class="model-label transfer-label">
					图片：<span style="color:#428BCA;">${orderConvert.fileNames}</span>
				</p>
			</c:if>
			<p class="model-label transfer-label">
				导图：
				<c:choose>
					<c:when test="${orderConvert.operatorId != 0}">
						<img src="${orderConvert.operator.header}"/><span class="ml10">${orderConvert.operator.name}</span>
						<c:choose>
							<c:when test="${orderConvert.operatorId == user.id}">
								<button id="btn-convert-done-${orderConvert.id}" class="btn btn-success ml10" onclick="confirmConvertComplete(${orderConvert.orderId}, ${orderConvert.id})">完成</button>
							</c:when>
							<c:otherwise>
								<c:if test="${user.isAdmin == 1}">
									<button id="btn-urge-${orderConvert.id}" class="btn btn-danger" onclick="urge(${orderConvert.operatorId}, '${orderConvert.orderNo}', this.id)">催一下</button>
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:if test="${user.isAdmin == 1}">
							<button class="btn btn-info" onclick="showSetConvertWindow(${orderConvert.orderId})">指定</button>
						</c:if>
					</c:otherwise>
				</c:choose>
			</p>
			<c:if test="${orderConvert.operatorId != 0}">
				<div id="time-progress-bar-${orderConvert.id}" class="progress" style="margin-bottom:0;">
					<div id="time-bar-${orderConvert.id}" class="progress-bar progress-bar-success" role="progressbar"
						aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:0%">
					</div>
				</div>
			</c:if>
		</div>
	</c:forEach>
	
	<div id="setConvertModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">要指定谁来导图呢？</h4>
				</div>
				<div class="modal-body">	
					<div style="width:200px;">
						<select id="convertorSelect" class="form-control">
							<c:forEach items="${userList}" var="user">
								<option value="${user.id}">${user.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="modal-footer">
					<button id="btnSetTransfer" type="button" class="btn btn-primary" onclick="setConvert()">确定</button>
				</div>
			</div>
			<input type="hidden" id="orderId"/>
		</div>
	</div>
</div>
</div>
<input type="hidden" id="user-id" value="${user.id}"/>
<input type="hidden" id="limitMinutes" value="${limitMinutes}"/>
<input type="hidden" id="picbaseurl" value="${user.picbaseurl}"/>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script src="<c:url value='/js/util/countDown.js'/>"></script>
<script>
	var userId = $("#user-id").val();
	var notification = new Notification(userId, "<c:url value='/'/>");

	function urge(receiverId, orderNo, btnId) {
		notification.send(receiverId, orderNo, "导图", btnId);
	}
	
	function showSetConvertWindow(orderId) {
		$("#orderId").val(orderId);
		$("#setConvertModal").modal("show");
	}

	function setConvert() {
		var orderId = $("#orderId").val();
		var userId = $("#convertorSelect").val();
		$.post("<c:url value='/orderConvert/setOrderConvertor/" + orderId + "/" + userId + "'/>", null, function(data, status) {
			if (data.status == "success") {
				location.reload(true);
			} else {
				console.log(data);
			}
		});
	}
	
	var limitSecond = parseInt($("#limitMinutes").val()) * 60;
	
	$(".convert-time").each(function(index, element) {
		if (element.value != 0) {
			var id = element.id;
			var startTime = new Date();
			startTime.setTime(element.value);
			new CountDown(startTime, limitSecond, "time-bar-" + id, "time-label-" + id, "remain-time-" + id);
		}
	});
	
	function confirmConvertComplete(orderId, convertId) {
		$.get($("#picbaseurl").val() + "checkConvertImage/" + orderId, function(data, status) {
			if (data.result) {
				$.post("<c:url value='/orderConvert/setOrderConvertDone/" + orderId + "/" + convertId + "'/>", null, function(data, status) {
					if (data.status == "success") {
						location.reload(true);
					} else {
						console.log(data);
					}
				});
			} else {
				alert(data.message);
			}
		});
	}
</script>
</body>
</html>