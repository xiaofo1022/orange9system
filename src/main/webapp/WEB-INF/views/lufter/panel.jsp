<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String link = request.getParameter("link"); %>
<script src="<c:url value='/js/lufter/nav.js'/>"></script>
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
		<div class="order-link whover" onclick="toOrderVerify()">
			<% if (link != null && link.equals("verify")) { %>
				<span class="order-link-nav glyphicon glyphicon-star"></span>
			<% } %>
			<p>等待审核</p>
			<span class="nav-sidebar"></span>
		</div>
	</div>
</div>
<script>
	$.get("<c:url value='/order/getOrderStatusCountMap'/>", function(data, status) {
		$(".nav-sidebar").each(function(){
			var text = $(this).prev().text();
			if (data[text] != null && data[text] != undefined) {
				$(this).text(data[text]);
			}
		});
	});
	
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
</script>