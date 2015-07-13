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
<body>
<jsp:include page="header.jsp" flush="true">
	<jsp:param name="page" value=""/>
</jsp:include>

<div class="container">
<div class="row">

	<div class="col-sm-12 blog-main" style="width:100%;">
		<input type="hidden" value="${clientId}" id="client-id"/>
		<c:forEach items="${clientOrderList}" var="clientOrder">
			<div class="data-block">
				<div class="clearfix">
					<div class="data-info lofter-bc">单号 ${clientOrder.orderNo}</div>
					<div class="data-info lofter-bc">拍摄日期 ${clientOrder.shootDateLabel} ${clientOrder.shootHalf}</div>
					<div class="data-info lofter-bc">订单状态 ${clientOrder.status}</div>
				</div>
				<div class="clearfix">
					<c:choose>
						<c:when test="${clientOrder.status.equals('完成') && clientOrder.completeRemark == null}">
							<c:forEach items="${clientOrder.orderFixedImageDataList}" var="imageData" varStatus="status">
								<c:if test="${status.index < 9}">
									<img class="client-order-list-img" src="<c:url value='/pictures/fixed/${imageData.orderId}/compress/${imageData.fileName}.jpg'/>"/>
								</c:if>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach items="${clientOrder.orderTransferImageDataList}" var="imageData" varStatus="status">
								<c:if test="${status.index < 9}">
									<img class="client-order-list-img" src="<c:url value='/pictures/original/${imageData.orderId}/compress/${imageData.fileName}.jpg'/>"/>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="clearfix">
					<c:choose>
						<c:when test="${clientOrder.status.equals('完成')}">
							<button class="btn btn-primary ml10 fright" onclick="orderDetail(${clientOrder.orderId})">订单详情</button>
						</c:when>
						<c:otherwise>
							<button class="btn btn-success ml10 fright" onclick="orderDetail(${clientOrder.orderId})">进入选片</button>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${clientOrder.status.equals('完成') && clientOrder.completeRemark == null}">
							<button class="btn btn-info ml10 fright" onclick="downloadZip(${clientOrder.orderId})">成片下载</button>
						</c:when>
					</c:choose>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
</div>
<input class="hidden" multiple="multiple" type="file" id="complete-post-production"/>
<script>
	var clientId = $("#client-id").val();
	
	function orderDetail(orderId) {
		location.assign("<c:url value='/client/main/" + clientId + "/" + orderId + "'/>");
	}
	
	function downloadZip(orderId) {
		window.open("<c:url value='/client/getFixedImageZipPackage/" + orderId + "'/>");
	}
	
	function downloadCompressZip(orderId) {
		window.open("<c:url value='/client/downloadOriginalCompressPicture/" + orderId + "'/>");
	}
</script>
</body>
</html>