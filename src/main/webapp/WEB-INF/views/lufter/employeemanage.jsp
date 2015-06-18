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
<title>Orange 9</title>
<link href="<c:url value='/css/bootstrap.lufter.css'/>" rel="stylesheet"/>
<link href="<c:url value='/css/lufter/lufter.css'/>" rel="stylesheet"/>
<link href="<c:url value='/css/jquery-ui/jquery-ui.css'/>" rel="stylesheet"/>
<link href="<c:url value='/css/crop/style.css'/>" rel="stylesheet"/>
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/jquery-ui.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/js/validation/jquery.validate.js'/>"></script>
<script src="<c:url value='/js/validation/validation-message-cn.js'/>"></script>
<script src="<c:url value='/js/validation/validator.js'/>"></script>
<script src="<c:url value='/js/crop/cropbox.js'/>"></script>
<script src="<c:url value='/js/crop/init.js'/>"></script>
<script src="<c:url value='/js/chart/echarts.js'/>"></script>
<script src="<c:url value='/js/util/base64.js'/>"></script>
<script src="<c:url value='/js/util/ajax-util.js'/>"></script>
<body>
<jsp:include page="header.jsp" flush="true">
	<jsp:param name="page" value="employee"/>
</jsp:include>

<div id="uploadHeader" class="modal fade text-left" style="z-index:9999;" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog" style="width:648px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">上传头像</h4>
			</div>
			<div class="modal-body clearfix">
				<div class="imageBox">
					<div class="thumbBox"></div>
					<div class="spinner" style="display: none">Loading...</div>
				</div>
				<div class="action"> 
					<div class="new-contentarea tc">
						<a href="javascript:void(0)" class="upload-img">
							<label for="upload-file">上传图像</label>
						</a>
						<input type="file" class="" name="upload-file" id="upload-file" />
					</div>
					<input type="button" id="btnCrop" class="Btnsty_peyton" value="裁切">
					<input type="button" id="btnZoomIn" class="Btnsty_peyton" value="+"  >
					<input type="button" id="btnZoomOut" class="Btnsty_peyton" value="-" >
				</div>
				<div class="cropped"></div>
			</div>
			<div class="modal-footer">
				<button id="btnUploadHeader" type="button" class="btn btn-primary" onclick="setHeaderSelected()">确定</button>
			</div>
		</div>
	</div>
</div>

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
						<label class="col-sm-2 control-label">上传头像</label>
						<div class="col-sm-8 clearfix">
							<input type="hidden" name="header" id="header"/>
							<img id="selected-header" style="width:128px;" src="<c:url value='/images/header/gray_blank.jpg'/>"/>
							<button class="btn btn-primary" type="button" onclick="showUploadHeaderModal()">上传</button>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="i-name">称呼</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" maxlength="50" name="name" id="name"/>
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
					<div class="checkbox">
						<label class="col-sm-2 control-label"></label>
						<label style="padding-left:25px;">
							<input type="checkbox" id="cb-admin" name="cb-admin" onclick="setAdminSelected()"/>管理员权限
							<input type="hidden" id="isAdmin" name="isAdmin"/>
						</label>
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
				<div class="clearfix">
					<select id="card-year" class="form-control fleft" style="width:140px;" onchange="changeCardChart()">
					</select>
					<select id="card-month" class="form-control fleft" style="width:140px;" onchange="changeCardChart()">
					</select>
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
				<div class="clearfix">
					<select id="performance-year" class="form-control" style="width:140px;" onchange="changePerformanceYear()"></select>
				</div>
				<div id="performanceCardBody" style="width:860px;height:460px;"></div>
			</div>
		</div>
	</div>
</div>
	
