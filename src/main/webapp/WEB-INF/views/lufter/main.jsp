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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap.lufter.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/lufter/lufter.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/lufter/summary.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/jquery-ui/jquery-ui.css'/>" />
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/jquery-ui.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<body>
<jsp:include page="header.jsp" flush="true">
	<jsp:param name="page" value="summary"/>
</jsp:include>

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
							<div class="input-group">
								<input type="text" maxlength="10" id="modelName" name="modelName" class="form-control"/>
								<div class="input-group-btn">
									<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span class="caret"></span></button>
									<ul class="dropdown-menu" role="menu">
										<c:forEach items="${modelNameList}" var="modelName">
											<li><a onclick="setControl('modelName', '${modelName.name}')">${modelName.name}</a></li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">搭配师</label>
						<div class="col-sm-4">
							<div class="input-group">
								<input type="text" maxlength="10" id="stylistName" name="stylistName" class="form-control"/>
								<div class="input-group-btn">
									<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span class="caret"></span></button>
									<ul class="dropdown-menu" role="menu">
										<c:forEach items="${stylistNameList}" var="stylistName">
											<li><a onclick="setControl('stylistName', '${stylistName.name}')">${stylistName.name}</a></li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">化妆师</label>
						<div class="col-sm-4">
							<div class="input-group">
								<input type="text" maxlength="10" id="dresserName" name="dresserName" class="form-control"/>
								<div class="input-group-btn">
									<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span class="caret"></span></button>
									<ul class="dropdown-menu" role="menu">
										<c:forEach items="${dresserNameList}" var="dresserName">
											<li><a onclick="setControl('dresserName', '${dresserName.name}')">${dresserName.name}</a></li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">经纪人</label>
						<div class="col-sm-4">
							<div class="input-group">
								<input type="text" maxlength="10" id="brokerName" name="brokerName" class="form-control"/>
								<div class="input-group-btn">
									<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span class="caret"></span></button>
									<ul class="dropdown-menu" role="menu">
										<c:forEach items="${brokerList}" var="broker">
											<li><a onclick="setBroker('brokerName', '${broker.name}', 'brokerPhone', '${broker.phone}')">${broker.name}</a></li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">联系方式</label>
						<div class="col-sm-4">
							<div class="input-group">
								<input type="text" maxlength="11" id="brokerPhone" name="brokerPhone" class="form-control"/>
								<div class="input-group-btn">
									<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span class="caret"></span></button>
									<ul class="dropdown-menu" role="menu">
										<c:forEach items="${brokerList}" var="broker">
											<li><a onclick="setControl('brokerPhone', '${broker.phone}')">${broker.phone}</a></li>
										</c:forEach>
									</ul>
								</div>
							</div>
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

<div class="container">
<div class="row">

	<div class="col-sm-8 blog-main">
		<div class="order-summary-block">
			<div class="summary-label clearfix">
				<button class="btn btn-default btn-sm fleft" onclick="queryPreMonth()"><span class="glyphicon glyphicon-chevron-left"></span></button>
				<div id="month-title" class="fleft summary-title"></div>
				<button class="btn btn-default btn-sm fleft" onclick="queryNextMonth()"><span class="glyphicon glyphicon-chevron-right"></span></button>
				<c:if test="${user.isAdmin == 1}">
					<button class="btn btn-default btn-sm fleft" style="margin-left:5px;" data-toggle="modal" data-target="#addOrder"><span class="glyphicon glyphicon-plus"></span></button>
				</c:if>
			</div>
			<div class="order-date-row clearfix">
				<div class="order-date-header ghover">日</div>
				<div class="order-date-header ghover">一</div>
				<div class="order-date-header ghover">二</div>
				<div class="order-date-header ghover">三</div>
				<div class="order-date-header ghover">四</div>
				<div class="order-date-header ghover">五</div>
				<div class="order-date-header ghover">六</div>
			</div>
			<div id="date-row-1" class="order-date-row clearfix"></div>
			<div id="date-row-2" class="order-date-row clearfix"></div>
			<div id="date-row-3" class="order-date-row clearfix"></div>
			<div id="date-row-4" class="order-date-row clearfix"></div>
			<div id="date-row-5" class="order-date-row clearfix"></div>
			<div id="date-row-6" class="order-date-row clearfix"></div>
		</div>
	</div>

	<jsp:include page="panel.jsp" flush="true"/>
