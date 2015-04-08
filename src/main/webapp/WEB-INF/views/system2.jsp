<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orange 9 System</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap-system.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/notification/ns-default.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/notification/ns-style-other.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/jquery-ui/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/sidebar/component.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/progress/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/progress/number-pb.css'/>" />
<script src="<c:url value='/js/jquery-1.11.2.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/js/jquery-ui.js'/>"></script>
<script src="<c:url value='/js/svg/snap.svg-min.js'/>"></script>
<script src="<c:url value='/js/notification/modernizr.custom.js'/>"></script>
<script src="<c:url value='/js/progress/jquery.velocity.min.js'/>"></script>
<script src="<c:url value='/js/progress/number-pb.js'/>"></script>
</head>
<body>
<div id="st-container" class="st-container">
<div class="st-pusher">
	<nav class="st-menu st-effect-3">
		<h2 class="icon icon-lab"></h2>
		<ul>
			<li><a class="icon icon-data" href="#">员工管理</a></li>
			<li><a class="icon icon-study" href="<c:url value='order'/>">订单统计</a></li>
			<li><a class="icon icon-photo" href="<c:url value='post'/>">后期进度</a></li>
			<li><a class="icon icon-location" href="<c:url value='model'/>">模特资料</a></li>
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
	<div class="notification-shape shape-box" id="notification-shape" data-path-to="m 0,0 500,0 0,500 -500,0 z">
		<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="0 0 500 500" preserveAspectRatio="none">
			<path d="m 0,0 500,0 0,500 0,-500 z"/>
		</svg>
	</div>
	
	<button class="btn btn-warning btn-add-employee" data-toggle="modal" data-target="#addEmployee">添加员工</button>
	
	<!-- Add Employee Modal -->
	<div id="addEmployee" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header orange-model-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">员工资料</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label" for="i-upload-header">上传头像</label>
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
							<label class="col-sm-2 control-label">职位</label>
							<div class="col-sm-4">
								<select class="form-control">
									<option>摄影师</option>
									<option>后期</option>
									<option>助理</option>
									<option>其他</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">手机号</label>
							<div class="col-sm-4">
								<input type="text" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">初始账号</label>
							<div class="col-sm-4">
								<input type="text" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">初始密码</label>
							<div class="col-sm-4">
								<input type="password" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">确认密码</label>
							<div class="col-sm-4">
								<input type="password" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">基本工资</label>
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
	
	<!-- Card Statistics -->
	<div id="cardStatistics" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">考勤统计</h4>
				</div>
				<div class="modal-body">	
					<div>
						<div class="chart-control1">
							<select class="form-control">
								<option>2015</option>
								<option>2014</option>
								<option>2013</option>
								<option>2012</option>
							</select>
						</div>
						<div class="chart-control2">
							<select class="form-control" onchange="changeCardChart()">
								<option>4月</option>
								<option>3月</option>
								<option>2月</option>
								<option>1月</option>
							</select>
						</div>
						<div class="clear"></div>
					</div>
					<div id="cardChartBody" class="card-chart"></div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Performance Statistics -->
	<div id="performanceStatistics" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">绩效统计</h4>
				</div>
				<div class="modal-body">	
					<div id="performanceCardBody" style="width:860px;height:460px;"></div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="employee-block">
		<div class="employee-header">
			<img src="<c:url value='/images/header/shenyulin.png'/>"/>
			<p>沈玉琳</p>
			<p>设计师</p>
			<button class="btn btn-info btn-xs" data-toggle="modal" data-target="#addEmployee">编辑</button>
			<button class="btn btn-danger btn-xs">删除</button>
		</div>
			
		<div class="employee-process">
			<section id="sample-pb">
				<article class="num-progress">
					<h4 id="t-syl" class="num-progress-title"></h4>
					<div id="b-syl" class="number-pb">
						<div class="number-pb-shown"></div>
						<div class="number-pb-num">0</div>
					</div>
				</article>
			</section>
		</div>
		
		<div class="employee-clock">
			本月考勤：
			<button id="btn-hover" type="button" class="btn btn-default" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus"
				data-content="2015-4-1: 8:23<br/>2015-4-2: 8:20<br/>2015-4-3: 8:19<br/>2015-4-4: 8:19<br/>2015-4-5: 8:19">
				正常5天
			</button>
			<button type="button" class="btn btn-danger" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus"
				data-content="">
				迟到0天
			</button>
			<button type="button" class="btn btn-info" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus"
				data-content="2015-4-6: <span class='info'>拉肚子</span>">
				请假1天
			</button>
			<button type="button" class="btn btn-success" data-toggle="modal" data-target="#cardStatistics">
				考勤统计
			</button>
		</div>
		
		<div class="employee-performance">
			本月绩效：<span>230.0元</span>
			<button type="button" class="btn btn-success" data-toggle="modal" data-target="#performanceStatistics">
				绩效统计
			</button>
		</div>
		
		<div class="clear"></div>
	</div>
	
	<div class="employee-block">
		<div class="employee-header">
			<img src="<c:url value='/images/header/old_man.png'/>"/>
			<p>老人家</p>
			<p>设计师</p>
			<button class="btn btn-info btn-xs" data-toggle="modal" data-target="#addEmployee">编辑</button>
			<button class="btn btn-danger btn-xs">删除</button>
		</div>
			
		<div class="employee-process">
			<section id="sample-pb">
				<article class="num-progress">
					<h4 id="t-lr" class="num-progress-title"></h4>
					<div id="b-lr" class="number-pb">
						<div class="number-pb-shown"></div>
						<div class="number-pb-num">0</div>
					</div>
				</article>
			</section>
		</div>
		
		<div class="employee-clock">
			本月考勤：
			<button type="button" class="btn btn-default" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus"
				data-content="2015-4-1: 8:23<br/>2015-4-2: 8:20<br/>2015-4-3: 8:19">
				正常3天
			</button>
			<button type="button" class="btn btn-danger" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus"
				data-content="2015-4-4: <span class='danger'>8:46</span><br/>2015-4-5: <span class='danger'>8:31</span>">
				迟到2天
			</button>
			<button type="button" class="btn btn-info" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus"
				data-content="">
				请假0天
			</button>
			<button type="button" class="btn btn-success">
				考勤统计
			</button>
		</div>
		
		<div class="employee-performance">
			本月绩效：<span>99.0元</span>
			<button type="button" class="btn btn-success">
				绩效统计
			</button>
		</div>
		
		<div class="clear"></div>
	</div>
	
	<div class="employee-block">
		<div class="employee-header">
			<img src="<c:url value='/images/header/zhanglidong.png'/>"/>
			<p>张立东</p>
			<p>摄影师</p>
			<button class="btn btn-info btn-xs" data-toggle="modal" data-target="#addEmployee">编辑</button>
			<button class="btn btn-danger btn-xs">删除</button>
		</div>
			
		<div class="employee-process">
			<section id="sample-pb">
				<article class="num-progress">
					<h4 id="t-zld" class="num-progress-title"></h4>
					<div id="b-zld" class="number-pb">
						<div class="number-pb-shown"></div>
						<div class="number-pb-num">0</div>
					</div>
				</article>
			</section>
		</div>
		
		<div class="employee-clock">
			本月考勤：
			<button type="button" class="btn btn-default" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus"
				data-content="2015-4-1: 8:23<br/>2015-4-2: 8:20<br/>2015-4-3: 8:19">
				正常3天
			</button>
			<button type="button" class="btn btn-danger" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus"
				data-content="2015-4-4: <span class='danger'>8:46</span><br/>2015-4-5: <span class='danger'>8:31</span>">
				迟到2天
			</button>
			<button type="button" class="btn btn-info" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus"
				data-content="">
				请假0天
			</button>
			<button type="button" class="btn btn-success">
				考勤统计
			</button>
		</div>
		
		<div class="employee-performance">
			本月绩效：<span>19.0元</span>
			<button type="button" class="btn btn-success">
				绩效统计
			</button>
		</div>
		
		<div class="clear"></div>
	</div>
