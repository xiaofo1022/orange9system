<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>Orange 9</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="xiaofo">
<link rel="icon" href="<c:url value="/images/favicon.ico"/>" type="image/x-icon" /> 
<link rel="shortcut icon" href="<c:url value="/images/favicon.ico"/>" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap.lufter.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/lufter/lufter.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/lufter/page.css'/>" />
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<body class="blank-bg">
<div class="container">
<div class="row">
	<div class="col-sm-12 blog-main" style="width:100%;">
		<jsp:include page="header.jsp" flush="true">
			<jsp:param name="link" value="${path}"/>
		</jsp:include>
		<div class="clearfix">
			<div class="index-col">
				<c:forEach items="${pictureCol1List}" var="picture" varStatus="index">
					<a id="index-${path}-${picture.indexPicname}" class="index-pic-link pos-relative fleft">
						<img src="<c:url value='/images/show/${path}/${picture.indexPicname}.jpg'/>"/>
						<span class="index-info-block sbg1">Show It</span>
					</a>
				</c:forEach>
			</div>
			
			<div class="index-col">
				<c:forEach items="${pictureCol2List}" var="picture" varStatus="index">
					<a id="index-${path}-${picture.indexPicname}" class="index-pic-link pos-relative fleft">
						<img src="<c:url value='/images/show/${path}/${picture.indexPicname}.jpg'/>"/>
						<span class="index-info-block sbg1">Show It</span>
					</a>
				</c:forEach>
			</div>
			
			<div class="index-col">
				<c:forEach items="${pictureCol3List}" var="picture" varStatus="index">
					<a id="index-${path}-${picture.indexPicname}" class="index-pic-link pos-relative fleft">
						<img src="<c:url value='/images/show/${path}/${picture.indexPicname}.jpg'/>"/>
						<span class="index-info-block sbg1">Show It</span>
					</a>
				</c:forEach>
			</div>
		</div>
		<jsp:include page="footer.jsp" flush="true"/>
	</div>
</div>
</div>
<script>
createIndexLink();

function createIndexLink() {
	$(".index-pic-link").mouseover(function(e) {
		var current = $(e.currentTarget);
		var span = current.find("span.index-info-block");
		var img = current.find("img");
		span.css("height", img.css("height"));
		span.css("opacity", "1.0");
	});
	$(".index-pic-link").mouseout(function(e) {
		var current = $(e.currentTarget);
		var span = current.find("span.index-info-block");
		var img = current.find("img");
		span.css("height", img.css("height"));
		span.css("opacity", "0.0");
	});
	$(".index-pic-link").click(function(e) {
		var current = $(e.currentTarget);
		var ids = current.attr("id").split("-");
		location.assign("<c:url value='/picdetail/" + ids[1] + "/" + ids[2] + "'/>");
	});
}
</script>
</body>
</html>