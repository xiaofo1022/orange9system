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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system/summary.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/sidebar/component.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/jquery-ui/jquery-ui.css'/>" />
<script src="<c:url value='/js/jquery-1.11.2.min.js'/>"></script>
<script src="<c:url value='/js/jquery-ui.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/js/notification/modernizr.custom.js'/>"></script>
</head>
<body>
<div id="st-container" class="st-container">
<div class="st-pusher">
	<div style="text-align:center;padding-left:60px;">
		<p class="login-header"><span>ORANGE</span> 9 SYSTEM</p>
	</div>
	
	<jsp:include page="system2sidebar.jsp" flush="true"/>
	
	<div id="st-trigger-effects">
		<button class="btn btn-warning nav-btn" data-effect="st-effect-3">
			<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		</button>
	</div>
	
	<button class="btn btn-warning btn-add-employee" data-toggle="modal" data-target="#addOrder">添加订单</button>
	
	<!-- Add Order Modal -->
	<div id="addOrder" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header orange-model-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">添加订单</h4>
				</div>
				<div class="modal-body">
					<sf:form id="addOrderForm" class="form-horizontal" modelAttribute="order">
						<div class="form-group">
							<label class="col-sm-2 control-label">拍摄日期</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" name="shootDate" id="shootDate"/>
							</div>
							<div class="col-sm-3">
								<select id="shootHalf" name="shootHalf" class="form-control">
									<option value="AM">上午</option>
									<option value="PM">下午</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">客户</label>
							<div class="col-sm-4">
								<select id="clientId" name="clientId" class="form-control"></select>
							</div>
							<div class="col-sm-2">
								<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addClient">添加</button>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">模特</label>
							<div class="col-sm-4">
								<input type="text" maxlength="10" id="modelName" name="modelName" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">搭配师</label>
							<div class="col-sm-4">
								<input type="text" maxlength="10" id="stylistName" name="stylistName" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">化妆师</label>
							<div class="col-sm-4">
								<input type="text" maxlength="10" id="dresserName" name="dresserName" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">经纪人</label>
							<div class="col-sm-4">
								<input type="text" maxlength="10" id="brokerName" name="brokerName" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">联系方式</label>
							<div class="col-sm-4">
								<input type="text" maxlength="11" id="brokerPhone" name="brokerPhone" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">摄影师</label>
							<div class="col-sm-4">
								<select id="photographerId" name="photographerId" class="form-control"></select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">助理</label>
							<div class="col-sm-4">
								<select id="assistantId" name="assistantId" class="form-control"></select>
							</div>
						</div>
					</sf:form>
				</div>
				<div class="modal-footer">
					<button id="btnAddOrder" type="button" class="btn btn-primary" onclick="addOrder()">确定</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Add Client Modal -->
	<div id="addClient" class="modal fade text-left" style="z-index:1999;" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header orange-model-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">添加客户信息</h4>
				</div>
				<div class="modal-body">
					<sf:form id="addClientForm" modelAttribute="client" class="form-horizontal" method="post">
						<div class="form-group">
							<label class="col-sm-2 control-label">名称</label>
							<div class="col-sm-4">
								<input type="text" maxlength="50" class="form-control" name="clientName" id="clientName"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">电话</label>
							<div class="col-sm-4">
								<input type="text" maxlength="11" id="clientPhone" name="clientPhone" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-4">
								<input type="text" maxlength="50" id="clientEmail" name="clientEmail" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">店铺名称</label>
							<div class="col-sm-4">
								<input type="text" maxlength="50" id="clientShopName" name="clientShopName" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">店铺链接</label>
							<div class="col-sm-4">
								<input type="text" maxlength="50" id="clientShopLink" name="clientShopLink" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">备注</label>
							<div class="col-sm-6">
								<textarea id="clientRemark" maxlength="1000" name="clientRemark" class="form-control"></textarea>
							</div>
						</div>
					</sf:form>
				</div>
				<div class="modal-footer">
					<button id="btnAddClient" type="button" class="btn btn-primary" onclick="addClient()">确定</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="order-summary-block">
		<p class="summary-label">
			<a>上个月</a>
			<span>四月订单一览</span>
			<a>下个月</a>
		</p>
		<div>
			<div class="order-date-row date-header">
				<div class="order-date-header">日</div>
				<div class="order-date-header">一</div>
				<div class="order-date-header">二</div>
				<div class="order-date-header">三</div>
				<div class="order-date-header">四</div>
				<div class="order-date-header">五</div>
				<div class="order-date-header">六</div>
				<div class="clear"></div>
			</div>
			<div id="date-row-1" class="order-date-row"></div>
			<div id="date-row-2" class="order-date-row"></div>
			<div id="date-row-3" class="order-date-row"></div>
			<div id="date-row-4" class="order-date-row"></div>
			<div id="date-row-5" class="order-date-row"></div>
		</div>
		<div class="clear"></div>
	</div>
</div>
</div>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script src="<c:url value='/js/validation/jquery.validate.js'/>"></script>
<script src="<c:url value='/js/validation/validation-message-cn.js'/>"></script>
<script src="<c:url value='/js/validation/validator.js'/>"></script>
<script src="<c:url value='/js/util/base64.js'/>"></script>
<script src="<c:url value='/js/util/dateUtil.js'/>"></script>
<script>
$('#shootDate').datepicker();

