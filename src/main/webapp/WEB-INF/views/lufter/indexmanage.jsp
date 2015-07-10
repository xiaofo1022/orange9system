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
<link href="<c:url value='/css/zoom.css'/>" rel="stylesheet"/>
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/js/util/ajax-util.js'/>"></script>
<body>
<jsp:include page="header.jsp" flush="true">
	<jsp:param name="page" value="index"/>
</jsp:include>

<div class="container">
<div class="row">
	<div class="col-sm-12 blog-main" style="width:100%;">
		<div class="clearfix">
			<div class="data-info blank-bc">
				<ul class="nav nav-tabs nav-justified">
					<li role="presentation" class="active detail-bottom-nav">
						<a id="blink1" onclick="changeBottomNavView(this)">欧美</a>
					</li>
					<li role="presentation" class="detail-bottom-nav">
						<a id="blink2" onclick="changeBottomNavView(this)">日韩</a>
					</li>
					<li role="presentation" class="detail-bottom-nav">
						<a id="blink4" onclick="changeBottomNavView(this)">街拍</a>
					</li>
					<li role="presentation" class="detail-bottom-nav">
						<a id="blink3" onclick="changeBottomNavView(this)">海报</a>
					</li>
				</ul>
				<div id="blink1-block" class="detail-bottom-block index-manage-pic clearfix">
					<c:forEach items="${enu}" var="enuPicture">
						<div class="clearfix">
							<div class="data-info blank-bc">
								<img src="<c:url value='/images/show/enu/${enuPicture.indexPicname}.jpg'/>"/>
								<div class="index-position-info facebook-bc">
									位置 ${enuPicture.indexPicname}
								</div>
								<button class="btn btn-danger fright" onclick="deleteIndexPicture('enu', '${enuPicture.indexPicname}')">删除</button>
							</div>
							<div class="data-info blank-bc">
								<c:forEach items="${enuPicture.detailPicnameList}" var="detailPicname">
									<img src="<c:url value='/images/show/enu/${enuPicture.indexPicname}/${detailPicname}.jpg'/>"/>
								</c:forEach>
							</div>
						</div>
					</c:forEach>
					<button class="btn btn-info fright" onclick="uploadIndexPicture('enu', '${enunextpic}')">添加</button>
				</div>
				<div id="blink2-block" class="detail-bottom-block index-manage-pic hidden clearfix">
					<c:forEach items="${jnk}" var="picture">
						<div class="clearfix">
							<div class="data-info blank-bc">
								<img src="<c:url value='/images/show/jnk/${picture.indexPicname}.jpg'/>"/>
								<div class="index-position-info facebook-bc">
									位置 ${picture.indexPicname}
								</div>
								<button class="btn btn-danger fright" onclick="deleteIndexPicture('jnk', '${picture.indexPicname}')">删除</button>
							</div>
							<div class="data-info blank-bc">
								<c:forEach items="${picture.detailPicnameList}" var="detailPicname">
									<img src="<c:url value='/images/show/jnk/${picture.indexPicname}/${detailPicname}.jpg'/>"/>
								</c:forEach>
							</div>
						</div>
					</c:forEach>
					<button class="btn btn-info fright" onclick="uploadIndexPicture('jnk', '${jnknextpic}')">添加</button>
				</div>
				<div id="blink3-block" class="detail-bottom-block index-manage-pic hidden clearfix">
					<c:forEach items="${sta}" var="picture">
						<div class="clearfix">
							<div class="data-info blank-bc">
								<img src="<c:url value='/images/show/sta/${picture.indexPicname}.jpg'/>"/>
								<div class="index-position-info facebook-bc">
									位置 ${picture.indexPicname}
								</div>
								<button class="btn btn-danger fright" onclick="deleteIndexPicture('sta', '${picture.indexPicname}')">删除</button>
							</div>
							<div class="data-info blank-bc">
								<c:forEach items="${picture.detailPicnameList}" var="detailPicname">
									<img src="<c:url value='/images/show/sta/${picture.indexPicname}/${detailPicname}.jpg'/>"/>
								</c:forEach>
							</div>
						</div>
					</c:forEach>
					<button class="btn btn-info fright" onclick="uploadIndexPicture('sta', '${stanextpic}')">添加</button>
				</div>
				<div id="blink4-block" class="detail-bottom-block index-manage-pic hidden clearfix">
					<c:forEach items="${tog}" var="picture">
						<div class="clearfix">
							<div class="data-info blank-bc">
								<img src="<c:url value='/images/show/tog/${picture.indexPicname}.jpg'/>"/>
								<div class="index-position-info facebook-bc">
									位置 ${picture.indexPicname}
								</div>
								<button class="btn btn-danger fright" onclick="deleteIndexPicture('tog', '${picture.indexPicname}')">删除</button>
							</div>
							<div class="data-info blank-bc">
								<c:forEach items="${picture.detailPicnameList}" var="detailPicname">
									<img src="<c:url value='/images/show/tog/${picture.indexPicname}/${detailPicname}.jpg'/>"/>
								</c:forEach>
							</div>
						</div>
					</c:forEach>
					<button class="btn btn-info fright" onclick="uploadIndexPicture('tog', '${tognextpic}')">添加</button>
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="uploadimagemodal.jsp" flush="true"/>
</div>
</div>
<script>
	function changeBottomNavView(nav) {
		var navheader = $("#" + nav.id);
		$(".detail-bottom-block").addClass("hidden");
		$(".detail-bottom-nav").removeClass("active");
		navheader.parent().addClass("active");
		$("#" + nav.id + "-block").removeClass("hidden");
	}
	
	function deleteIndexPicture(path, picname) {
		var result = confirm("是否确认删除?");
		if (result) {
			$.post("<c:url value='/picture/deleteIndexPicture/" + path + "/" + picname + "'/>", null, function(data) {
				if (data.status == "success") {
					location.reload(true);
				}
			});
		}
	}
	
	function uploadIndexPicture(path, picname) {
		uploadUrl = "<c:url value='/picture/uploadIndexPicture/" + path + "/" + picname + "'/>";
		$("#complete-post-production").click();
	}
</script>
</body>
</html>