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
		<div class="order-block clearfix">
			<p class="model-label transfer-label">
				单号：<a href="<c:url value='/order/orderDetail/${orderConvert.orderId}'/>" target="_blank">${orderConvert.orderNo}</a>
				<span id="time-label-${orderConvert.id}" class="ml10" style="color:#F0AD4E;">剩余时间：</span>
				<span id="remain-time-${orderConvert.id}"></span>
				<c:if test="${user.isAdmin == 1}">
					<button id="btn-confirm-${orderConvert.orderId}" class="btn btn-success fright" onclick="confirmConvertComplete(${orderConvert.orderId}, ${orderConvert.id})">导图完成</button>
					<button id="btn-upload-${orderConvert.orderId}" class="btn btn-info fright mr10" onclick="completePostProduction(${orderConvert.orderId})">图片上传</button>
				</c:if>
			</p>
			<p class="model-label transfer-label">
				图片：<span style="color:#428BCA;">${orderConvert.fileNames}</span>
			</p>
			<div id="time-progress-bar-${orderConvert.id}" class="progress" style="margin-bottom:0;">
				<div id="time-bar-${orderConvert.id}" class="progress-bar progress-bar-success" role="progressbar"
					aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:0%">
				</div>
			</div>
		</div>
	</c:forEach>
	<input class="hidden" multiple="multiple" type="file" id="complete-post-production"/>
</div>
</div>
<input type="hidden" id="user-id" value="${user.id}"/>
<input type="hidden" id="limitMinutes" value="${limitMinutes}"/>
<input type="hidden" id="picbaseurl" value="${user.picbaseurl}"/>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script src="<c:url value='/js/util/countDown.js'/>"></script>
<script src="<c:url value='/js/util/ajax-util.js'/>"></script>
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
		$.get("<c:url value='/picture/checkConvertImage/" + orderId + "'/>", function(data, status) {
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
	
	var compOrderId;
	var uploadButtonId;
	var confirmButtonId;
	
	$("#complete-post-production").bind("change", function(event) {
		$("#" + uploadButtonId).attr("disabled", true);
		$("#" + confirmButtonId).attr("disabled", true);
		$("#" + uploadButtonId).text("上传中...");
		$("#" + confirmButtonId).text("上传中...");
		var orderId = compOrderId;
		var files = event.target.files;
		var completeCount = 0;
		for (var index in files) {
			var file = files[index];
			if (file != null && file.name != null && file.name != undefined) {
				var frontName = file.name.split(".")[0];
				var reader = new FileReader();
				reader.frontName = frontName;
				reader.onload = function(event) {
					var base64Data = event.target.result.split(",")[1];
					var frontName = this.frontName;
					AjaxUtil.post("<c:url value='/picture/saveOriginalPicture'/>", {orderId:orderId, fileName:this.frontName, base64Data:base64Data}, function(data) {
						if (data) {
							completeCount++;
							if (completeCount == files.length) {
								location.reload(true);
							}
						}
					});
				};
				try {
					reader.readAsDataURL(file);
				} catch (exp) {
				}
			}
		}
	});
	
	function completePostProduction(orderId) {
		compOrderId = orderId;
		uploadButtonId = "btn-upload-" + orderId;
		confirmButtonId = "btn-confirm-" + orderId;
		$("#complete-post-production").click();
	}
</script>
</body>
</html>