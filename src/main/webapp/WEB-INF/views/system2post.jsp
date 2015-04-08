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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system/post.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/sidebar/component.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/notification/ns-default.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/notification/ns-style-other.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/notification/ns-style-attached.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/jquery-ui/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/progress/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/progress/number-pb.css'/>" />
<script src="<c:url value='/js/jquery-1.11.2.min.js'/>"></script>
<script src="<c:url value='/js/jquery-ui.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/js/svg/snap.svg-min.js'/>"></script>
<script src="<c:url value='/js/notification/modernizr.custom.js'/>"></script>
<script src="<c:url value='/js/progress/jquery.velocity.min.js'/>"></script>
<script src="<c:url value='/js/progress/number-pb.js'/>"></script>
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
			<li><a class="icon icon-study" href="<c:url value='order'/>">订单统计</a></li>
			<li><a class="icon icon-photo" href="#">后期进度</a></li>
			<li><a class="icon icon-location" href="<c:url value='model'/>">模特资料</a></li>
		</ul>
	</nav>
	
	<div id="st-trigger-effects">
		<button class="btn btn-warning nav-btn" data-effect="st-effect-3">
			<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		</button>
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
		<p class="model-label fleft post-order">单号：<span>O90001</span></p>
		<button class="btn btn-danger fleft" onclick="hurryWarning()">催一下</button>
		<div class="employee-process" style="width:100%;">
			<section id="sample-pb">
				<article class="num-progress">
					<h4 id="t-order1" class="num-progress-title"></h4>
					<div id="b-order1" class="number-pb">
						<div class="number-pb-shown"></div>
						<div class="number-pb-num">0</div>
					</div>
				</article>
			</section>
		</div>
		<div class="post-block">
			<div class="post-img post-done" onclick="showDonePicture(this)"><img src="<c:url value='/images/post/1.jpg'/>"/></div>
			<div class="post-img post-done" onclick="showDonePicture(this)"><img src="<c:url value='/images/post/2.jpg'/>"/></div>
			<div class="post-img post-undo" onclick="showUndoPicture(this)"><img src="<c:url value='/images/post/3.jpg'/>"/></div>
			<div class="post-img post-undo" onclick="showUndoPicture(this)"><img src="<c:url value='/images/post/4.jpg'/>"/></div>
			<div class="post-img post-back"
				data-container="body" data-toggle="popover" data-placement="top" data-trigger="hover"
				data-content="颜色不准"
				onclick="showDonePicture(this)">
				<img src="<c:url value='/images/post/5.jpg'/>"/>
			</div>
			<div class="post-img post-back"
				data-container="body" data-toggle="popover" data-placement="top" data-trigger="hover"
				data-content="客户不满意"
				onclick="showDonePicture(this)">
				<img src="<c:url value='/images/post/6.jpg'/>"/>
			</div>
			<div class="post-img post-undo" onclick="showUndoPicture(this)"><img src="<c:url value='/images/post/7.jpg'/>"/></div>
			<div class="post-img post-undo" onclick="showUndoPicture(this)"><img src="<c:url value='/images/post/8.jpg'/>"/></div>
		</div>
		<div class="clear"></div>
	</div>
		
	<div id="undoPicture" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog pic-modal">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">未修图片</h4>
				</div>
				<div id="undoPictureBody" class="modal-body">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="hurryWarning()">催一下</button>
				</div>
			</div>
		</div>
	</div>
	
	<div id="donePicture" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog pic-modal">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">已修图片</h4>
				</div>
				<div id="donePictureBody" class="modal-body">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#picBack">返修</button>
					<button type="button" class="btn btn-success" data-dismiss="modal">通过</button>
				</div>
			</div>
		</div>
	</div>
	
	<div id="picBack" class="modal fade text-left" style="z-index:1999;" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">返修</h4>
				</div>
				<div class="modal-body">
					<h4>原因</h4>
					<textarea class="form-control" row="4"></textarea>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="closeBackPic()">确定</button>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/notification/notificationFx.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script src="<c:url value='/js/progress/processer.js'/>"></script>
<script src="<c:url value='/js/notification/thumbslider.js'/>"></script>
<script>
$(function () {
	$('[data-toggle="popover"]').popover({html:true})
});

var thumbslider = new NotificationThumbslider();
function hurryWarning() {
	thumbslider.showMessage("订单O90001快一点，我等到花儿都谢了！");
}
	
var porder1 = new Processer("t-order1", "b-order1", "共8张");
porder1.run(2, 8);

var porder2 = new Processer("t-order2", "b-order2", "共8张");
porder2.run(7, 8);

var porder3 = new Processer("t-order3", "b-order3", "共8张");
porder3.run(1, 8);

var porder4 = new Processer("t-order4", "b-order4", "共8张");
porder4.run(8, 8);

function showUndoPicture(component) {
	$("#undoPictureBody").html(component.innerHTML);
	$("#undoPicture").modal("show");
}

function showDonePicture(component) {
	$("#donePictureBody").html(component.innerHTML);
	$("#donePicture").modal("show");
}

function closeBackPic() {
	$("#donePicture").modal("hide");
}
</script>
</body>
</html>