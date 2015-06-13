<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="xiaofo">
<title>Orange 9</title>
<link href="<c:url value='/css/bootstrap.lufter.css'/>" rel="stylesheet"/>
<link href="<c:url value='/css/lufter/lufter.css'/>" rel="stylesheet"/>
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<body>
<jsp:include page="header.jsp" flush="true">
	<jsp:param name="page" value=""/>
</jsp:include>
	
<div class="container">
<div class="row">

	<div class="col-sm-8 blog-main">
		<c:forEach items="${orderConvertList}" var="orderConvert">
			<div class="data-block">
				<input type="hidden" id="${orderConvert.id}" class="convert-time" value="${orderConvert.insertTime}"/>
				<div class="clearfix">
					<div class="data-info lofter-bc">
					单号 <a href="<c:url value='/order/orderDetail/${orderConvert.orderId}'/>" target="_blank">${orderConvert.orderNo}</a>
					</div>
					<div class="data-info lofter-bc">
						<span id="time-label-${orderConvert.id}" class="ml10" style="color:#F0AD4E;">剩余时间：</span>
						<span id="remain-time-${orderConvert.id}"></span>
					</div>
				</div>
				<div class="clearfix">
					<div class="data-info facebook-bc">图片</div>
					<c:if test="${user.isAdmin == 1}">
						<button id="btn-upload-${orderConvert.orderId}" class="btn btn-info btn-data-info" onclick="completePostProduction(${orderConvert.orderId})">上传</button>
						<button id="btn-confirm-${orderConvert.orderId}" class="btn btn-success btn-data-info" onclick="confirmConvertComplete(${orderConvert.orderId}, ${orderConvert.id})">完成</button>
					</c:if>
				</div>
				<div class="clearfix">
					<div class="data-info facebook-bc">${orderConvert.fileNames}</div>
				</div>
				<div id="time-progress-bar-${orderConvert.id}" class="progress" style="margin-bottom:0;">
					<div id="time-bar-${orderConvert.id}" class="progress-bar progress-bar-success" role="progressbar"
						aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:0%">
					</div>
				</div>
			</div>
		</c:forEach>
		<input class="hidden" multiple="multiple" type="file" id="complete-post-production"/>
		<input type="hidden" id="user-id" value="${user.id}"/>
		<input type="hidden" id="limitMinutes" value="${limitMinutes}"/>
	</div>
	
	<jsp:include page="panel.jsp" flush="true">
		<jsp:param name="link" value="convertimage"/>
	</jsp:include>
</div>
</div>
<script src="<c:url value='/js/util/countDown.js'/>"></script>
<script src="<c:url value='/js/util/ajax-util.js'/>"></script>
<script>
	var userId = $("#user-id").val();
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