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
<script src="<c:url value='/js/qiniu/plupload.full.min.js' />"></script>
<script src="<c:url value='/js/qiniu/qiniu.js' />"></script>
<script src="<c:url value='/js/qiniu/qiniu_uploader.js' />"></script>
<body>
<jsp:include page="header.jsp" flush="true">
	<jsp:param name="page" value="index"/>
</jsp:include>
<%
	String picType = (String)request.getAttribute("pictype");
	if (picType == null) {
	  picType = "";
	}
%>
<div class="container">
<div class="row">
	<div class="col-sm-12 blog-main" style="width:100%;">
		<div class="clearfix">
			<div class="data-info blank-bc">
				<ul class="nav nav-tabs nav-justified">
					<li role="presentation" class="<% if (picType.equals("enu")) { %> active <% } %> detail-bottom-nav">
						<a id="blink1" onclick="changeBottomNavView('enu')">欧美</a>
					</li>
					<li role="presentation" class="<% if (picType.equals("jnk")) { %> active <% } %>detail-bottom-nav">
						<a id="blink2" onclick="changeBottomNavView('jnk')">日韩</a>
					</li>
					<li role="presentation" class="<% if (picType.equals("sta")) { %> active <% } %>detail-bottom-nav">
						<a id="blink4" onclick="changeBottomNavView('sta')">街拍</a>
					</li>
					<li role="presentation" class="<% if (picType.equals("tog")) { %> active <% } %>detail-bottom-nav">
						<a id="blink3" onclick="changeBottomNavView('tog')">海报</a>
					</li>
				</ul>
				
				<div id="blink1-block" class="detail-bottom-block index-manage-pic clearfix">
					<c:forEach items="${webpics}" var="picmodel">
						<div class="clearfix">
							<div class="data-info blank-bc">
								<c:forEach items="${picmodel.webPics}" var="webpic">
									<img src="<c:url value='http://o6fmbp0tj.bkt.clouddn.com/${webpic.picKey}?imageView2/2/w/100/q/100'/>"/>
								</c:forEach>
								<div class="index-position-info facebook-bc">
									位置 ${picmodel.folderPic.picIndex}
								</div>
								<button class="btn btn-danger fright" onclick="deleteIndexPicture('enu', '${picmodel.folderPic.picIndex}')">删除</button>
							</div>
						</div>
					</c:forEach>
					<div id="container">
						<button id="pickfiles" class="btn btn-info">添加</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="uploadimagemodal.jsp" flush="true"/>
	
	<input id="pic-type" type="hidden" value="${pictype}"/>
</div>
</div>
<script>
	var baseUrl = "<c:url value='/'/>";
	var uploader;
	var pictype = $("#pic-type").val();
	var webPics = [];
	
	+function init() {
		$.get("<c:url value='/webpic/getUpToken'/>", function(data) {
			uploader = getUploader(data);
		});
	}();

	function postWebPics() {
	  AjaxUtil.post("<c:url value='/webpic/addWebPic'/>", webPics, function(data) {
	    location.reload();
	  });
	}
	
	function changeBottomNavView(pictype) {
	  location.assign("<c:url value='/indexmanage/" + pictype + "'/>");
	}
	
	function deleteIndexPicture(path, picname) {
		var result = confirm("是否确认删除?");
		if (result) {
		}
	}
</script>
</body>
</html>