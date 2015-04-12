<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orange 9 System</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap-system.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system/order.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system/orderdetail.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/sidebar/component.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/jquery-ui/jquery-ui.css'/>" />
<script src="<c:url value='/js/jquery-1.11.2.min.js'/>"></script>
<script src="<c:url value='/js/jquery-ui.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/js/notification/modernizr.custom.js'/>"></script>
</head>
<body>
<div id="st-container" class="st-container">
<div class="st-pusher">
	<div style="text-align:center;">
		<p class="login-header"><span>ORANGE</span> 9 SYSTEM</p>
	</div>
	
	<nav class="st-menu st-effect-3">
		<h2 class="icon icon-lab"></h2>
		<ul>
			<li><a class="icon icon-data" href="<c:url value='/orderSummary'/>">订单一览</a></li>
			<li><a class="icon icon-study" href="#">拍摄中(5)</a></li>
			<li><a class="icon icon-study" href="#">导图中(3)</a></li>
			<li><a class="icon icon-photo" href="#">修皮肤及褶皱(10)</a></li>
			<li><a class="icon icon-photo" href="#">修背景(4)</a></li>
			<li><a class="icon icon-photo" href="#">截图液化(3)</a></li>
			<li><a class="icon icon-location" href="#">等待审图(8)</a></li>
			<li><a class="icon icon-location" href="#">完成(11)</a></li>
			<li><a class="icon icon-location" href="<c:url value='/employee'/>">员工管理</a></li>
		</ul>
	</nav>
	
	<div id="st-trigger-effects">
		<button class="btn btn-warning nav-btn" data-effect="st-effect-3">
			<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		</button>
	</div>
	
	<div class="order-block">
		<div class="order-detail-block bd-blue">
			订单详情：
			<span>单号：<span class="oc-label">O900001</span></span>
			<span>拍摄日期：<span class="oc-label">2015-4-12</span></span> 
			<span>状态：</span> 
			<select class="form-control" style="width:140px;display:inline;">
				<option>拍摄中</option>
				<option>拍摄完成</option>
				<option>导图</option>
				<option>修皮肤及褶皱</option>
				<option>修背景</option>
				<option>裁图液化</option>
				<option>审核中</option>
				<option>完成</option>
			</select>
			<span>共计用时：<span class="oc-label">2小时48分</span></span> 
		</div>
		<div class="order-detail-block bd-blue">
			客户信息：
			<span>名称：<span class="oc-label">刘老五</span></span>
			<span>店铺：<a href="">努努潮品</a></span>
			<span>电话：<span class="oc-label">13812345678</span></span>
			<span>邮箱：<span class="oc-label">12345678@qq.com</span></span>
			<br/>
			<span class="p-newrow">备注：<span class="oc-label">我们客户的要求是，不求最好，但求最贵！</span></span>
		</div>
		<div class="order-detail-block bd-blue">
			货品信息：
			<span><span class="oc-label">10</span>件上装</span>
			<span><span class="oc-label">20</span>件下装</span>
			<span><span class="oc-label">15</span>件连体衣</span>
			<span><span class="oc-label">4</span>双鞋子</span>
		</div>
		<div class="order-detail-block bd-blue">
			拍摄信息：
			<span>摄影师：<img src="<c:url value='/images/header/boss.png'/>"/><span class="oc-label">柳海飞</span></span>
			<span>助理：<img src="<c:url value='/images/header/old_man.png'/>"/><span class="oc-label">李学华</span></span>
			<br/>
			<span class="p-newrow">模特：<span class="oc-label">雷迪嘎嘎</span></span>
			<span>化妆师：<span class="oc-label">李妆妆</span></span>
			<span>搭配师：<span class="oc-label">刘搭搭</span></span>
			<span>经纪人：<span class="oc-label">王老六</span></span>
			<span>联系方式：<span class="oc-label">13812345678</span></span>
		</div>
		<div class="order-detail-block bd-blue">
			后期情况：
			<span>导图：<img src="<c:url value='/images/header/old_man.png'/>"/><span class="oc-label">李学华</span></span>
			<span>修皮肤及褶皱：<img src="<c:url value='/images/header/shenyulin.png'/>"/><span class="oc-label">沈玉琳</span></span>
			<span>修背景：<img src="<c:url value='/images/header/zhanglidong.png'/>"/><span class="oc-label">张立东</span></span>
			<span>裁图液化：<img src="<c:url value='/images/header/awei.png'/>"/><span class="oc-label">常威</span></span>
		</div>
		<div class="order-detail-block bd-blue">
			<ul class="nav nav-tabs nav-justified">
				<li role="presentation" class="active detail-bottom-nav">
					<a id="blink1" onclick="changeBottomNavView(this)">原片</a>
				</li>
				<li role="presentation" class="detail-bottom-nav">
					<a id="blink2" onclick="changeBottomNavView(this)">精修</a>
				</li>
				<li role="presentation" class="detail-bottom-nav">
					<a id="blink3" onclick="changeBottomNavView(this)">客户留言</a>
				</li>
				<li role="presentation" class="detail-bottom-nav">
					<a id="blink4" onclick="changeBottomNavView(this)">订单历史状态</a>
				</li>
				<li role="presentation" class="detail-bottom-nav">
					<a id="blink5" onclick="changeBottomNavView(this)">团队留言</a>
				</li>
			</ul>
			<div id="blink1-block" class="detail-bottom-block">
				<div class="pic-block"><img src="<c:url value='/images/post/1.jpg'/>"/><p class="chosen">(001) 客户已选</p></div>
				<div class="pic-block"><img src="<c:url value='/images/post/2.jpg'/>"/><p class="chosen">(002) 客户已选</p></div>
				<div class="pic-block"><img src="<c:url value='/images/post/3.jpg'/>"/><p class="chosen">(003) 客户已选</p></div>
				<div class="pic-block"><img src="<c:url value='/images/post/4.jpg'/>"/><p class="chosen">(004) 客户已选</p></div>
				<div class="pic-block"><img src="<c:url value='/images/post/5.jpg'/>"/><p class="chosen">(005) 客户已选</p></div>
				<div class="pic-block"><img src="<c:url value='/images/post/6.jpg'/>"/><p>(006)</p></div>
				<div class="pic-block"><img src="<c:url value='/images/post/7.jpg'/>"/><p>(007)</p></div>
				<div class="clear"></div>
			</div>
			<div id="blink2-block" class="detail-bottom-block hidden">
				<div class="pic-block"><img src="<c:url value='/images/post/8.jpg'/>"/><p>(008)</p></div>
				<div class="pic-block"><img src="<c:url value='/images/post/9.jpg'/>"/><p>(009)</p></div>
				<div class="pic-block"><img src="<c:url value='/images/post/10.jpg'/>"/><p>(010)</p></div>
				<div class="pic-block"><img src="<c:url value='/images/post/11.jpg'/>"/><p>(011)</p></div>
				<div class="pic-block"><img src="<c:url value='/images/post/12.jpg'/>"/><p>(012)</p></div>
				<div class="pic-block"><img src="<c:url value='/images/post/13.jpg'/>"/><p>(006)</p></div>
				<div class="clear"></div>
			</div>
			<div id="blink3-block" class="detail-bottom-block hidden">
				<p>
					<span class="oc-label">2015-4-12 10:22</span>
					<br/>
					终于修完了，这次合作比较愉快，期待下次哈。
				</p>
				<p>
					<span class="oc-label">2015-4-11 13:31</span>
					<br/>
					嗯，这次收到的图片我们很满意，再接再厉，加快进度！
				</p>
				<p>
					<span class="oc-label">2015-4-10 15:30</span>
					<br/>
					快点啊，我们很急的咧！
				</p>
			</div>
			<div id="blink4-block" class="detail-bottom-block hidden">
				<p>
					2015-4-12 17:13
					<span class="oc-label">导图完成</span></span>
					BY: 
					<span class="oc-label">李学华</span>
				</p>
				<p>
					2015-4-12 15:13
					<span class="oc-label">状态变为：拍摄完成</span></span>
					BY: 
					<span class="oc-label">柳海飞</span>
				</p>
				<p>
					2015-4-12 10:22
					<span class="oc-label">添加订单</span>
					BY: 
					<span class="oc-label">柳海飞</span>
				</p>
			</div>
			<div id="blink5-block" class="detail-bottom-block hidden">
				<p>
					<span class="oc-label">2015-4-12 10:22</span>李学华：
					<br/>
					好的，我们尽快完成。
				</p>
				<p>
					<span class="oc-label">2015-4-11 13:31</span>李学华：
					<br/>
					不要再催啦，我要累死了。。。
				</p>
				<p>
					<span class="oc-label">2015-4-10 15:30</span>柳海飞
					<br/>
					订单添加了，大家加快进度！
				</p>
			</div>
		</div>
	</div>
</div>
</div>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script>
	function changeBottomNavView(nav) {
		var navheader = $("#" + nav.id);
		$(".detail-bottom-block").addClass("hidden");
		$(".detail-bottom-nav").removeClass("active");
		navheader.parent().addClass("active");
		$("#" + nav.id + "-block").removeClass("hidden");
	}
</script>
</body>
</html>