<div class="container">
<div class="row">
	<div class="col-sm-8 blog-main">
		<input type="hidden" id="user-id"/>
		<c:forEach items="${userDetailList}" var="userDetail">
			<div class="data-block">
				<div class="data-title lofter-bc">
					<img src="${userDetail.header}"/> ${userDetail.name} [${userDetail.role.nameCN}]
				</div>
				<div class="clearfix">
					<div class="data-info progress-bc">本月绩效 <span class="golden-color">[${userDetail.performance}元]</span></div>
					<div class="data-info progress-bc performance-bar" style="width:${userDetail.monthDonePostProduction}px;">
						${userDetail.monthDonePostProduction}
						<c:choose>
							<c:when test="${userDetail.role.name.equals('DESIGNER')}">张</c:when>
							<c:otherwise>单</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="clearfix">
					<div class="data-info blank-bc">
						本月考勤
						<button class="btn btn-default ml10" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus">正常${userDetail.normalClockInList.size()}天</button>
						<button id="btn-user-delay-${userDetail.id}" class="btn btn-danger ml10 user-delay" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus" data-content="">迟到${userDetail.delayClockInList.size()}天</button>
						<button class="btn btn-info ml10" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus">请假${userDetail.leaveClockInList.size()}天</button>
						<button class="btn btn-success ml10" onclick="showCardChart(${userDetail.id}, '${userDetail.name}', '${userDetail.normalCount}', '${userDetail.delayCount}', '${userDetail.leaveCount}')">考勤统计</button>
						<button class="btn btn-success ml10" onclick="showPerformanceChart(${userDetail.id})">绩效统计</button>
					</div>
				</div>
				<div class="clearfix">
					<button class="btn btn-danger ml10 fright" onclick="deleteUser(${userDetail.id})">删除</button>
					<button class="btn btn-info fright" onclick="showUpdateWindow(${userDetail.id})">编辑</button>
				</div>
			</div>
		</c:forEach>
		<button class="btn btn-primary fright" onclick="showAddWindow()">添加员工</button>
	</div>

	<jsp:include page="panel.jsp" flush="true"/>
