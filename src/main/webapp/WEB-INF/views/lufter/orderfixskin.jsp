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
<script src="<c:url value='/js/util/ajax-util.js'/>"></script>
<body>
<jsp:include page="header.jsp" flush="true">
	<jsp:param name="page" value=""/>
</jsp:include>
	
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
					<div class="data-info facebook-bc order-detail-header" style="margin-left:0px;">设计师 ${postProduction.operator.name} <img src="${postProduction.operator.header}"/></div>
					<c:if test="${user.isAdmin == 1 || user.id == postProduction.operatorId}">
						<button id="btn-confirm-${postProduction.orderId}" class="btn btn-info btn-data-info" onclick="downloadZip(${postProduction.orderId})">打包下载</button>
						<button id="btn-upload-${postProduction.orderId}" class="btn btn-success btn-data-info" onclick="completePostProduction(${postProduction.orderId})">批量上传</button>
						<button class="btn btn-warning btn-data-info" onclick="nextStep(${postProduction.orderId})">修图完成</button>
					</c:if>
				</div>
				<div class="clearfix">
					<div class="data-info facebook-bc" style="margin-left:0;">图片 ${postProduction.fileNames}</div>
				</div>
			</div>
		</c:forEach>
		<input class="hidden" multiple="multiple" type="file" id="complete-post-production"/>
	</div>
	
	<jsp:include page="panel.jsp" flush="true">
		<jsp:param name="link" value="fixskin"/>
	</jsp:include>
	
	<jsp:include page="uploadimagemodal.jsp" flush="true"/>
</div>
</div>
<script>
	function completePostProduction(orderId) {
		compOrderId = orderId;
		uploadUrl = "<c:url value='/picture/saveFixSkinPicture'/>";
		$("#complete-post-production").click();
	}
	
	function downloadZip(orderId) {
		window.open("<c:url value='/picture/downloadOriginalPicture/" + orderId + "'/>");
	}
	
	function nextStep(orderId) {
		var result = confirm("是否确认完成修皮肤及褶皱？");
		if (result) {
			$.post("<c:url value='/orderPostProduction/setFixSkinNextStep/" + orderId + "'/>", null, function(data, status) {
				if (data.status == "success") {
					location.reload(true);
				}
			});
		}
	}
</script>
</body>
</html>