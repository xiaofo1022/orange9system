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
	
	<div id="transferContainer"></div>
	
	<jsp:include page="system2uploadimage.jsp"/>
</div>
</div>
<input type="hidden" id="limitMinutes" value="${limitMinutes}"/>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script src="<c:url value='/js/util/countDown.js'/>"></script>
<script src="<c:url value='/js/util/transferUploader.js'/>"></script>
<script>
	var limitSecond = parseInt($("#limitMinutes").val()) * 60;
	
	init();
	
	function init() {
		$("#upload-url").val("<c:url value='/orderTransfer/uploadTransferImage'/>");
		$.get("<c:url value='/orderTransfer/getOrderList'/>", function(list, status) {
			if (list) {
				var container = $("#transferContainer");
				var transferHtml = "";
				for (var i in list) {
					var data = list[i];
					transferHtml += '<div class="order-block">';
					transferHtml += getTransferHeader(data);
					transferHtml += getTransferInfo(data);
					transferHtml += getTransferBar(data);
					transferHtml += '</div>';
				}
				container.html(transferHtml);
				for (var i in list) {
					var data = list[i];
					var id = data.id;
					var startTime = new Date();
					startTime.setTime(data.insertDatetime);
					new CountDown(startTime, limitSecond, "time-bar-" + id, "time-label-" + id, "remain-time-" + id);
				}
			}
		});
	}
	
	function getTransferHeader(data) {
		return '<p class="model-label transfer-label">'
			+ '单号：<a href="<c:url value="/order/orderDetail/' + data.orderId + '"/>" target="_blank">O9' + data.orderId + '</a><span id="time-label-' + data.id + '" class="ml10" style="color:#F0AD4E;">'
			+ '剩余时间：</span><span id="remain-time-' + data.id + '"></span></p>';
	}
	
	function getTransferInfo(data) {
		return '<p class="model-label transfer-label">'
			+ '摄影师：<img src="' + data.operator.header + '"/><span class="ml10">' + data.operator.name + '</span>'
			+ '<button id="btn-transfer-' + data.id + '" class="btn btn-info ml10" onclick="openUploadImageWindow(' + data.id + ', ' + data.orderId + ')">上传</button>'
			+ '<button id="btn-transfer-done-' + data.id + '" class="btn btn-success ml10" onclick="setTransferComplete(' + data.id + ', ' + data.orderId + ')">完成</button></p>';
	}
	
	function getTransferBar(data) {
		return '<div id="time-progress-bar-' + data.id + '" class="progress" style="margin-bottom:0;">'
			+ '<div id="time-bar-' + data.id + '" class="progress-bar progress-bar-success" role="progressbar"'
			+ 'aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:0%"></div></div>';	
	}
	
	function openUploadImageWindow(orderTransferId, orderId) {
		$("#orderTransferImageId").val(orderTransferId);
		$("#orderId").val(orderId);
		$("#uploadImagesModal").modal("show");
	}
	
	function setTransferComplete(orderTransferId, orderId) {
		var result = confirm("确定原片已上传完成吗？");
		if (result) {
			$.ajax({  
	            url: "<c:url value='/orderTransfer/setTransferImageIsDone/" + orderId + "/" + orderTransferId + "'/>",  
	            type: 'post',
	            success: function(data) {
	            	location.reload(true);
	            },  
	            error: function(data) {
	                console.log(data);
	            }  
	        });
		}
	}
</script>
</body>
</html>