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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/jquery-ui/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/sidebar/component.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/progress/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/progress/number-pb.css'/>" />
<script src="<c:url value='/js/jquery-1.11.2.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/js/jquery-ui.js'/>"></script>
<script src="<c:url value='/js/progress/jquery.velocity.min.js'/>"></script>
<script src="<c:url value='/js/progress/number-pb.js'/>"></script>
<script src="<c:url value='/js/validation/jquery.validate.js'/>"></script>
<script src="<c:url value='/js/validation/validation-message-cn.js'/>"></script>
<script src="<c:url value='/js/validation/validator.js'/>"></script>
</head>
<body>
<div id="st-container" class="st-container">
<div class="st-pusher">
	<jsp:include page="system2sidebar.jsp" flush="true"/>
	
	<div id="st-trigger-effects">
		<button class="btn btn-warning nav-btn" data-effect="st-effect-3">
			<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		</button>
	</div>
	
	<div style="text-align:center;">
		<p class="login-header"><span>ORANGE</span> 9 SYSTEM</p>
	</div>
	
	<button class="btn btn-warning btn-add-employee" onclick="showAddWindow()">添加员工</button>
	
	<!-- Add Employee Modal -->
	<div id="addEmployee" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header orange-model-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">员工资料</h4>
				</div>
				<div class="modal-body">
					<sf:form id="addEmployeeForm" modelAttribute="employee" class="form-horizontal" method="post">
						<input type="hidden" name="id" id="id"/>
						<div id="fg-header" class="form-group">
							<label class="col-sm-2 control-label" for="i-upload-header">上传头像</label>
							<div class="col-sm-4">
								<input type="hidden" name="header" id="header"/>
								<input class="btn btn-primary" type="file" id="i-upload-header"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="i-name">称呼</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" maxlength="5" name="name" id="name"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">职位</label>
							<div class="col-sm-4">
								<select id="roleId" name="roleId" class="form-control">
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">手机号</label>
							<div class="col-sm-4">
								<input type="tel" maxlength="11" id="phone" name="phone" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">基本工资</label>
							<div class="col-sm-4">
								<input type="number" id="salary" name="salary" value="1500" min="1000" max="10000" step="100" class="form-control"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">绩效工资</label>
							<div class="col-sm-4">
								<input type="number" id="performancePay" name="performancePay" value="0" min="0" max="10000" step="10" class="form-control"/>
							</div>
						</div>
						<input type="hidden" name="password" value="666666"/>
					</sf:form>
				</div>
				<div class="modal-footer">
					<button id="btnAddEmployee" type="button" class="btn btn-primary" onclick="submit()">确定</button>
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
	
	<div id="employeeContainer"></div>
