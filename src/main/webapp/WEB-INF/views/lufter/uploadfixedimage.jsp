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
<link rel="icon" href="<c:url value="/images/favicon.ico"/>" type="image/x-icon" /> 
<link rel="shortcut icon" href="<c:url value="/images/favicon.ico"/>" type="image/x-icon" />
<link href="<c:url value='/css/bootstrap.lufter.css'/>" rel="stylesheet"/>
<link href="<c:url value='/css/lufter/lufter.css'/>" rel="stylesheet"/>
<link href="<c:url value='/css/jquery-ui/jquery-ui.css'/>" rel="stylesheet"/>
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/js/util/ajax-util.js'/>"></script>
<body>
<jsp:include page="header.jsp" flush="true">
	<jsp:param name="page" value=""/>
</jsp:include>

<div id="skipModal" class="modal fade text-left" style="z-index:1999;" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<input type="hidden" id="order-id"/>
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">其他方式上传成片</h4>
			</div>
			<div class="modal-body">
				<textarea id="reason" class="form-control" rows="4" maxlength="100"></textarea>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-warning" onclick="skipOrderComplete()">确定</button>
			</div>
		</div>
	</div>
</div>

<div class="container">
<div class="row">

	<div class="col-sm-8 blog-main">
		<c:forEach items="${postProductionList}" var="postProduction">
			<div class="data-block">
				<div class="clearfix">
					<div class="data-title lofter-bc" style="margin-left:0;">
					单号 <a href="<c:url value='/order/orderDetail/${postProduction.orderId}'/>" target="_blank">${postProduction.orderNo}</a>
					</div>
				</div>
				<div class="clearfix">
					<div class="data-info facebook-bc" style="margin-left:0;">${postProduction.imageCount} 张未上传</div>
					<c:if test="${user.isAdmin == 1}">
						<button class="btn btn-info btn-data-info" onclick="completePostProduction(${postProduction.orderId})">上传成片</button>
						<button class="btn btn-warning btn-data-info" onclick="showSkipModal(${postProduction.orderId})">其他方式</button>
						<button class="btn btn-success btn-data-info" onclick="nextStep(${postProduction.orderId})">完成上传</button>
					</c:if>
				</div>
				<div class="clearfix">
					<div class="data-info facebook-bc" style="margin-left:0;">${postProduction.fileNames}</div>
				</div>
			</div>
		</c:forEach>
	</div>
	
	<jsp:include page="panel.jsp" flush="true">
		<jsp:param name="link" value="uploadfixed"/>
	</jsp:include>
	
	<jsp:include page="uploadimagemodal.jsp" flush="true"/>
</div>
</div>
<script>
	function completePostProduction(orderId) {
		compOrderId = orderId;
		uploadUrl = "<c:url value='/orderPostProduction/uploadFixedImage'/>";
		$("#complete-post-production").click();
	}
	
	function nextStep(orderId) {
		var result = confirm("是否确认上传完成？");
		if (result) {
			$.get("<c:url value='/picture/checkUploadedFixedImage/" + orderId + "'/>", function(data, status) {
				if (data.result) {
					$.post("<c:url value='/orderPostProduction/setCutLiquifyNextStep/" + orderId + "'/>", null, function(data, status) {
						if (data.status == "success") {
							location.reload(true);
						}
					});
				} else {
					alert(data.message);
				}
			});
		}
	}
	
	function showSkipModal(orderId) {
		$("#skipModal").modal("show");
		$("#order-id").val(orderId);
	}
	
	function skipOrderComplete() {
		var orderId = $("#order-id").val();
		var reason = $("#reason").val();
		AjaxUtil.post("<c:url value='/orderPostProduction/skipOrderToComplete/" + orderId + "'/>", {reason:reason}, function(data, status) {
			if (data.status == "success") {
				location.reload(true);
			}
		});
	}
</script>
</body>
</html>