<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<div style="text-align:center;padding-left:60px;">
	<p class="login-header"><span>ORANGE</span> 9 SYSTEM</p>
	<a onclick="showResetPassword()" class="logout" style="right:50px;">账号</a>
	<a onclick="logout()" class="logout">退出</a>
</div>
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
<script>
$("#changePasswordModal").on("hidden.bs.modal", function(e) {
	$("#passwordForm")[0].reset();
});

function logout() {
	$.get("<c:url value='/logout'/>", function() {
		location.replace("<c:url value='/'/>");
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
</script>