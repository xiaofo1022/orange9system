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
<script src="<c:url value='/js/validation/jquery.validate.js'/>"></script>
<script src="<c:url value='/js/validation/validation-message-cn.js'/>"></script>
<script src="<c:url value='/js/validation/validator.js'/>"></script>
<body>
<jsp:include page="header.jsp" flush="true">
	<jsp:param name="page" value=""/>
</jsp:include>

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
<input type="hidden" id="limitMinutes" value="${limitMinutes}"/>

<div class="container">
<div class="row">

	<div class="col-sm-8 blog-main">
		<c:forEach items="${orderShootList}" var="orderShoot">
			<div class="data-block">
				<input type="hidden" id="${orderShoot.id}" class="convert-time" value="${orderShoot.shootTime}"/>
				<div class="clearfix">
					<div class="data-info lofter-bc">
					单号 <a href="<c:url value='/order/orderDetail/${orderShoot.id}'/>" target="_blank">${orderShoot.orderNo}</a>
					</div>
					<div class="data-info lofter-bc">
						<span id="time-label-${orderShoot.id}">剩余时间</span> 
						<span id="remain-time-${orderShoot.id}"></span>
					</div>
				</div>
				<div class="clearfix">
					<div class="data-info facebook-bc order-detail-header">摄影师 ${orderShoot.photographer.name} <img src="${orderShoot.photographer.header}"/></div>
					<c:if test="${orderShoot.photographer.id == user.id || user.isAdmin == 1}">
						<button id="btn-convert-done-${orderShoot.id}" class="btn btn-success btn-data-info" onclick="confirmShootComplete(${orderShoot.id}, ${orderShoot.photographerId})">完成</button>
					</c:if>
				</div>
				<div id="time-progress-bar-${orderShoot.id}" class="progress" style="margin-bottom:0;">
					<div id="time-bar-${orderShoot.id}" class="progress-bar progress-bar-success" role="progressbar"
						aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:0%">
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	
	<jsp:include page="panel.jsp" flush="true">
		<jsp:param name="link" value="shooting"/>
	</jsp:include>
</div>
</div>
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