</div>
</div>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script src="<c:url value='/js/progress/processer.js'/>"></script>
<script src="<c:url value='/js/chart/echarts.js'/>"></script>
<script src="<c:url value='/js/util/base64.js'/>"></script>
<script>
	var headerBase64 = new Base64("i-upload-header", "header");
	
	getRoleList();
	
	getUserList();
	
	var updateHiddenList = ["header"];
	var userMap = {};
	
	function getUserList() {
		$.get("<c:url value='/user/getUserDetailList'/>", function(list, status) {
			if (list) {
				userMap = {};
				$("#employeeContainer").html("");
				var employeeHtml = "";
				for (var i in list) {
					var data = list[i];
					userMap[data.id] = data;
					employeeHtml += (
						'<div class="employee-block">'
						+ getEmployeeHeader(data)
						+ getEmployeeProcess(data)
						+ getEmployeeClock(data)
						+ getEmployeePerformance(data)
						+ '<div class="clear"></div></div>');
				}
				$("#employeeContainer").html(employeeHtml);
				for (var i in list) {
					var data = list[i];
					var plr = new Processer("t-" + data.id, "b-" + data.id, "本月进度（共0单）");
					plr.run(0, 0);
				}
				initPopover();
			}
		});
	}
	
	function initPopover() {
		$(function () {
			$('[data-toggle="popover"]').popover({html:true})
		});
	}
	
	function changeFormView(isShow) {
		for (var i in updateHiddenList) {
			var hiddenId = "fg-" + updateHiddenList[i];
			var hiddenNode = $("#" + hiddenId);
			if (hiddenNode) {
				if (isShow) {
					hiddenNode.show();
				} else {
					hiddenNode.hide();
				}
			}
		}
	}
	
	var addEmployeeRules = {
		name: { required: true },
		phone: { required: true, digits: true },
		salary: { digits: true },
		performancePay: { digits: true }
	};
	
	var validator = new Validator("addEmployeeForm", "btnAddEmployee", addEmployeeRules, "<c:url value='/user/addUser'/>", submitCallback);
	
	function showAddWindow() {
		validator.url = "<c:url value='/user/addUser'/>";
		changeFormView(true);
		$("#addEmployee").modal("show");
	}
	
	function showUpdateWindow(id) {
		validator.url = "<c:url value='/user/updateUser'/>";
		var user = userMap[id];
		changeFormView(false);
		for (var key in user) {
			var formNode = $("#" + key);
			if (formNode) {
				formNode.val(user[key]);
			}
		}
		$("#addEmployee").modal("show");
	}
	
	function getEmployeeHeader(data) {
		return '<div class="employee-header">' 
				+ '<img src="' + data.header + '"/><p>' + data.name + '</p><p>' + data.role.nameCN + '</p>' 
				+ '<button class="btn btn-info btn-xs" onclick="showUpdateWindow(' + data.id + ')">编辑</button>' 
				+ '<button class="btn btn-danger btn-xs" onclick="deleteUser(' + data.id + ')">删除</button>' 
				+ '</div>';
	}
	
	function getEmployeeProcess(data) {
		return '<div class="employee-process"><section><article class="num-progress">'
			+ '<h4 id="t-' + data.id + '" class="num-progress-title"></h4>'
			+ '<div id="b-' + data.id + '" class="number-pb"><div class="number-pb-shown"></div><div class="number-pb-num">0</div>'
			+ '</div></article></section></div>';
	}
	
	function getEmployeeClock(data) {
		return '<div class="employee-clock">本月考勤：'
		+ '<button type="button" class="btn btn-default" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus">正常' + data.normalClockInList.length + '天</button>'
		+ '<button type="button" class="btn btn-danger" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus" data-content="' + getDelayClockContent(data.delayClockInList) + '">迟到' + data.delayClockInList.length + '天</button>'
		+ '<button type="button" class="btn btn-info" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus" data-content="">请假' + data.leaveClockInList.length + '天</button>'
		+ '<button type="button" class="btn btn-success" data-toggle="modal" data-target="#cardStatistics">考勤统计</button></div>';
	}
	
	function getDelayClockContent(clockList) {
		var result = "";
		for (var index in clockList) {
			var clock = clockList[index];
			result += (clock.clockDatetimeLabel + "<br/>");
		}
		return result;
	}
	
	function getEmployeePerformance(data) {
		return '<div class="employee-performance">本月绩效：<span>19.0元</span><button type="button" class="btn btn-success" data-toggle="modal" data-target="#performanceStatistics">绩效统计</button></div>';
	}
	
	function deleteUser(userId) {
		var result = confirm("确定要删除他吗？");
		if (result) {
			$.post("<c:url value='/user/deleteUser/" + userId + "'/>", function(data, status) {
				if (data.status == "success") {
					getUserList();
				}
			});
		}
	}
	
	function getRoleList() {
		$.get("<c:url value='/role/getRoleList'/>", function(list, status) {
			var roleSelect = $("#roleId");
			var html = "";
			for (var i in list) {
				var data = list[i];
				html += ("<option value=" + data.id + ">" + data.nameCN + "</option>");
			}
			roleSelect.html(html);
		});
	}
	
	function submit() {
		$("#addEmployeeForm").submit();
	}
	
	function submitCallback(response) {
		if (response.status == "success") {
			$("#addEmployee").modal("hide");
			getUserList();
		} else {
			alert(response.msg);
		}
	}
	
	$('#addEmployee').on('hidden.bs.modal', function (e) {
		document.getElementById("addEmployeeForm").reset();
	});
		
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