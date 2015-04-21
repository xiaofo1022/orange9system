<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="st-menu st-effect-3">
	<h2 class="icon icon-lab"></h2>
	<ul>
		<li><a class="icon icon-data" href="<c:url value='/orderSummary'/>">订单一览</a></li>
		<li><a class="icon icon-study nav-sidebar" href="#">拍摄中</a></li>
		<li><a class="icon icon-study nav-sidebar" href="<c:url value='/transferImage'/>">上传原片</a></li>
		<li><a class="icon icon-photo nav-sidebar" href="<c:url value='/clientWaiting'/>">等待客户选片</a></li>
		<li><a class="icon icon-photo nav-sidebar" href="<c:url value='/convertImage'/>">导图</a></li>
		<li><a class="icon icon-photo nav-sidebar" href="#">修皮肤及褶皱</a></li>
		<li><a class="icon icon-photo nav-sidebar" href="#">修背景</a></li>
		<li><a class="icon icon-photo nav-sidebar" href="#">裁图液化</a></li>
		<li><a class="icon icon-location nav-sidebar" href="#">审图</a></li>
		<li><a class="icon icon-location nav-sidebar" href="#">完成</a></li>
		<li><a class="icon icon-location nav-sidebar" href="<c:url value='/employee'/>">员工管理</a></li>
	</ul>
</nav>
<script>
$.get("<c:url value='/order/getOrderStatusCountMap'/>", function(data, status) {
	$(".nav-sidebar").each(function(){
		var text = $(this).text();
		if (data[text] != null && data[text] != undefined) {
			$(this).text(text + "(" + data[text] + ")");
		}
	});
});
</script>