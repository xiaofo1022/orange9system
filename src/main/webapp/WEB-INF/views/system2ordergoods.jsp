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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system/orderdetail.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/sidebar/component.css'/>" />
<script src="<c:url value='/js/jquery-1.11.2.js'/>"></script>
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
	
	<div id="orderGoodsModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header orange-model-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">货品信息</h4>
				</div>
				<div class="modal-body">
					<sf:form id="orderGoodsForm" modelAttribute="orderGoods" class="form-horizontal" method="post">
						<input type="hidden" id="orderId" name="orderId"/>
						<div class="form-group">
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
						<div class="form-group">
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
	
	<div class="order-block">
		<c:forEach items="${orderList}" var="order">
			<div class="order-detail-block bd-blue">
				<span>单号：<a href="<c:url value='/order/orderDetail/${order.id}'/>" target="_blank">#O9${order.id}</a></span>
				<button class="btn btn-success" onclick="showConfirmGoodsWindow(${order.id})">收货</button>
				<button class="btn btn-info" onclick="showDeliverGoodsWindow(${order.id})">发货</button>
				<br/>
				<span>客户：<span class="oc-label">${order.client.clientName}</span></span>
				<span>店铺：<a href="http://${order.client.clientShopLink}" target="_blank">${order.client.clientShopName}</a></span>
				<span>电话：<span class="oc-label">${order.client.clientPhone}</span></span>
				<span>邮箱：<span class="oc-label">${order.client.clientEmail}</span></span>
				<br/>
				<c:forEach items="${order.orderGoodsList}" var="orderGoods">
					<c:choose>
						<c:when test="${orderGoods.deliverExpressNo == null}">
							<span>收货时间：<span class="oc-label">${orderGoods.insertDatetimeLabel}</span></span>
							<span>单号：<span class="oc-label">${orderGoods.receiveExpressNo}</span></span>
							<span>快递公司：<span class="oc-label">${orderGoods.receiveExpressCompany}</span></span>
						</c:when>
						<c:otherwise>
							<span>发货时间：<span class="oc-label">${orderGoods.insertDatetimeLabel}</span></span>
							<span>单号：<span class="oc-label">${orderGoods.deliverExpressNo}</span></span>
							<span>快递公司：<span class="oc-label">${orderGoods.deliverExpressCompany}</span></span>
						</c:otherwise>
					</c:choose>
					<br/>
					<c:if test="${orderGoods.coatCount != 0}">
						<span>上装：<span class="oc-label">${orderGoods.coatCount}</span>件</span>
					</c:if>
					<c:if test="${orderGoods.pantsCount != 0}">
						<span>下装：<span class="oc-label">${orderGoods.pantsCount}</span>件</span>
					</c:if>
					<c:if test="${orderGoods.jumpsuitsCount != 0}">
						<span>连体衣：<span class="oc-label">${orderGoods.jumpsuitsCount}</span>件</span>
					</c:if>
					<c:if test="${orderGoods.bagCount != 0}">
						<span>包包：<span class="oc-label">${orderGoods.bagCount}</span>件</span>
					</c:if>
					<c:if test="${orderGoods.shoesCount != 0}">
						<span>鞋子：<span class="oc-label">${orderGoods.shoesCount}</span>件</span>
					</c:if>
					<c:if test="${orderGoods.hatCount != 0}">
						<span>帽子：<span class="oc-label">${orderGoods.hatCount}</span>件</span>
					</c:if>
					<c:if test="${orderGoods.otherCount != 0}">
						<span>其他：<span class="oc-label">${orderGoods.otherCount}</span>件</span>
					</c:if>
					<c:if test="${!orderGoods.remark.equals('')}">
						<span>备注：<span class="oc-label">${orderGoods.remark}</span></span>
					</c:if>
					<br/>
				</c:forEach>
			</div>
		</c:forEach>
	</div>
</div>
</div>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script>
	var confirmGoodsRules = {
		expressNo: { required: true, digits: true },
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
		$("#orderGoodsForm").submit();
	}
	
	function submitCallback(response) {
		if (response.status == "success") {
			location.reload(true);
		} else {
			alert(response.msg);
		}
	}
	
	function showConfirmGoodsWindow(orderId) {
		$("#orderId").val(orderId);
		validator.url = "<c:url value='/orderGoods/receiveGoods'/>";
		$("#orderGoodsModal").modal("show");
	}
	
	function showDeliverGoodsWindow(orderId) {
		$("#orderId").val(orderId);
		validator.url = "<c:url value='/orderGoods/deliverGoods'/>";
		$("#orderGoodsModal").modal("show");
	}
</script>
</body>
</html>