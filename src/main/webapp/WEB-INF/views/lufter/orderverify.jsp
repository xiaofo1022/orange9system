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
<link href="<c:url value='/css/jquery-ui/jquery-ui.css'/>" rel="stylesheet"/>
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<body>
<jsp:include page="header.jsp" flush="true">
	<jsp:param name="page" value=""/>
</jsp:include>

<div id="verifyModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">图片审核</h4>
			</div>
			<div id="verifyImageContainer" class="modal-body verify-image">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" onclick="showDenialWindow()">不通过</button>
				<button type="button" class="btn btn-success" onclick="setVerified()">通过</button>
			</div>
			<input type="hidden" id="fixed-image-id"/>
		</div>
	</div>
</div>

<div id="denialModal" class="modal fade text-left" style="z-index:1999;" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">原因</h4>
			</div>
			<div class="modal-body">
				<textarea id="denial-reason" class="form-control" rows="4" maxlength="100"></textarea>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" onclick="setDenied()">确定</button>
			</div>
		</div>
	</div>
</div>

<input type="hidden" id="orderId"/>
	
<div class="container">
<div class="row">

	<div class="col-sm-8 blog-main">
		<c:forEach items="${orderVerifyList}" var="orderVerify">
			<div class="data-block">
				<div class="clearfix">
					<div class="data-title lofter-bc">
					单号 <a href="<c:url value='/order/orderDetail/${orderVerify.orderId}'/>" target="_blank">${orderVerify.orderNo}</a>
					</div>
				</div>
				<div class="clearfix">
					<div class="data-info progress-bc">已审核 ${orderVerify.verifiedCount}</div>
					<div class="data-info netease-bc">未通过 ${orderVerify.deniedCount}</div>
					<div class="data-info twitter-bc">待审核 ${orderVerify.verifyCount}</div>
					<c:if test="${user.isAdmin == 1}">
						<button class="btn btn-info btn-data-info" onclick="startVerify(${orderVerify.orderId})">开始审核</button>
					</c:if>
				</div>
			</div>
		</c:forEach>
	</div>
	
	<jsp:include page="panel.jsp" flush="true">
		<jsp:param name="link" value="verify"/>
	</jsp:include>
</div>
</div>
<script src="<c:url value='/js/util/ajax-util.js'/>"></script>
<script>
	function startVerify(orderId) {
		$("#orderId").val(orderId);
		getVerifyImage(orderId);
		$("#verifyModal").modal("show");
	}

	$('#verifyModal').on('hidden.bs.modal', function (e) {
		location.reload(true);
	});

	$('#denialModal').on('hidden.bs.modal', function (e) {
		$("#denial-reason").val("");
	});
	
	function showSetVerifierWindow(orderId) {
		$("#orderId").val(orderId);
		$("#setVerifyModal").modal("show");
	}
	
	function showDenialWindow() {
		$("#denialModal").modal("show");
	}
	
	function setVerifier() {
		var orderId = $("#orderId").val();
		var userId = $("#verifySelect").val();
		$.post("<c:url value='/orderVerify/setOrderVerifier/" + orderId + "/" + userId + "'/>", null, function(data, status) {
			if (data.status == "success") {
				location.reload(true);
			} else {
				console.log(data);
			}
		});
	}
	
	function getVerifyImage(orderId) {
		$.get("<c:url value='/orderVerify/getVerifyImageData/" + orderId + "'/>", function(data, status) {
			if (data && data.id != 0) {
				$("#fixed-image-id").val(data.id);
				$("#verifyImageContainer").html("<img src='<c:url value='/pictures/fixed/" + data.orderId + "/compress/" + data.fileName + ".jpg'/>'/>");
			} else {
				$("#verifyModal").modal("hide");
			}
		});
	}
	
	function setVerified() {
		var fixedImageId = $("#fixed-image-id").val();
		$.post("<c:url value='/orderVerify/setImageVerified/" + fixedImageId + "'/>", null, function(data, status) {
			getVerifyImage($("#orderId").val());
		});
	}
	
	function setDenied() {
		var fixedImageId = $("#fixed-image-id").val();
		var reason = $("#denial-reason").val();
		AjaxUtil.post("<c:url value='/orderVerify/setImageDenied'/>", {id:fixedImageId, reason:reason}, function(data, status) {
			$("#denialModal").modal("hide");
			getVerifyImage($("#orderId").val());
		});
	}
</script>
</body>
</html>