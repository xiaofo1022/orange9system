<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orange 9 System</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap-system.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system/order.css'/>"/>
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
			<li><a class="icon icon-data" href="<c:url value='/system'/>">员工管理</a></li>
			<li><a class="icon icon-study" href="#">订单统计</a></li>
			<li><a class="icon icon-photo" href="<c:url value='post'/>">后期进度</a></li>
			<li><a class="icon icon-location" href="<c:url value='model'/>">模特资料</a></li>
		</ul>
	</nav>
	
	<div id="st-trigger-effects">
		<button class="btn btn-warning nav-btn" data-effect="st-effect-3">
			<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		</button>
	</div>
	
	<button class="btn btn-warning btn-add-employee" data-toggle="modal" data-target="#addOrder">添加订单</button>
	
	<!-- Add Order Modal -->
	<div id="addOrder" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header orange-model-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">添加订单</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">拍摄日期</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="i-shot-date"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">关键词</label>
							<div class="col-sm-4">
								<select class="form-control">
									<option>女装模拍</option>
									<option>男装模拍</option>
									<option>静物</option>
									<option>挂拍</option>
									<option>3D</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">店铺名称</label>
							<div class="col-sm-4">
								<input type="text" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">店铺连接</label>
							<div class="col-sm-6">
								<input type="text" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">手机号</label>
							<div class="col-sm-4">
								<input type="text" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">单额</label>
							<div class="col-sm-4">
								<input type="text" class="form-control"/>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="order-block">
		<div style="width:100px;float:left;">
			<p class="model-label fleft">智能检索</p>
		</div>
		<div style="width:100px;float:left;">
			<select class="form-control">
				<option>单号</option>
				<option>客户</option>
				<option>关键词</option>
				<option>店铺</option>
			</select>
		</div>
		<div style="width:200px;float:left;margin-left:10px;">
			<input type="text" class="form-control"/>
		</div>
		<div class="clear"></div>
	</div>
	
	<div class="order-block">
		<p class="model-label">单号：<span>O90001</span></p>
		<div class="order-bar">
			<div class="order-bar-step s1">准备中</div>
		</div>
		<div class="order-info">
			<p class="order-label">客户：<a href="http://wanwanke.taobao.com/" target="_blank">努努潮品</a></p>
			<p class="order-label">拍摄日期：<span>2015-4-6</span></p>
			<p class="order-label">关键词：<span>静物</span></p>
			<p class="order-label">单额：<span>20（件）* 150</span> = 3000</p>
			<button class="btn btn-primary btn-nextstep" data-toggle="modal" data-target="#selectPhotographer">下一步</button>
		</div>

		<div class="clear"></div>
	</div>
	
	<div class="order-block">
		<p class="model-label">单号：<span>O90002</span></p>
		<div class="order-bar">
			<div class="order-bar-step s1">准备中</div>
			<div class="order-bar-step s2">拍摄中
				<div class="popover top order-process-tip">
					<div class="arrow"></div>
					<div class="popover-content tip-context">
						<p><img src="<c:url value='/images/header/zhanglidong.png'/>"/><span>摄影师: 张立东</span></p>
					</div>
				</div>
			</div>
		</div>
		<div class="order-info">
			<p class="order-label">客户：<a href="http://gelintiyu.taobao.com/" target="_blank">格林体育</a></p>
			<p class="order-label">拍摄日期：<span>2015-4-7</span></p>
			<p class="order-label">关键词：<span>挂拍</span></p>
			<p class="order-label">单额：<span>10（件）* 150</span> = 1500</p>
			<button class="btn btn-primary btn-nextstep" data-toggle="modal" data-target="#selectModel">下一步</button>
		</div>
		
		<div class="clear"></div>
	</div>
	
	<div class="order-block">
		<p class="model-label">单号：<span>O90003</span></p>
		<div class="order-bar">
			<div class="order-bar-step s1">准备中</div>
			<div class="order-bar-step s2">拍摄中</div>
			<div class="order-bar-step s3">后期中
				<div class="popover top order-process-tip">
					<div class="arrow"></div>
					<div class="popover-content tip-context">
						<p><img src="<c:url value='/images/header/old_man.png'/>"/><span>设计师: 老人</span></p>
					</div>
				</div>
			</div>
		</div>
		<div class="order-info">
			<p class="order-label">客户：<a href="http://3point.taobao.com/" target="_blank">三分球正品</a></p>
			<p class="order-label">拍摄日期：<span>2015-4-8</span></p>
			<p class="order-label">关键词：<span>男装模拍</span></p>
			<p class="order-label">单额：<span>100（件）* 150</span> = 15000</p>
			<button class="btn btn-primary btn-nextstep">下一步</button>
		</div>
	
		<div class="clear"></div>
	</div>
	
	<div class="order-block">
		<p class="model-label">单号：<span>O90004</span></p>
		<div class="order-bar">
			<div class="order-bar-step s1">准备中</div>
			<div class="order-bar-step s2">拍摄中</div>
			<div class="order-bar-step s3">后期中</div>
			<div class="order-bar-step s4">完成</div>
		</div>
		<div class="order-info">
			<p class="order-label">客户：<a href="http://forever21china.taobao.com/" target="_blank">Forever21官方直营店</a></p>
			<p class="order-label">拍摄日期：<span>2015-4-9</span></p>
			<p class="order-label">关键词：<span>女装模拍</span></p>
			<p class="order-label">单额：<span>10（件）* 100</span> = 1000</p>
		</div>
		
		<div class="clear"></div>
	</div>
	
	<!-- Select Photograhper -->
	<div id="selectPhotographer" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header orange-model-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">要指定哪位摄影师来拍呢？</h4>
				</div>
				<div class="modal-body">
					<div class="photograhper-block">
						<img src="<c:url value='/images/header/zhanglidong.png'/>"/>
						<p class="order-label"><span>张立东</span></p>
						<button class="btn btn-warning" data-dismiss="modal">就是他了</button>
						<div class="clear"></div>
					</div>
					<div class="photograhper-block">
						<img src="<c:url value='/images/header/miyuankangzheng.png'/>"/>
						<p class="order-label"><span>米原康正</span></p>
						<button class="btn btn-warning" data-dismiss="modal">就是他了</button>
						<div class="clear"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Select Model -->
	<div id="selectModel" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header orange-model-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">要选哪位麻豆来拍呢？</h4>
				</div>
				<div class="modal-body">
					<div class="photograhper-block">
						<img src="<c:url value='/images/header/awei.png'/>"/>
						<p class="order-label"><span>常威</span></p>
						<button class="btn btn-warning" data-dismiss="modal">就是他了</button>
						<div class="clear"></div>
					</div>
					<div class="photograhper-block">
						<img src="<c:url value='/images/header/ruoying.png'/>"/>
						<p class="order-label"><span>若颖</span></p>
						<button class="btn btn-warning" data-dismiss="modal">就是她了</button>
						<div class="clear"></div>
					</div>
					<div class="photograhper-block">
						<img src="<c:url value='/images/header/nana.png'/>"/>
						<p class="order-label"><span>娜娜</span></p>
						<button class="btn btn-warning" data-dismiss="modal">就是她了</button>
						<div class="clear"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script>
$('#i-shot-date').datepicker();
</script>
</body>
</html>