getClientList();
getUserList();
getOrderList();

var addOrderRules = {
	shootDate: { required: true },
	clientId: { required: true },
	modelName: { required: true },
	brokerName: { required: true },
	brokerPhone: { required: true, number: true },
	photographerId: { required: true }
};

var addClientRules = {
	clientName: { required: true },
	clientPhone: { required: true, number: true }
};

var orderValidator = new Validator("addOrderForm", "btnAddOrder", addOrderRules, "<c:url value='/order/addOrder'/>", addOrderCallback);
var clientValidator = new Validator("addClientForm", "btnAddClient", addClientRules, "<c:url value='/client/addClient'/>", addClientCallback);

function addOrder() {
	$("#addOrderForm").submit();
}

function addClient() {
	$("#addClientForm").submit();
}

function getClientList() {
	$.get("<c:url value='/client/getClientList'/>", function(list, status) {
		var clientSelect = $("#clientId");
		var html = "";
		for (var i in list) {
			var data = list[i];
			html += ("<option value=" + data.id + ">" + data.clientName + "</option>");
		}
		clientSelect.html(html);
	});
}

function getOrderList() {
	$.get("<c:url value='/order/getOrderList'/>", function(list, status) {
		if (list) {
			createDateRect();
			for (var i in list) {
				var data = list[i];
				var shootDate = new Date();
				shootDate.setTime(data.shootDate);
				var dateCol = $("#order-date-" + shootDate.getDate());
				var dateHtml = dateCol.html();
				dateHtml += '<div class="order-date-info">';
				dateHtml += getDateColHtml(data);
				dateHtml += '</div>';
				dateCol.html(dateHtml);
			}
		}
	});
}

var base64 = new Base64();

function getDateColHtml(data) {
	var colHtml = "";
	colHtml += "<p>";
	if (data.shootHalf == "AM") {
		colHtml += "上午：";
	} else {
		colHtml += "下午：";
	}
	colHtml += ("<a href='<c:url value='/order/orderDetail/" + data.id + "'/>'>#O9" + data.id + "</a></p>");
	if (data.photographer) {
		colHtml += ("<p>摄影师：<img src='" + data.photographer.header + "'/>" + data.photographer.name + "</p>");
	}
	if (data.assistant) {
		colHtml += ("<p>助理：<img src='" + data.assistant.header + "'/>" + data.assistant.name + "</p>");
	}
	colHtml += ("<p>模特：" + data.modelName + "</p>");
	if (data.dresserName) {
		colHtml += ("<p>化妆师：" + data.dresserName + "</p>");
	}
	if (data.stylistName) {
		colHtml += ("<p>搭配师：" + data.stylistName + "</p>");
	}
	return colHtml;
}

function getUserList() {
	$.get("<c:url value='/user/getUserList'/>", function(list, status) {
		if (list) {
			$("#photographerId").html("");
			$("#assistantId").html("");
			var photographerHtml = "";
			var assistantHtml = "";
			for (var i in list) {
				var data = list[i];
				var option = "<option value='" + data.id + "'>" + data.name + "</option>";
				if (data.roleId == 2) {
					photographerHtml += option;
				} else if (data.roleId == 4) {
					assistantHtml += option;
				}
			}
			$("#photographerId").html(photographerHtml);
			$("#assistantId").html(assistantHtml);
		}
	});
}

$('#addClient').on('hidden.bs.modal', function (e) {
	document.getElementById("addClientForm").reset();
});

$('#addOrder').on('hidden.bs.modal', function (e) {
	document.getElementById("addOrderForm").reset();
});

function addOrderCallback(response) {
	if (response.status == "success") {
		$("#addOrder").modal("hide");
		getOrderList();
	} else {
		alert(response.msg);
	}
}

function addClientCallback(response) {
	if (response.status == "success") {
		$("#addClient").modal("hide");
		getClientList();
	} else {
		alert(response.msg);
	}
}

createDateRect();

function createDateRect() {
	var now = new Date();
	var startDate = now;
	var rowIndex = 1;
	var startDay = 1;
	var lastDay = DateUtil.getLastDayOfMonth(now.getFullYear(), now.getMonth() + 1);
	for (var i = 0; i < 5; i++) {
		var rowBlock = $("#date-row-" + (i + 1));
		rowBlock.html("");
		var rowHtml = "";
		for (var j = 0; j < 7; j++) {
			startDate.setDate(startDay);
			var weekDay = startDate.getDay();
			if (weekDay == j) {
				if (startDay != lastDay) {
					startDay++;
				}
				rowHtml += ('<div id="order-date-' + startDate.getDate() + '" class="order-date-block">' + DateUtil.getDateLabel(startDate) + '</div>');
			} else {
				rowHtml += ('<div class="order-date-block"></div>');
			}
		}
		rowHtml += ('<div class="clear"></div>');
		rowBlock.html(rowHtml);
		rowIndex++;
	}
}
</script>
</body>
</html>