</div>
</div>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/notification/notificationFx.js'/>"></script>
<script src="<c:url value='/js/notification/corner-expand.js'/>"></script>
<script src="<c:url value='/js/notification/thumbslider.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script src="<c:url value='/js/progress/processer.js'/>"></script>
<script src="<c:url value='/js/chart/echarts.js'/>"></script>
<script>
	$(function () {
		$('[data-toggle="popover"]').popover({html:true})
	});
	
	$("#btn-hover").mouseover();
	
	var plr = new Processer("t-lr", "b-lr", "本月进度（共100单）");
	plr.run(60, 100);
	
	var psyl = new Processer("t-syl", "b-syl", "本月进度（共100单）");
	psyl.run(88, 100);
	
	var pzld = new Processer("t-zld", "b-zld", "本月进度（共100单）");
	pzld.run(12, 100);
	
	require.config({
		paths: {
			echarts: "<c:url value='/js/chart'/>"
		}
	});
	
	function changeCardChart() {
		createCardChart("2015年3月考勤统计", "沈玉琳", [28, 1, 2]);
	}
	
	createCardChart("2015年四月考勤统计", "沈玉琳", [5, 2, 0]);
	
	function createCardChart(title, employee, data) {
		require(
			[
				'echarts',
				'echarts/theme/macarons',
				'echarts/chart/line',
				'echarts/chart/bar'
			],
			function (ec, theme) {
				var cardChart = ec.init(document.getElementById('cardChartBody'), theme); 
				
				var option = {
					title: {
						x: 'center',
						text: title,
						subtext: employee
					},
					tooltip: {
						trigger: 'item',
						formatter: cardChartTooltipFormatter
					},
					toolbox: {
						show: true,
						feature: {
							restore: {show: true},
							saveAsImage: {show: true}
						}
					},
					calculable: true,
					grid: {
						borderWidth: 0,
						y: 80,
						y2: 60
					},
					xAxis: [
						{
							type: 'category',
							show: false,
							data: ['正常', '迟到', '请假']
						}
					],
					yAxis: [
						{
							type: 'value',
							show: false
						}
					],
					series: [
						{
							name: '考勤统计',
							type: 'bar',
							itemStyle: {
								normal: {
									color: function(params) {
										var colorList = ['#5CB85C', '#D9534F', '#5BC0DE'];
										return colorList[params.dataIndex]
									},
									label: {
										show: true,
										position: 'top',
										formatter: '{b}\n{c}次'
									}
								}
							},
							data: data
						}
					]
				};

				cardChart.setOption(option); 
			}
		);
	}
	
	createPerformanceChart();
	
	function createPerformanceChart() {
		require(
			[
				'echarts',
				'echarts/theme/macarons',
				'echarts/chart/line',
				'echarts/chart/bar'
			],
			function (ec, theme) {
				var chart = ec.init(document.getElementById('performanceCardBody'), theme);
				
				var option = {
					title : {
						text: '2014年绩效统计',
						subtext: '沈玉琳'
					},
					tooltip : {
						trigger: 'axis'
					},
					toolbox: {
						show : true,
						feature : {
							restore : {show: true},
							saveAsImage : {show: true}
						}
					},
					calculable : true,
					xAxis : [
						{
							type : 'category',
							boundaryGap : false,
							data : ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月']
						}
					],
					yAxis : [
						{
							type : 'value',
							min: 0,
							max: 1000,
							axisLabel : {
								formatter: '{value}单'
							}
						}
					],
					series : [
						{
							name:'业绩统计',
							type:'line',
							data:[560, 510, 420, 380, 590, 570, 320, 610, 720, 730, 510, 410],
							markPoint : {
								data : [
									{type : 'max', name: '最高'},
									{type : 'min', name: '最低'}
								]
							},
							markLine : {
								data : [
									{type : 'average', name: '平均'}
								]
							}
						}
					]
				};
				
				chart.setOption(option); 
			}
		);
	}
	
	function cardChartTooltipFormatter(params, ticket, callback) {
		switch (params.name) {
			case "正常":
				return "4月1日: 8点23分<br/>4月2日: 8点12分<br/>4月3日: 8点22分<br/>4月4日: 8点12分<br/>4月5日: 8点29分";
			case "迟到":
				return "4月6日: 8点37分<br/>4月7日: 8点40分";
			case "请假":
				return "4月6日: 病假<br/>4月7日: 家里有事";
			default:
				return "";
		}
	}
</script>
</body>
</html>