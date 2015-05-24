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
	
	<c:forEach items="${orderVerifyList}" var="orderVerify">
		<div class="order-block">
			<p class="model-label transfer-label">
				单号：<a href="<c:url value='/order/orderDetail/${orderVerify.orderId}'/>" target="_blank">O9${orderVerify.orderId}</a>
			</p>
			<p class="model-label transfer-label">
				已审核
				<span style="color:#5CB85C;">${orderVerify.verifiedCount}</span>
				未通过
				<span style="color:#D9534F;">${orderVerify.deniedCount}</span>
				待审核
				<span style="color:#31B0D5;">${orderVerify.verifyCount}</span>
				<c:choose>
					<c:when test="${orderVerify.operatorId != 0}">
						<img src="${orderVerify.operator.header}"/><span class="ml10">${orderVerify.operator.name}</span>
						<c:if test="${orderVerify.operatorId == user.id}">
							<button class="btn btn-info ml10" onclick="startVerify(${orderVerify.orderId})">开始审核</button>
						</c:if>
					</c:when>
					<c:otherwise>
						<c:if test="${user.isAdmin == 1}">
							<button class="btn btn-info" onclick="showSetVerifierWindow(${orderVerify.orderId})">指定</button>
						</c:if>
					</c:otherwise>
				</c:choose>
			</p>
		</div>
	</c:forEach>
	
	<div id="setVerifyModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">要指定谁来审图呢？</h4>
				</div>
				<div class="modal-body">	
					<div style="width:200px;">
						<select id="verifySelect" class="form-control">
							<c:forEach items="${userList}" var="user">
								<option value="${user.id}">${user.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="setVerifier()">确定</button>
				</div>
			</div>
		</div>
	</div>
	
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
</div>
</div>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
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
				$("#verifyImageContainer").html("<img src='<c:url value='/pictures/fixed/" + data.orderId + "/" + data.id + ".jpg'/>'/>");
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