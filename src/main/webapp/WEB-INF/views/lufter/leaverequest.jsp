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
<script src="<c:url value='/js/util/ajax-util.js'/>"></script>
<body>
<jsp:include page="header.jsp" flush="true">
	<jsp:param name="page" value=""/>
</jsp:include>

<div id="denailRequestModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">拒绝请假</h4>
			</div>
			<div class="modal-body">	
				<sf:form id="denailForm" modelAttribute="denail" class="form-horizontal" method="post">
					<div class="form-group">
						<label class="col-sm-2 control-label">理由</label>
						<div class="col-sm-6">
							<textarea id="denail-reason" rows="4" maxlength="1000" name="denail-reason" class="form-control"></textarea>
						</div>
					</div>
				</sf:form>
			</div>
			<div class="modal-footer">
				<button id="btnDenail" type="button" class="btn btn-primary" onclick="denailLeaveRequest()">确定</button>
			</div>
			<input type="hidden" id="request-id"/>
		</div>
	</div>
</div>

<div class="container">
<div class="row">
	<div class="col-sm-8 blog-main">
		<c:forEach items="${leaveRequestList}" var="leaveRequest">
			<div class="data-block">
				<div class="clearfix">
					<div class="data-info facebook-bc order-detail-header"><img src="${leaveRequest.user.header}"/> ${leaveRequest.user.name}</div>
					<div class="data-info facebook-bc">${leaveRequest.startDateLabel} 至 ${leaveRequest.endDateLabel}</div>
				</div>
				<div class="clearfix">
					<div class="data-info twitter-bc" style="width:297px;">原因 ${leaveRequest.reason}</div>
					<button class="btn btn-danger fright ml10" style="margin-top:15px;" onclick="showDenailWindow(${leaveRequest.id})">拒绝</button>
					<button class="btn btn-success fright" style="margin-top:15px;" onclick="confirmLeaveRequest(${leaveRequest.id})">批准</button>
				</div>
			</div>
		</c:forEach>
	</div>

	<jsp:include page="panel.jsp" flush="true">
		<jsp:param name="link" value="leaverequest"/>
	</jsp:include>
</div>
</div>
<script>
	function confirmLeaveRequest(id) {
		var result = confirm("是否确认批准请假？");
		if (result) {
			$.post("<c:url value='/user/confirmLeaveRequest/" + id + "'/>", null, function(data) {
				if (data.status == "success") {
					location.reload(true);
				}
			});
		}
	}
	
	function showDenailWindow(id) {
		$("#request-id").val(id);
		$("#denailRequestModal").modal("show");
	}
	
	function denailLeaveRequest() {
		var id = $("#request-id").val();
		var remark = $("#denail-reason").val();
		if (!remark) {
			alert("请输入理由");
			return;
		}
		AjaxUtil.post("<c:url value='/user/denailLeaveRequest/" + id + "'/>", {remark:remark}, function(data) {
			if (data.status == "success") {
				location.reload(true);
			}
		});
	}
</script>
</body>
</html>