</div>
</div>
<script src="<c:url value='/js/validation/jquery.validate.js'/>"></script>
<script src="<c:url value='/js/validation/validation-message-cn.js'/>"></script>
<script src="<c:url value='/js/validation/validator.js'/>"></script>
<script src="<c:url value='/js/util/dateUtil.js'/>"></script>
<script>
	$('#shootDate').datepicker();
	
	var now = new Date();
	var selectedQueryDate = new Date(now.getFullYear(), now.getMonth(), 1, 0, 0, 0);
	
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
	
	function queryPreMonth() {
		selectedQueryDate = DateUtil.minusMonth(selectedQueryDate);
		getOrderList();
	}
	
	function queryNextMonth() {
		selectedQueryDate = DateUtil.plusMonth(selectedQueryDate);
		getOrderList();
	}
	
	function getOrderList() {
		var queryYear = selectedQueryDate.getFullYear();
		var queryMonth = selectedQueryDate.getMonth();
		var startDate = new Date(queryYear, queryMonth, 1);
		var endDate = new Date(queryYear, queryMonth, DateUtil.getLastDayOfMonth(queryYear, queryMonth));
		var queryStartDate = DateUtil.getDisplayDateString(startDate);
		var queryEndDate = DateUtil.getDisplayDateString(endDate);
		$("#month-title").text(selectedQueryDate.getFullYear() + " / " + (selectedQueryDate.getMonth() + 1));
		$.get("<c:url value='/order/getOrderListByDate/" + queryStartDate + "/" + queryEndDate + "'/>", function(list, status) {
			if (list) {
				createDateRect();
				for (var i in list) {
					var data = list[i];
					var shootDate = new Date();
					shootDate.setTime(data.shootDate);
					var dateCol = $("#order-date-" + shootDate.getDate());
					var colHtml = dateCol.html();
					dateCol.html(colHtml + getDateColHtml(data));
				}
				clearUnnecessaryBorder();
			}
		});
	}
	
	function clearUnnecessaryBorder() {
		$(".order-date-block").each(function(index, element) {
			var childrenList = $(element).children();
			if (childrenList.length > 3) {
				childrenList.last().css("border-bottom", "0");
			}
		});
	}
	
	function getDateColHtml(data) {
		return getInfoBlock(data.shootHalf + "<a href='<c:url value='/order/orderDetail/" + data.id + "'/>' target='_blank'>" + " " + data.orderNo + " </a><br/>[" + data.orderStatus.name + "]");
	}
	
	function getInfoBlock(info) {
		return '<div class="order-info-block">' + info + '</div>';
	}
	
	function getUserList() {
		$.get("<c:url value='/user/getUserList'/>", function(list, status) {
			if (list) {
				$("#photographerId").html("");
				$("#assistantId").html("");
				var photographerHtml = "";
				var assistantHtml = "<option>请选择 </option>";
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
			location.reload(true);
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
		var startDate = new Date(selectedQueryDate.getFullYear(), selectedQueryDate.getMonth(), 1);
		var rowIndex = 1;
		var startDay = 1;
		var lastDay = DateUtil.getLastDayOfMonth(startDate.getFullYear(), startDate.getMonth() + 1);
		for (var i = 0; i < 6; i++) {
			var rowBlock = $("#date-row-" + (i + 1));
			rowBlock.html("");
			var rowHtml = "";
			for (var j = 0; j < 7; j++) {
				startDate.setDate(startDay);
				var weekDay = startDate.getDay();
				if (weekDay == j && startDay <= lastDay) {
					startDay++;
					var dt = startDate.getDate();
					rowHtml += getDateBlockOuter(dt, "", j < 6);
				} else {
					if (j < 6) {
						rowHtml += ('<div class="order-date-block border-right ghover"></div>');
					} else {
						rowHtml += ('<div class="order-date-block ghover"></div>');
					}
				}
			}
			rowBlock.html(rowHtml);
			rowIndex++;
		}
	}
	
	function getDateBlockOuter(id, info, isPreCol) {
		if (info == "") {
			var header = "";
			if (isPreCol) {
				header = '<div id="order-date-' + id + '" class="order-date-block border-right relative-pos ghover">';
			} else {
				header = '<div id="order-date-' + id + '" class="order-date-block relative-pos ghover">';
			}
			return header + '<div class="order-date-pos">' + id + '</div></div>';
		} else {
			return info + '<div class="order-date-pos">' + id + '</div>';
		}
	}
	
	function setControl(id, value) {
		$("#" + id).val(value);
	}
	
	function setBroker(nameId, name, phoneId, phone) {
		$("#" + nameId).val(name);
		$("#" + phoneId).val(phone);
	}
</script>
</body>
</html>