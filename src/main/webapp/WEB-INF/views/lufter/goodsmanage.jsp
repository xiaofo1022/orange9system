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
<link href="<c:url value='/css/jquery-ui/jquery-ui.css'/>" rel="stylesheet"/>
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/js/validation/jquery.validate.js'/>"></script>
<script src="<c:url value='/js/validation/validation-message-cn.js'/>"></script>
<script src="<c:url value='/js/validation/validator.js'/>"></script>
<body>
<jsp:include page="header.jsp" flush="true">
	<jsp:param name="page" value="goods"/>
</jsp:include>

<div id="orderGoodsModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header orange-model-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">货品信息</h4>
			</div>
			<div class="modal-body">
				<sf:form id="orderGoodsForm" modelAttribute="orderGoods" class="form-horizontal" method="post">
					<div class="form-group">
						<label class="col-sm-2 control-label">单号</label>
						<div class="col-sm-4">
							<select id="orderId" name="orderId" class="form-control">
								<c:forEach items="${orderNoList}" var="orderNo">
									<option value="${orderNo.orderId}">${orderNo.orderNo}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">日期</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" name="insertDatetime" id="insertDatetime"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">方式</label>
						<div class="col-sm-4">
							<select id="goodsMethod" name="goodsMethod" class="form-control" onchange="expressMethodChange()">
								<option value="0">快递</option>
								<option value="1">客户自提(取)</option>
							</select>
						</div>
					</div>
					<div id="fm-express-company" class="form-group">
						<label class="col-sm-2 control-label">快递公司</label>
						<div class="col-sm-4">
							<select id="expressCompany" name="expressCompany" class="form-control">
								<option value="顺丰">顺丰</option>
								<option value="申通">申通</option>
								<option value="中通">中通</option>
								<option value="汇通">汇通</option>
								<option value="天天">天天</option>
								<option value="其他">其他</option>
							</select>
						</div>
					</div>
					<div id="fm-express-no" class="form-group">
						<label class="col-sm-2 control-label">快递单号</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" maxlength="20" name="expressNo" id="expressNo"/>
						</div>
					</div>
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
					<div class="form-group">
						<label class="col-sm-2 control-label">备注</label>
						<div class="col-sm-6">
							<textarea id="remark" maxlength="1000" name="remark" class="form-control"></textarea>
						</div>
					</div>
				</sf:form>
			</div>
			<div class="modal-footer">
				<button id="btnConfirmGoods" type="button" class="btn btn-primary" onclick="submit()">确定</button>
			</div>
		</div>
	</div>
</div>
	
<div class="container">
<div class="row">
	<div class="col-sm-8 blog-main">
		<c:forEach items="${orderGoodsList}" var="orderGoods">
			<div class="data-block">
				<div class="data-title lofter-bc">
					单号 <a href="<c:url value='/order/orderDetail/${orderGoods.orderId}'/>" target="_blank">${orderGoods.orderNo}</a>
					<c:if test="${orderGoods.remark != null && !orderGoods.remark.equals('')}">
						[${orderGoods.remark}]
					</c:if>
				</div>
				<div class="clearfix">
					<c:choose>
						<c:when test="${orderGoods.deliverExpressNo == null}">
							<div class="data-info cm-bc">收货日期 ${orderGoods.insertDatetimeLabel}</div>
							<div class="data-info cm-bc">快递公司 ${orderGoods.receiveExpressCompany}</div>
							<div class="data-info cm-bc">快递单号 ${orderGoods.receiveExpressNo}</div>
						</c:when>
						<c:otherwise>
							<div class="data-info cm-bc">发货日期 ${orderGoods.insertDatetimeLabel}</div>
							<div class="data-info cm-bc">快递公司 ${orderGoods.deliverExpressCompany}</div>
							<div class="data-info cm-bc">快递单号 ${orderGoods.deliverExpressNo}</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="clearfix">
					<c:if test="${orderGoods.coatCount != 0}">
						<div class="data-info twitter-bc">上装 ${orderGoods.coatCount}件</div>
					</c:if>
					<c:if test="${orderGoods.pantsCount != 0}">
						<div class="data-info twitter-bc">下装 ${orderGoods.pantsCount}件</div>
					</c:if>
					<c:if test="${orderGoods.jumpsuitsCount != 0}">
						<div class="data-info twitter-bc">连体衣 ${orderGoods.jumpsuitsCount}件</div>
					</c:if>
					<c:if test="${orderGoods.bagCount != 0}">
						<div class="data-info twitter-bc">包包 ${orderGoods.bagCount}件</div>
					</c:if>
					<c:if test="${orderGoods.shoesCount != 0}">
						<div class="data-info twitter-bc">鞋子 ${orderGoods.shoesCount}件</div>
					</c:if>
					<c:if test="${orderGoods.hatCount != 0}">
						<div class="data-info twitter-bc">帽子 ${orderGoods.hatCount}件</div>
					</c:if>
					<c:if test="${orderGoods.otherCount != 0}">
						<div class="data-info twitter-bc">其他 ${orderGoods.otherCount}件</div>
					</c:if>
				</div>
			</div>
		</c:forEach>
		<button class="btn btn-success ml10 fright" onclick="showDeliverGoodsWindow(${orderGoods.orderId})">发货</button>
		<button class="btn btn-primary fright" onclick="showConfirmGoodsWindow(${orderGoods.orderId})">收货</button>
	</div>

	<jsp:include page="panel.jsp" flush="true"/>
</div>
</div>
<script>
	$('#insertDatetime').datepicker();

	var confirmGoodsRules = {
		insertDatetime: { required: true },
		coatCount: { digits: true },
		pantsCount: { digits: true },
		jumpsuitsCount: { digits: true },
		shoesCount: { digits: true },
		bagCount: { digits: true },
		hatCount: { digits: true },
		otherCount: { digits: true }
	};
	
	var validator = new Validator("orderGoodsForm", "btnConfirmGoods", confirmGoodsRules, "<c:url value='/orderGoods/updateShootGoods'/>", submitCallback);
	
	function submit() {
		var method = parseInt($("#goodsMethod").val());
		if (method == 0 && $("#expressNo").val() == "") {
			alert("请输入快递单号");
			return;
		}
		$("#orderGoodsForm").submit();
	}
	
	function submitCallback(response) {
		if (response.status == "success") {
			location.reload(true);
		} else {
			alert(response.msg);
		}
	}
	
	function showConfirmGoodsWindow() {
		validator.url = "<c:url value='/orderGoods/receiveGoods'/>";
		$("#orderGoodsModal").modal("show");
	}
	
	function showDeliverGoodsWindow() {
		validator.url = "<c:url value='/orderGoods/deliverGoods'/>";
		$("#orderGoodsModal").modal("show");
	}
	
	function expressMethodChange() {
		var method = parseInt($("#goodsMethod").val());
		var isDeliver = validator.url.indexOf("deliver") >= 0;
		if (method) {
			$("#fm-express-company").hide();
			$("#fm-express-no").hide();
			$("#expressCompany").val("");
			if (isDeliver) {
				$("#expressNo").val("客户自取");
			} else {
				$("#expressNo").val("客户自提");
			}
		} else {
			$("#expressCompany").val("顺丰");
			$("#expressNo").val("");
			$("#fm-express-company").show();
			$("#fm-express-no").show();
		}
	}
</script>
</body>
</html>