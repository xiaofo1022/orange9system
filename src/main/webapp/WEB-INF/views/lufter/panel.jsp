<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<% String link = request.getParameter("link"); %>
<div class="col-sm-3 col-sm-offset-1">
	<div class="sidebar-module clearfix">
		<div class="clearfix">
			<div class="self-header-info fleft">
				<img src="${user.header}"/>
			</div>
			<div class="self-info fleft">
				<p style="font-weight:bold;">${user.name}</p>
				<p style="font-size:12px;">${user.loginTime} Check In</p>
			</div>
			<div class="leave-block fleft" onclick="showLeaveRequest()">
				请假<span class="glyphicon glyphicon-send"></span>
			</div>
		</div>
		<div class="order-link whover" onclick="toOrderShooting()">
			<% if (link != null && link.equals("shooting")) { %>
				<span class="order-link-nav glyphicon glyphicon-star"></span>
			<% } %>
			<p>拍摄中</p>
			<span class="nav-sidebar"></span>
		</div>
		<div class="order-link whover" onclick="toOrderUploadOriginal()">
			<% if (link != null && link.equals("uploadoriginal")) { %>
				<span class="order-link-nav glyphicon glyphicon-star"></span>
			<% } %>
			<p>上传原片</p>
			<span class="nav-sidebar"></span>
		</div>
		<div class="order-link whover" onclick="toOrderClientChosen()">
			<% if (link != null && link.equals("clientchosen")) { %>
				<span class="order-link-nav glyphicon glyphicon-star"></span>
			<% } %>
			<p>等待客户选片</p>
			<span class="nav-sidebar"></span>
		</div>
		<div class="order-link whover" onclick="toOrderConvertImage()">
			<% if (link != null && link.equals("convertimage")) { %>
				<span class="order-link-nav glyphicon glyphicon-star"></span>
			<% } %>
			<p>导图</p>
			<span class="nav-sidebar"></span>
		</div>
		<div class="order-link whover" onclick="toOrderFixBackground()">
			<% if (link != null && link.equals("fixbackground")) { %>
				<span class="order-link-nav glyphicon glyphicon-star"></span>
			<% } %>
			<p>修背景</p>
			<span class="nav-sidebar"></span>
		</div>
		<div class="order-link whover" onclick="toOrderFixSkin()">
			<% if (link != null && link.equals("fixskin")) { %>
				<span class="order-link-nav glyphicon glyphicon-star"></span>
			<% } %>
			<p>修皮肤及褶皱</p>
			<span class="nav-sidebar"></span>
		</div>
		<div class="order-link whover" onclick="toOrderCutLiquify()">
			<% if (link != null && link.equals("cutliquify")) { %>
				<span class="order-link-nav glyphicon glyphicon-star"></span>
			<% } %>
			<p>裁图液化</p>
			<span class="nav-sidebar"></span>
		</div>
		<div class="order-link whover" onclick="toUploadFixed()">
			<% if (link != null && link.equals("uploadfixed")) { %>
				<span class="order-link-nav glyphicon glyphicon-star"></span>
			<% } %>
			<p>上传成片</p>
			<span class="nav-sidebar"></span>
		</div>
		<div class="order-link whover" onclick="toOrderVerify()">
			<% if (link != null && link.equals("verify")) { %>
				<span class="order-link-nav glyphicon glyphicon-star"></span>
			<% } %>
			<p>等待审核</p>
			<span class="nav-sidebar"></span>
		</div>
		<c:if test="${user.isAdmin == 1}">
			<div class="order-link whover" onclick="toLeaveRequest()">
				<% if (link != null && link.equals("leaverequest")) { %>
					<span class="order-link-nav glyphicon glyphicon-star"></span>
				<% } %>
				<p>请假审批</p>
				<span class="nav-sidebar"></span>
			</div>
		</c:if>
	</div>
</div>

<div id="leaveRequestModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header orange-model-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">请假单</h4>
			</div>
			<div class="modal-body">
				<sf:form id="leaveRequestForm" class="form-horizontal" modelAttribute="leaveRequest" method="post">
					<div class="form-group">
						<label class="col-sm-2 control-label">起始日期</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" name="startDate" id="startDate"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">结束日期</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" name="endDate" id="endDate"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">请假原因</label>
						<div class="col-sm-6">
							<textarea id="reason" maxlength="1000" name="reason" class="form-control"></textarea>
						</div>
					</div>
				</sf:form>
			</div>
			<div class="modal-footer">
				<button id="btnAddLeave" type="button" class="btn btn-primary" onclick="addLeaveRequest()">确定</button>
			</div>
		</div>
	</div>
</div>

<script>
	$('#startDate').datepicker();
	$('#endDate').datepicker();

	$.get("<c:url value='/order/getOrderStatusCountMap'/>", function(data, status) {
		$(".nav-sidebar").each(function(){
			var text = $(this).prev().text();
			if (data[text] != null && data[text] != undefined) {
				$(this).text(data[text]);
			}
		});
	});
	
	function showLeaveRequest() {
		$("#leaveRequestModal").modal("show");
	}
	
	function addLeaveRequest() {
		var startDateText = $('#startDate').val();
		var endDateText = $('#endDate').val();
		var reason = $('#reason').val();
		if (!startDateText) {
			alert("请输入起始日期");
			return;
		}
		if (!endDateText) {
			alert("请输入结束日期");
			return;
		}
		if (!reason) {
			alert("请输入请假原因");
			return;
		}
		var sda = startDateText.split("/");
		var eda = endDateText.split("/");
		var startDate = new Date(sda[2], sda[0], sda[1], 0, 0, 0);
		var endDate = new Date(eda[2], eda[0], eda[1], 0, 0, 0);
		if (startDate.getTime() - endDate.getTime() > 0) {
			alert("起始日期不能大于结束日期");
			return;
		}
		$.post("<c:url value='/user/addLeaveRequest'/>", $("#leaveRequestForm").serialize(), function(data) {
			if (data.status == "success") {
				location.reload(true);
			} else {
				alert(data.msg);
			}
		});
	}
	
	function toOrderShooting() {
		location.assign("<c:url value='/shooting'/>");
	}

	function toOrderUploadOriginal() {
		location.assign("<c:url value='/transferImage'/>");
	}

	function toOrderClientChosen() {
		location.assign("<c:url value='/clientWaiting'/>");
	}

	function toOrderConvertImage() {
		location.assign("<c:url value='/convertImage'/>");
	}

	function toOrderFixSkin() {
		location.assign("<c:url value='/fixSkin'/>");
	}

	function toOrderFixBackground() {
		location.assign("<c:url value='/fixBackground'/>");
	}

	function toOrderCutLiquify() {
		location.assign("<c:url value='/cutLiquify'/>");
	}

	function toOrderVerify() {
		location.assign("<c:url value='/verifyImage'/>");
	}
	
	function toLeaveRequest() {
		location.assign("<c:url value='/leaveRequest'/>");
	}
	
	function toUploadFixed() {
		location.assign("<c:url value='/uploadFixed'/>");
	}
</script>