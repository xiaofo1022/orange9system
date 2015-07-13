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
<link rel="icon" href="<c:url value="/images/favicon.ico"/>" type="image/x-icon" /> 
<link rel="shortcut icon" href="<c:url value="/images/favicon.ico"/>" type="image/x-icon" />
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
	<jsp:param name="page" value="client"/>
</jsp:include>

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
	
<div class="container">
<div class="row">

	<div class="col-sm-8 blog-main">
		<c:forEach items="${clientList}" var="client">
			<div class="data-block">
				<div class="data-title lofter-bc">
					${client.clientName}
					<c:if test="${client.clientRemark != null && !client.clientRemark.equals('')}">
						[${client.clientRemark}]
					</c:if>
				</div>
				<div class="clearfix">
					<c:if test="${client.clientShopName != null && !client.clientShopName.equals('')}">
						<div class="data-info taobao-bc">淘宝 <a href="http://${client.clientShopLink}" target="_blank">${client.clientShopName}</a></div>
					</c:if>
					<div class="data-info taobao-bc">电话 ${client.clientPhone}</div>
					<c:if test="${client.clientEmail != null && !client.clientEmail.equals('')}">
						<div class="data-info taobao-bc">邮箱 ${client.clientEmail}</div>
					</c:if>
				</div>
				<div class="clearfix">
					<button class="btn btn-danger ml10 fright"  onclick="deleteClient(${client.id})">删除</button>
					<button class="btn btn-info fright"
						onclick="showUpdateClientWindow(${client.id}, '${client.clientName}', '${client.clientPhone}', '${client.clientEmail}', '${client.clientShopName}', '${client.clientShopLink}', '${client.clientRemark}')">
						编辑
					</button>
				</div>
			</div>
		</c:forEach>
		<button class="btn btn-primary fright" data-toggle="modal" data-target="#addClient">添加客户</button>
	</div>
	
	<jsp:include page="panel.jsp" flush="true"/>
</div>
</div>
<script>
	var addClientRules = {
		clientName: { required: true },
		clientPhone: { required: true, number: true }
	};
	
	var clientValidator = new Validator("addClientForm", "btnAddClient", addClientRules, "<c:url value='/client/addClient'/>", addClientCallback);
	
	$("#addClient").on("hidden.bs.modal", function(event) {
		$("#addClientForm")[0].reset();
		clientValidator.url = "<c:url value='/client/addClient'/>";
	});

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