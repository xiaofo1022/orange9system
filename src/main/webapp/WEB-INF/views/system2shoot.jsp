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
<script src="<c:url value='/js/validation/jquery.validate.js'/>"></script>
<script src="<c:url value='/js/validation/validation-message-cn.js'/>"></script>
<script src="<c:url value='/js/validation/validator.js'/>"></script>
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
	
	<c:forEach items="${orderShootList}" var="orderShoot">
		<input type="hidden" id="${orderShoot.id}" class="convert-time" value="${orderShoot.shootTime}"/>
		<div class="order-block">
			<p class="model-label transfer-label">
				单号：<a href="<c:url value='/order/orderDetail/${orderShoot.id}'/>" target="_blank">O9${orderShoot.id}</a>
				<span id="time-label-${orderShoot.id}" class="ml10" style="color:#F0AD4E;">剩余时间：</span>
				<span id="remain-time-${orderShoot.id}"></span>
			</p>
			<p class="model-label transfer-label">
				摄影师：
				<img src="${orderShoot.photographer.header}"/><span class="ml10">${orderConvert.photographer.name}</span>
				<c:if test="${ orderShoot.photographer.id == user.id}">
					<button id="btn-convert-done-${orderShoot.id}" class="btn btn-success ml10" onclick="confirmShootComplete(${orderShoot.id}, ${orderShoot.photographerId})">完成</button>
				</c:if>
			</p>
			<div id="time-progress-bar-${orderShoot.id}" class="progress" style="margin-bottom:0;">
				<div id="time-bar-${orderShoot.id}" class="progress-bar progress-bar-success" role="progressbar"
					aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:0%">
				</div>
			</div>
		</div>
	</c:forEach>
	
	<div id="orderGoodsModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header orange-model-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">确认拍摄信息</h4>
				</div>
				<div class="modal-body">
					<sf:form id="orderGoodsForm" modelAttribute="orderGoods" class="form-horizontal" method="post">
						<input type="hidden" id="goodsOrderId" name="orderId"/>
						<div class="form-group">
							<label class="col-sm-2 control-label">上装</label>
							<div class="col-sm-2">
								<input type="number" id="coatCount" name="coatCount" value="0" min="0" max="9999" step="1" class="form-control"/>
							</div>
							<label class="col-sm-2 control-label">下装</label>
							<div class="col-sm-2">
								<input type="number" id="pantsCount" name="pantsCount" value="0" min="0" max="9999" step="1" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">连体衣</label>
							<div class="col-sm-2">
								<input type="number" id="jumpsuitsCount" name="jumpsuitsCount" value="0" min="0" max="9999" step="1" class="form-control"/>
							</div>
							<label class="col-sm-2 control-label">鞋子</label>
							<div class="col-sm-2">
								<input type="number" id="shoesCount" name="shoesCount" value="0" min="0" max="9999" step="1" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">包包</label>
							<div class="col-sm-2">
								<input type="number" id="bagCount" name="bagCount" value="0" min="0" max="9999" step="1" class="form-control"/>
							</div>
							<label class="col-sm-2 control-label">帽子</label>
							<div class="col-sm-2">
								<input type="number" id="hatCount" name="hatCount" value="0" min="0" max="9999" step="1" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">其他</label>
							<div class="col-sm-2">
								<input type="number" id="otherCount" name="otherCount" value="0" min="0" max="9999" step="1" class="form-control"/>
							</div>
						</div>
					</sf:form>
				</div>
				<div class="modal-footer">
					<button id="btnConfirmGoods" type="button" class="btn btn-primary" onclick="completeShoot()">确定</button>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="order-id"/>
	<input type="hidden" id="photographer-id"/>
</div>
</div>
<input type="hidden" id="limitMinutes" value="${limitMinutes}"/>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script src="<c:url value='/js/util/countDown.js'/>"></script>
<script>
	var limitSecond = parseInt($("#limitMinutes").val()) * 60;
	
	$(".convert-time").each(function(index, element) {
		if (element.value != 0) {
			var id = element.id;
			var startTime = new Date();
			startTime.setTime(element.value);
			new CountDown(startTime, limitSecond, "time-bar-" + id, "time-label-" + id, "remain-time-" + id);
		}
	});
	
	var confirmGoodsRules = {
		coatCount: { digits: true },
		pantsCount: { digits: true },
		jumpsuitsCount: { digits: true },
		shoesCount: { digits: true },
		bagCount: { digits: true },
		hatCount: { digits: true },
		otherCount: { digits: true }
	};
	
	var goodsValidator = new Validator("orderGoodsForm", "btnConfirmGoods", confirmGoodsRules, "<c:url value='/orderGoods/updateShootGoods'/>", submitGoodsCallback);
		
	function showUpdateOrderGoodsWindow(orderId, coatCount, pantsCount, jumpsuitsCount, shoesCount, hatCount, bagCount, otherCount) {
		$("#goodsOrderId").val(orderId);
		$("#coatCount").val(coatCount);
		$("#pantsCount").val(pantsCount);
		$("#jumpsuitsCount").val(jumpsuitsCount);
		$("#shoesCount").val(shoesCount);
		$("#hatCount").val(hatCount);
		$("#bagCount").val(bagCount);
		$("#otherCount").val(otherCount);
		$("#orderGoodsModal").modal("show");
	}
	
	function confirmShootComplete(orderId, photographerId) {
		$("#order-id").val(orderId);
		$("#photographer-id").val(photographerId);
		$.get("<c:url value='/orderGoods/getOrderGoods/" + orderId + "'/>", function(data) {
			if (data) {
				showUpdateOrderGoodsWindow(data.orderId, data.coatCount, data.pantsCount, data.jumpsuitsCount, data.shoesCount, data.hatCount, data.bagCount, data.otherCount);
			} else {
				showUpdateOrderGoodsWindow(orderId, 0, 0, 0, 0, 0, 0, 0);
			}
		});
	}
	
	function submitGoodsCallback(response) {
		if (response.status == "success") {
			$.post("<c:url value='/order/setOrderTransfer/" + $("#order-id").val() + "/" + $("#photographer-id").val() + "'/>", null, function(data, status) {
				if (data.status == "success") {
					location.reload(true);
				} else {
					console.log(data);
				}
			});
		}
	}
	
	function completeShoot() {
		$("#orderGoodsForm").submit();
	}
</script>
</body>
</html>