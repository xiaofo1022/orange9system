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
<link rel="icon" href="<c:url value="/images/favicon.ico"/>" type="image/x-icon" /> 
<link rel="shortcut icon" href="<c:url value="/images/favicon.ico"/>" type="image/x-icon" />
<link href="<c:url value='/css/bootstrap.lufter.css'/>" rel="stylesheet"/>
<link href="<c:url value='/css/lufter/lufter.css'/>" rel="stylesheet"/>
<link href="<c:url value='/css/lufter/upload.css'/>" rel="stylesheet"/>
<link href="<c:url value='/css/jquery-ui/jquery-ui.css'/>" rel="stylesheet"/>
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/js/util/ajax-util.js'/>"></script>
<body>
<jsp:include page="header.jsp" flush="true">
	<jsp:param name="page" value=""/>
</jsp:include>
	
<input type="hidden" id="user-id" value="${user.id}"/>
<input type="hidden" id="is-admin" value="${user.isAdmin}"/>
<input type="hidden" id="limitMinutes" value="${limitMinutes}"/>

<div class="container">
<div class="row">

	<div class="col-sm-8 blog-main">
		<c:forEach items="${orderTransferList}" var="orderTransfer">
			<div class="data-block">
				<input type="hidden" id="${orderTransfer.id}" class="convert-time" value="${orderTransfer.insertDatetime.getTime()}"/>
				<div class="clearfix">
					<div class="data-info lofter-bc">
					单号 <a href="<c:url value='/order/orderDetail/${orderTransfer.orderId}'/>" target="_blank">${orderTransfer.orderNo}</a>
					</div>
					<div class="data-info lofter-bc">
						<span id="time-label-${orderTransfer.id}">剩余时间</span> 
						<span id="remain-time-${orderTransfer.id}"></span>
					</div>
				</div>
				<div class="clearfix">
					<div class="data-info facebook-bc order-detail-header">摄影师 ${orderTransfer.operator.name} <img src="${orderTransfer.operator.header}"/></div>
					<div class="data-info facebook-bc">已上传 ${orderTransfer.imageDataCount} 张</div>
					<button id="btn-upload-${orderTransfer.orderId}" class="btn btn-info btn-data-info" onclick="completePostProduction(${orderTransfer.id}, ${orderTransfer.orderId})">上传</button>
					<button id="btn-confirm-${orderTransfer.orderId}" class="btn btn-success btn-data-info" onclick="setTransferComplete(${orderTransfer.id}, ${orderTransfer.orderId})">完成</button>
				</div>
				<div id="time-progress-bar-${orderTransfer.id}" class="progress" style="margin-bottom:0;">
					<div id="time-bar-${orderTransfer.id}" class="progress-bar progress-bar-success" role="progressbar"
						aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:0%">
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	
	<jsp:include page="panel.jsp" flush="true">
		<jsp:param name="link" value="uploadoriginal"/>
	</jsp:include>
	
	<jsp:include page="uploadimagemodal.jsp" flush="true"/>
</div>
</div>
<script src="<c:url value='/js/util/countDown.js'/>"></script>
<script>
	var limitSecond = parseInt($("#limitMinutes").val()) * 60;
	
	init();
	
	function init() {
		$("#upload-url").val("<c:url value='/orderTransfer/uploadTransferImage'/>");
		$(".convert-time").each(function(index, element) {
			if (element.value != 0) {
				var id = element.id;
				var startTime = new Date();
				startTime.setTime(element.value);
				new CountDown(startTime, limitSecond, "time-bar-" + id, "time-label-" + id, "remain-time-" + id);
			}
		});
	}
	
	var compTransferId;
	
	$("#uploadImagesModal").on("hide.bs.modal", function(e) {
		e.preventDefault();
		return;
	});
	
	function completePostProduction(transferId, orderId) {
		compTransferId = transferId;
		compOrderId = orderId;
		uploadUrl = "<c:url value='/orderTransfer/uploadTransferImage'/>";
		$("#complete-post-production").click();
	}
	
	function setTransferComplete(orderTransferId, orderId) {
		$.get("<c:url value='/orderTransfer/getTransferImageCount/" + orderId + "'/>", function(data) {
			if (data && data.cnt > 0) {
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
			} else {
				alert("还未上传原片");
			}
		});
	}
</script>
</body>
</html>