<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orange 9 System</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap-system.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/sidebar/component.css'/>" />
<script src="<c:url value='/js/jquery-1.11.2.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/js/notification/modernizr.custom.js'/>"></script>
<style>
	div.model-block {
		width: 60%;
		padding: 10px;
		margin: 10px;
		margin-left: 150px;
		box-shadow: 0px 0px 5px rgba(240, 173, 78, 0.8);
		border-radius: 4px;
	}
	
	div.model-block img {
		width: 100px;
		float: left;
		margin-right: 10px;
	}
	
	div.model-info {
		float: left;
		width: 300px;
	}
	
	div.model-btns {
		float: left;
		margin-top: 100px;
	}
</style>
</head>
<body>
<div id="st-container" class="st-container">
<div class="st-pusher">
	<nav class="st-menu st-effect-3">
		<h2 class="icon icon-lab"></h2>
		<ul>
			<li><a class="icon icon-data" href="<c:url value='system'/>">员工管理</a></li>
			<li><a class="icon icon-study" href="<c:url value='order'/>">订单统计</a></li>
			<li><a class="icon icon-photo" href="<c:url value='post'/>">后期进度</a></li>
			<li><a class="icon icon-location" href="#">模特资料</a></li>
		</ul>
	</nav>
	
	<div id="st-trigger-effects">
		<button class="btn btn-warning nav-btn" data-effect="st-effect-3">
			<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		</button>
	</div>
	
	<div style="text-align:center;">
		<p class="login-header"><span>ORANGE</span> 9 SYSTEM</p>
	</div>
	
	<button class="btn btn-warning btn-add-employee" data-toggle="modal" data-target="#addModel">添加模特</button>
	
	<!-- Add Model Modal -->
	<div id="addModel" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header orange-model-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">模特资料</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label" for="i-upload-header">上传照片</label>
							<div class="col-sm-4">
								<input class="btn btn-primary" type="file" id="i-upload-header"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="i-name">称呼</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="i-name"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">经济公司</label>
							<div class="col-sm-4">
								<input type="text" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">联系电话</label>
							<div class="col-sm-4">
								<input type="text" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">费用</label>
							<div class="col-sm-4">
								<input type="text" class="form-control"/>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">添加</button>
				</div>
			</div>
		</div>
	</div>
	
	<div id="model-1" class="model-block">
		<img src="<c:url value='/images/model/shaoshao.jpg'/>"/>
		<div class="model-info">
			<p class="model-label">姓名：<span>杜以瑄</span></p>
			<p class="model-label">经济公司：<span>国光帮帮忙影视公司</span></p>
			<p class="model-label">联系电话：<span>13812345678</span></p>
			<p class="model-label">费用：<span>300/小时</span></p>
		</div>
		<div class="model-btns">
			<button class="btn btn-info">模卡</button>
			<button class="btn btn-warning" data-toggle="modal" data-target="#addModel">编辑</button>
			<button class="btn btn-danger">删除</button>
		</div>
		<div class="clear"></div>
	</div>
	
	<div id="model-2" class="model-block">
		<img src="<c:url value='/images/model/ruoying.jpg'/>"/>
		<div class="model-info">
			<p class="model-label">姓名：<span>若颖</span></p>
			<p class="model-label">经济公司：<span>国光帮帮忙影视公司</span></p>
			<p class="model-label">联系电话：<span>13812345678</span></p>
			<p class="model-label">费用：<span>500/小时</span></p>
		</div>
		<div class="model-btns">
			<button class="btn btn-info">模卡</button>
			<button class="btn btn-warning" data-toggle="modal" data-target="#addModel">编辑</button>
			<button class="btn btn-danger">删除</button>
		</div>
		<div class="clear"></div>
	</div>
	
	<div id="model-3" class="model-block">
		<img src="<c:url value='/images/model/changwei.jpg'/>"/>
		<div class="model-info">
			<p class="model-label">姓名：<span>常威</span></p>
			<p class="model-label">经济公司：<span>嘉禾影视</span></p>
			<p class="model-label">联系电话：<span>13812345678</span></p>
			<p class="model-label">费用：<span>500/小时</span></p>
		</div>
		<div class="model-btns">
			<button class="btn btn-info">模卡</button>
			<button class="btn btn-warning" data-toggle="modal" data-target="#addModel">编辑</button>
			<button class="btn btn-danger">删除</button>
		</div>
		<div class="clear"></div>
	</div>
</div>
</div>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script>
	var modelIndex = 0;
	var modelList = [$("#model-1"), $("#model-2"), $("#model-3")];
	
	function pre() {
		modelList[modelIndex].addClass("hidden");
		modelIndex--;
		if (modelIndex < 0) {
			modelIndex = modelList.length - 1;
		}
		modelList[modelIndex].removeClass("hidden");
	}
	
	function next() {
		modelList[modelIndex].addClass("hidden");
		modelIndex++;
		if (modelIndex == modelList.length) {
			modelIndex = 0;
		}
		modelList[modelIndex].removeClass("hidden");
	}
</script>
</body>
</html>