</div>
</div>
<script>
	function setAdminSelected() {
		var isSelected = $("#cb-admin")[0].checked;
		var isAdmin = isSelected ? 1 : 0;
		$("#isAdmin").val(isAdmin);
	}

	function setHeaderSelected() {
		$("#uploadHeader").modal("hide");
		var crop = $("#crop-header");
		if (crop && crop.length > 0) {
			var cropsrc = crop.attr("src");
			$("#selected-header").attr("src", cropsrc);
			var base64Data = cropsrc.split(",")[1];
			$("#header").val(base64Data);
		}
	}

	function showUploadHeaderModal() {
		$("#uploadHeader").modal("show");
	}

	getRoleList();
	getUserList();
	
	var userMap = {};
	
	function getUserList() {
		$.get("<c:url value='/user/getUserDetailList'/>", function(list, status) {
			if (list) {
				userMap = {};
				for (var i in list) {
					var data = list[i];
					userMap[data.id] = data;
				}
				initPopover();
				getDelayClockContent();
			}
		});
	}
	
	function initPopover() {
		$(function () {
			$('[data-toggle="popover"]').popover({html:true})
		});
	}
	
	var addEmployeeRules = {
		name: { required: true },
		phone: { required: true, digits: true },
		salary: { digits: true }
	};
	
	var validator = new Validator("addEmployeeForm", "btnAddEmployee", addEmployeeRules, "<c:url value='/user/addUser'/>", submitCallback);
	
	function showAddWindow() {
		validator.url = "<c:url value='/user/addUser'/>";
		$("#addEmployee").modal("show");
	}
	
	function showUpdateWindow(id) {
		validator.url = "<c:url value='/user/updateUser'/>";
		var user = userMap[id];
		for (var key in user) {
			var formNode = $("#" + key);
			if (formNode) {
				formNode.val(user[key]);
			}
		}
		if (parseInt(user["isAdmin"]) == 1) {
			$("#cb-admin").attr("checked", true);
		} else {
			$("#cb-admin").attr("checked", false);
		}
		if (user.header) {
			$("#header").val(user.header.split(",")[1]);
			$("#selected-header").attr("src", user.header);
		}
		$("#addEmployee").modal("show");
	}
	
	function getDelayClockContent() {
		$(".user-delay").each(function(index, data) {
			var userId = parseInt(this.id.replace("btn-user-delay-", ""));
			var result = "";
			var userData = userMap[userId];
			if (userData) {
				var clockList = userData.delayClockInList;
				for (var index in clockList) {
					var clock = clockList[index];
					result += (clock.clockDatetimeLabel + "<br/>");
				}
			}
			$("#" + this.id).attr("data-content", result);
		});
	}
	
	function deleteUser(userId) {
		var result = confirm("确定要删除他吗？");
		if (result) {
			$.post("<c:url value='/user/deleteUser/" + userId + "'/>", function(data, status) {
				if (data.status == "success") {
					location.reload(true);
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
			location.reload(true);
		} else {
			alert(response.msg);
		}
	}
	
	$('#addEmployee').on('hidden.bs.modal', function (e) {
		document.getElementById("addEmployeeForm").reset();
	});
	
	// --------- Card Related --------- //
	
	var now = new Date();
	
	createCardYearMonthSelect();
	
	function createCardYearMonthSelect() {
		var nowYear = now.getFullYear();
		var nowMonth = now.getMonth();
		var yearHtml = "";
		for (var i = nowYear; i > 2010; i--) {
			yearHtml += "<option value='" + i + "'>" + i + "年</option>";
		}
		$("#card-year").html(yearHtml);
		$("#performance-year").html(yearHtml);
		var monthHtml = "";
		for (var j = 12; j > 0; j--) {
			if (j == (nowMonth + 1)) {
				monthHtml += "<option value='" + j + "' selected>" + j + "月</option>";
			} else {
				monthHtml += "<option value='" + j + "'>" + j + "月</option>";
			}
		}
		$("#card-month").html(monthHtml);
	}
	
	require.config({
		paths: {
			echarts: "<c:url value='/js/chart'/>"
		}
	});
	
	function changeCardChart() {
		var userId = $("#user-id").val();
		var year = $("#card-year").val();
		var month = $("#card-month").val();
		var selectedDate = new Date(year, month - 1, 1, 0, 0, 0);
		AjaxUtil.post("<c:url value='/user/getUserClockIn'/>", {userId: userId, clockDatetime: selectedDate}, function(data) {
			createCardChart(year, month, data.name, [data.normalCount, data.delayCount, data.leaveCount]);
		});
	}
	
	function showCardChart(userid, username, normalCount, delayCount, leaveCount) {
		$("#user-id").val(userid);
		createCardChart(now.getFullYear(), now.getMonth() + 1, username, [normalCount, delayCount, leaveCount]);
		$("#cardStatistics").modal("show");
	}
	
	$("#cardStatistics").on("hidden.bs.modal", function(e) {
		$("#card-year").val(now.getFullYear());
		$("#card-month").val(now.getMonth() + 1);
	});
	
	function createCardChart(year, month, employee, data) {
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
						text: (year + "年" + month + "月考勤统计"),
						subtext: employee
					},
					tooltip: {
						trigger: 'item'
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
	
	$("#performanceStatistics").on("hidden.bs.modal", function(e) {
		$("#performance-year").val(now.getFullYear());
	});
	
	function changePerformanceYear() {
		var userId = $("#user-id").val();
		var year = $("#performance-year").val();
		getPerformanceChart(year, userId);
	}
	
	function showPerformanceChart(userId) {
		$("#user-id").val(userId);
		var year = $("#performance-year").val();
		getPerformanceChart(year, userId);
	}
	
	function getPerformanceChart(year, userId) {
		$.get("<c:url value='/user/getUserPerformanceChart/" + year + "/" + userId + "'/>", function(data) {
			if (data) {
				createPerformanceChart(year, data.userName, data.performanceList, data.fixSkinList, data.fixBackgroundList, data.cutLiquifyList);
				$("#performanceStatistics").modal("show");
			}
		});
	}
	
	function createPerformanceChart(year, username, datalist, fixskinlist, fixbclist, cutlist) {
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
						text: (year + '年绩效统计'),
						subtext: username
					},
					legend: {
				        data:['总量','修皮肤及褶皱','修背景','裁图液化']
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
							name:'总量',
							type:'line',
							data:datalist,
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
						},
						{
							name:'修皮肤及褶皱',
							type:'line',
							data:fixskinlist,
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
						},
						{
							name:'修背景',
							type:'line',
							data:fixbclist,
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
						},
						{
							name:'裁图液化',
							type:'line',
							data:cutlist,
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
</script>
</body>
</html>