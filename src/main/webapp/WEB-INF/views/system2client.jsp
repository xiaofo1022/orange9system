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
	
	<button class="btn btn-warning btn-add-employee" data-toggle="modal" data-target="#addClient">添加客户</button>
	
	<div id="addClient" class="modal fade text-left" style="z-index:1999;" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header orange-model-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">客户信息</h4>
				</div>
				<div class="modal-body">
					<sf:form id="addClientForm" modelAttribute="client" class="form-horizontal" method="post">
						<input type="hidden" name="id" id="id"/>
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
	
	<c:forEach items="${clientList}" var="client">
		<div class="order-block">
			<span>名称：<span class="oc-label">${client.clientName}</span></span>
			<span>店铺：<a href="http://${client.clientShopLink}" target="_blank">${client.clientShopName}</a></span>
			<span>电话：<span class="oc-label">${client.clientPhone}</span></span>
			<span>邮箱：<span class="oc-label">${client.clientEmail}</span></span>
			<c:if test="${client.clientRemark != null && !client.clientRemark.equals('')}">
				<br/>
				<span>备注：<span class="oc-label">${client.clientRemark}</span></span>
			</c:if>
			<br/>
			<button class="btn btn-danger btn-xs fright" onclick="deleteClient(${client.id})">删除</button>
			<button class="btn btn-info btn-xs fright" style="margin-right:10px;"
				onclick="showUpdateClientWindow(${client.id}, '${client.clientName}', '${client.clientPhone}', '${client.clientEmail}', '${client.clientShopName}', '${client.clientShopLink}', '${client.clientRemark}')">编辑</button>
			<div class="clear"></div>
		</div>
	</c:forEach>
</div>
</div>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script>
	var clientValidator = new Validator("addClientForm", "btnAddClient", addClientRules, "<c:url value='/client/addClient'/>", addClientCallback);
	
	$("#addClient").on("hidden.bs.modal", function(event) {
		$("#addClientForm")[0].reset();
		clientValidator.url = "<c:url value='/client/addClient'/>";
	});

	var addClientRules = {
		clientName: { required: true },
		clientPhone: { required: true, number: true }
	};
	
	function addClient() {
		$("#addClientForm").submit();
	}
	
	function addClientCallback(response) {
		if (response.status == "success") {
			$("#addClient").modal("hide");
			location.reload(true);
		} else {
			alert(response.msg);
		}
	}
	
	function showUpdateClientWindow(id, clientName, clientPhone, clientEmail, clientShopName, clientShopLink, clientRemark) {
		clientValidator.url = "<c:url value='/client/updateClient'/>";
		$("#id").val(id);
		$("#clientName").val(clientName);
		$("#clientPhone").val(clientPhone);
		$("#clientEmail").val(clientEmail);
		$("#clientShopName").val(clientShopName);
		$("#clientShopLink").val(clientShopLink);
		$("#clientRemark").val(clientRemark);
		$("#addClient").modal("show");
	}
	
	function deleteClient(id) {
		var result = confirm("是否确定删除客户？");
		if (result) {
			$.post("<c:url value='/client/deleteClient/" + id + "'/>", null, function(data) {
				if (data.status == "success") {
					location.reload(true);
				} else {
					alert(data.msg);
				}
			});
		}
	}
</script>
</body>
</html>