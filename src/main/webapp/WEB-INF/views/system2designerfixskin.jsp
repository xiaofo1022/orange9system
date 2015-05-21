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
<style>
	div.post-pic-block {
		border:1px solid #F0AD4E;
		margin:20px;
	}
	
	div.post-pic-block img {
		float:left;
		width:160px;
	}
	
	div.post-pic-block a:hover {
		cursor:pointer;
	}
	
	div.post-pic-border {
		float:left;
		margin:10px;
	}
</style>
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
	
	<div id="blink1-block" class="detail-bottom-block post-pic-block">
		<c:forEach items="${postProduction.imageDataList}" var="imageData">
			<div class="post-pic-border">
				<img src="<c:url value='/pictures/original/${imageData.orderId}/${imageData.id}.jpg'/>"/>
				<p id="client-pic-label-${imageData.id}">(${imageData.fileName})</p>
				<p>
					<a href="<c:url value='/order/orderDetail/${imageData.orderId}'/>" target="_blank">#O9${imageData.orderId}</a>
					<a href='${user.picbaseurl}/downloadPicture/${imageData.orderId}/${imageData.fileName}'>下载</a>
					<a onclick="completePostProduction(${imageData.id}, ${imageData.orderId}, '${imageData.fileName}')">完成</a>
				</p>
				<div class="clear"></div>
			</div>
		</c:forEach>
		<div class="clear"></div>
	</div>
	<input class="hidden" type="file" id="complete-post-production"/>
	<input type="hidden" id="picbaseurl" value="${user.picbaseurl}"/>
	<iframe id="postframe" name="postframe" class="hidden" src="picframe"></iframe>
</div>
</div>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script src="<c:url value='/js/util/ajax-util.js'/>"></script>
<script>
	var picbaseurl = $("#picbaseurl").val() + "saveFixSkinPicture";
	var frame = window.frames["postframe"].document;
	var compId;
	var compOrderId;
	var compFileName;
	var reader = new FileReader();
	
	reader.onload = function(event) {
		var base64Data = event.target.result.split(",")[1];
		$(window.frames["postframe"].document).find("#orderId").val(compOrderId);
		$(window.frames["postframe"].document).find("#fileName").val(compFileName);
		$(window.frames["postframe"].document).find("#base64Data").val(base64Data);
		$(window.frames["postframe"].document).find("#postForm").attr("action", picbaseurl);
		$(window.frames["postframe"].document).find("#postForm").submit();
		$.post("<c:url value='/orderPostProduction/setFixSkinDone/" + compId + "'/>", null, function(data, status) {
			if (data.status == "success") {
				location.reload(true);
			}
		});
	};
	
	$("#complete-post-production").bind("change", function(event) {
		var img = event.target.files[0];
		if (!img) {
			return;
		}
		var frontName = img.name.split(".")[0];
		if (frontName != compFileName) {
			alert("应选择图片" + compFileName + ".jpg");
			return;
		}
		reader.readAsDataURL(img);
	});
	
	function completePostProduction(id, orderId, fileName) {
		compId = id;
		compOrderId = orderId;
		compFileName = fileName;
		$("#complete-post-production").click();
	}
</script>
</body>
</html>