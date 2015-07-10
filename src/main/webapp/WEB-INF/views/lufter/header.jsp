<%@ page import="com.xiaofo1022.orange9.modal.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<%
	String pg = request.getParameter("page");
	User user = (User) request.getSession(false).getAttribute("user");
	String roleName = user.getRole().getName();
%>
<div id="changePasswordModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">重置密码</h4>
			</div>
			<div class="modal-body">	
				<sf:form id="passwordForm" modelAttribute="password" class="form-horizontal" method="post">
					<div class="form-group">
						<label class="col-sm-4 control-label">旧密码</label>
						<div class="col-sm-6">
							<input type="password" id="oldPassword" name="oldPassword" class="form-control"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label">新密码</label>
						<div class="col-sm-6">
							<input type="password" id="newPassword" name="newPassword" class="form-control"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label">确认密码</label>
						<div class="col-sm-6">
							<input type="password" id="confirmPassword" name="confirmPassword" class="form-control"/>
						</div>
					</div>
				</sf:form>
			</div>
			<div class="modal-footer">
				<button id="btnResetPassword" type="button" class="btn btn-primary" onclick="resetPassword()">确定</button>
			</div>
		</div>
	</div>
</div>

<div id="indexModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">首页管理</h4>
			</div>
			<div class="modal-body">	
			</div>
			<div class="modal-footer">
				<button id="btnConfirmIndex" type="button" class="btn btn-primary">确定</button>
			</div>
		</div>
	</div>
</div>

<div class="blog-masthead">
	<div class="container">
		<nav class="blog-nav">
			<span class="logo" onclick="backToIndex()"><img src="<c:url value='/images/logo2-1.png'/>"/></span>
			<% if (!roleName.equals("CLIENT")) {%>
				<% if (pg.equals("summary")) { %>
					<a class="blog-nav-item active">订单一览</a>
				<% } else { %>
					<a class="blog-nav-item" href="<c:url value='/orderSummary'/>">订单一览</a>
				<% } %>
				<% if (user.getIsAdmin() == 1) { %>
					<% if (pg.equals("client")) { %>
						<a class="blog-nav-item active">客户管理</a>
					<% } else { %>
						<a class="blog-nav-item" href="<c:url value='/client'/>">客户管理</a>
					<% } %>
					<% if (pg.equals("goods")) { %>
						<a class="blog-nav-item active">货品管理</a>
					<% } else { %>
						<a class="blog-nav-item" href="<c:url value='/orderGoods'/>">货品管理</a>
					<% } %>
					<% if (pg.equals("employee")) { %>
						<a class="blog-nav-item active">员工管理</a>
					<% } else { %>
						<a class="blog-nav-item" href="<c:url value='/employee'/>">员工管理</a>
					<% } %>
					<% if (pg.equals("index")) { %>
						<a class="blog-nav-item active">首页管理</a>
					<% } else { %>
						<a class="blog-nav-item" href="<c:url value='/indexmanage'/>">首页管理</a>
					<% } %>
				<% } %>
			<% } else { %>
				<a class="blog-nav-item active">我的订单</a>
			<% } %>
			<a class="blog-nav-item" onclick="showResetPassword()">账号</a>
			<a class="blog-nav-item" onclick="logout()">退出</a>
		</nav>
	</div>
</div>
<script src="<c:url value='/js/jquery-ui.js'/>"></script>
<script>
$("#changePasswordModal").on("hidden.bs.modal", function(e) {
	$("#passwordForm")[0].reset();
});

function backToIndex() {
	location.assign("<c:url value='/'/>");
}

function logout() {
	$.get("<c:url value='/logout'/>", function(data) {
		location.replace("<c:url value='/lgn'/>");
	});
}

function showResetPassword() {
	$("#changePasswordModal").modal("show");
}

function resetPassword() {
	var oldPassword = $("#oldPassword").val();
	var newPassword = $("#newPassword").val();
	var confirmPassword = $("#confirmPassword").val();
	if (oldPassword == "") {
		alert("请输入旧密码");
		return;
	}
	if (newPassword == "") {
		alert("请输入新密码");
		return;
	}
	if (confirmPassword == "") {
		alert("请输入确认密码");
		return;
	}
	if (newPassword != confirmPassword) {
		alert("密码输入不一致");
		return;
	}
	$.post("<c:url value='/resetPassword'/>", $("#passwordForm").serialize(), function(data) {
		if (data.status == "success") {
			$("#changePasswordModal").modal("hide");
		} else {
			alert(data.msg);
		}
	});
}

function showIndexModal() {
	$("#indexModal").modal("show");
}
</script>