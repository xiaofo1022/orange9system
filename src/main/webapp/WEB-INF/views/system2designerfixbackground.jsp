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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system/post.css'/>"/>
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
	
	<c:forEach items="${postProductionList}" var="postProduction">
		<div style="margin-left:20px;margin-top:10px;margin-bottom:-10px;">
			单号：<a href="<c:url value='/order/orderDetail/${postProduction.orderId}'/>" target="_blank">${postProduction.orderNo}</a>
			<c:if test="${user.isAdmin == 1 || user.id == postProduction.operatorId}">
				<button id="btn-confirm-${postProduction.orderId}" class="btn btn-info" onclick="downloadZip(${postProduction.orderId})">打包下载</button>
				<button id="btn-upload-${postProduction.orderId}" class="btn btn-success" onclick="completePostProduction(${postProduction.orderId})">批量上传</button>
				<button class="btn btn-warning" onclick="nextStep(${postProduction.orderId})">修图完成</button>
			</c:if>
		</div>
		<div id="blink1-block" class="detail-bottom-block post-pic-block">
			<c:forEach items="${postProduction.imageDataList}" var="imageData">
				<div class="post-pic-border">
					<img src="<c:url value='/pictures/original/${imageData.orderId}/${imageData.id}.jpg'/>"/>
					<p id="client-pic-label-${imageData.id}">(${imageData.fileName})</p>
					<div class="clear"></div>
				</div>
			</c:forEach>
			<div class="clear"></div>
		</div>
	</c:forEach>
	<input class="hidden" multiple="multiple" type="file" id="complete-post-production"/>
	<input type="hidden" id="picbaseurl" value="${user.picbaseurl}"/>
</div>
</div>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script src="<c:url value='/js/util/ajax-util.js'/>"></script>
<script>
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
					AjaxUtil.post("<c:url value='/picture/saveFixBackgroundPicture'/>", {orderId:orderId, fileName:this.frontName, base64Data:base64Data}, function(data) {
						if (data) {
							$.post("<c:url value='/orderPostProduction/setFixBackgroundDone/" + orderId + "/" + frontName + "'/>", null, function(data, status) {
								if (data.status == "success") {
									completeCount++;
									if (completeCount == files.length) {
										location.reload(true);
									}
								}
							});
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
	
	function downloadZip(orderId) {
		window.open("<c:url value='/picture//downloadFixSkinPicture/" + orderId + "'/>");
	}
	
	function nextStep(orderId) {
		$.post("<c:url value='/orderPostProduction/setFixBackgroundNextStep/" + orderId + "'/>", null, function(data, status) {
			if (data.status == "success") {
				location.reload(true);
			}
		});
	}
</script>
</body>
</html>