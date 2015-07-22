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
<link rel="icon" href="<c:url value="/images/favicon.ico"/>" type="image/x-icon" /> 
<link rel="shortcut icon" href="<c:url value="/images/favicon.ico"/>" type="image/x-icon" />
<link href="<c:url value='/css/bootstrap.lufter.css'/>" rel="stylesheet"/>
<link href="<c:url value='/css/lufter/lufter.css'/>" rel="stylesheet"/>
<link href="<c:url value='/css/jquery-ui/jquery-ui.css'/>" rel="stylesheet"/>
<link href="<c:url value='/css/zoom.css'/>" rel="stylesheet"/>
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/js/validation/jquery.validate.js'/>"></script>
<script src="<c:url value='/js/validation/validation-message-cn.js'/>"></script>
<script src="<c:url value='/js/validation/validator.js'/>"></script>
<body>
<jsp:include page="header.jsp" flush="true">
	<jsp:param name="page" value=""/>
</jsp:include>

<div id="statusRollbackModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">订单状态回滚原因</h4>
			</div>
			<div class="modal-body">
				<textarea id="rollback-reason" class="form-control" rows="4" maxlength="100"></textarea>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" onclick="setRollback()">确定</button>
			</div>
		</div>
	</div>
</div>
	
<div id="orderGoodsModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header orange-model-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">货品信息</h4>
			</div>
			<div class="modal-body">
				<sf:form id="orderGoodsForm" modelAttribute="orderGoods" class="form-horizontal" method="post">
					<input type="hidden" id="goodsOrderId" name="orderId"/>
					<div class="form-group">
						<label class="col-sm-2 control-label">上装</label>
						<div class="col-sm-2">
							<input type="number" id="coatCount" name="coatCount" value="0" min="0" max="9999" step="1" class="form-control"/>
						</div>
						<label class="col-sm-2 control-label">下装</label>
						<div class="col-sm-2">
							<input type="number" id="pantsCount" name="pantsCount" value="0" min="0" max="9999" step="1" class="form-control"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">连体衣</label>
						<div class="col-sm-2">
							<input type="number" id="jumpsuitsCount" name="jumpsuitsCount" value="0" min="0" max="9999" step="1" class="form-control"/>
						</div>
						<label class="col-sm-2 control-label">鞋子</label>
						<div class="col-sm-2">
							<input type="number" id="shoesCount" name="shoesCount" value="0" min="0" max="9999" step="1" class="form-control"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">包包</label>
						<div class="col-sm-2">
							<input type="number" id="bagCount" name="bagCount" value="0" min="0" max="9999" step="1" class="form-control"/>
						</div>
						<label class="col-sm-2 control-label">帽子</label>
						<div class="col-sm-2">
							<input type="number" id="hatCount" name="hatCount" value="0" min="0" max="9999" step="1" class="form-control"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">其他</label>
						<div class="col-sm-2">
							<input type="number" id="otherCount" name="otherCount" value="0" min="0" max="9999" step="1" class="form-control"/>
						</div>
					</div>
				</sf:form>
			</div>
			<div class="modal-footer">
				<button id="btnConfirmGoods" type="button" class="btn btn-primary" onclick="submitGoods()">确定</button>
			</div>
		</div>
	</div>
</div>

<div id="editOrder" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header orange-model-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">订单编辑</h4>
			</div>
			<div class="modal-body">
				<sf:form id="editOrderForm" class="form-horizontal" modelAttribute="order">
					<div class="form-group">
						<label class="col-sm-2 control-label">拍摄日期</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" name="shootDate" id="shootDate"/>
						</div>
						<div class="col-sm-3">
							<select id="shootHalf" name="shootHalf" class="form-control">
								<option value="AM">上午</option>
								<option value="PM">下午</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">客户</label>
						<div class="col-sm-4">
							<select id="clientId" name="clientId" class="form-control"></select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">模特</label>
						<div class="col-sm-4">
							<div class="input-group">
								<input type="text" maxlength="10" id="modelName" name="modelName" class="form-control"/>
								<div class="input-group-btn">
									<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span class="caret"></span></button>
									<ul class="dropdown-menu" role="menu">
										<c:forEach items="${modelNameList}" var="modelName">
											<li><a onclick="setControl('modelName', '${modelName.name}')">${modelName.name}</a></li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">搭配师</label>
						<div class="col-sm-4">
							<div class="input-group">
								<input type="text" maxlength="10" id="stylistName" name="stylistName" class="form-control"/>
								<div class="input-group-btn">
									<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span class="caret"></span></button>
									<ul class="dropdown-menu" role="menu">
										<c:forEach items="${stylistNameList}" var="stylistName">
											<li><a onclick="setControl('stylistName', '${stylistName.name}')">${stylistName.name}</a></li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">化妆师</label>
						<div class="col-sm-4">
							<div class="input-group">
								<input type="text" maxlength="10" id="dresserName" name="dresserName" class="form-control"/>
								<div class="input-group-btn">
									<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span class="caret"></span></button>
									<ul class="dropdown-menu" role="menu">
										<c:forEach items="${dresserNameList}" var="dresserName">
											<li><a onclick="setControl('dresserName', '${dresserName.name}')">${dresserName.name}</a></li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">经纪人</label>
						<div class="col-sm-4">
							<div class="input-group">
								<input type="text" maxlength="10" id="brokerName" name="brokerName" class="form-control"/>
								<div class="input-group-btn">
									<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span class="caret"></span></button>
									<ul class="dropdown-menu" role="menu">
										<c:forEach items="${brokerList}" var="broker">
											<li><a onclick="setBroker('brokerName', '${broker.name}', 'brokerPhone', '${broker.phone}')">${broker.name}</a></li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">联系方式</label>
						<div class="col-sm-4">
							<div class="input-group">
								<input type="text" maxlength="11" id="brokerPhone" name="brokerPhone" class="form-control"/>
								<div class="input-group-btn">
									<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span class="caret"></span></button>
									<ul class="dropdown-menu" role="menu">
										<c:forEach items="${brokerList}" var="broker">
											<li><a onclick="setControl('brokerPhone', '${broker.phone}')">${broker.phone}</a></li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">摄影师</label>
						<div class="col-sm-4">
							<select id="photographerId" name="photographerId" class="form-control"></select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">助理</label>
						<div class="col-sm-4">
							<select id="assistantId" name="assistantId" class="form-control"></select>
						</div>
					</div>
				</sf:form>
			</div>
			<div class="modal-footer">
				<button id="btnEditOrder" type="button" class="btn btn-primary" onclick="editOrder()">确定</button>
			</div>
		</div>
	</div>
</div>

<div class="container">
<div class="row">
	<div class="col-sm-8 blog-main">
		<div class="data-block">
			<div class="clearfix">
				<input type="hidden" id="orderId" value="${orderDetail.id}"/>
				<input type="hidden" id="clientHiddenId" value="${orderDetail.clientId}"/>
				<input type="hidden" id="statusId" value="${orderDetail.statusId}"/>
				<div class="data-info lofter-bc">
					单号 ${orderDetail.orderNo}
				</div>
				<div class="data-info lofter-bc" style="width:210px;">
					拍摄日期 ${orderDetail.shootDateLabel} ${orderDetail.shootHalf}
				</div>
				<c:choose>
					<c:when test="${user.isAdmin == 1}">
						<div class="data-info lofter-bc" style="padding:4px;">
							<select id="orderStatus" class="form-control" style="width:140px;display:inline;" onchange="updateOrderStatus()">
								<c:forEach items="${orderStatusList}" var="orderStatus">
									<c:choose>
										<c:when test="${orderStatus.id == orderDetail.statusId}">
											<option value="${orderStatus.id}" selected>${orderStatus.name}</option>
										</c:when>
										<c:otherwise>
											<option value="${orderStatus.id}">${orderStatus.name}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</div>
					</c:when>
					<c:otherwise>
						<div class="data-info lofter-bc">
							状态 ${orderDetail.orderStatus.name}
						</div>
					</c:otherwise>
				</c:choose>
				<c:if test="${orderDetail.statusId == 1 && user.isAdmin == 1}">
					<button class="btn btn-success btn-data-info" onclick="showEditOrderWindow()">编辑</button>
				</c:if>
			</div>
			<div class="clearfix">
				<div class="data-info taobao-bc">客户</div>
				<div class="data-info taobao-bc">${orderDetail.client.clientName}</div>
				<c:if test="${orderDetail.client.clientShopName != null && !orderDetail.client.clientShopName.equals('')}">
					<div class="data-info taobao-bc">淘宝 <a href="http://${orderDetail.client.clientShopLink}" target="_blank">${orderDetail.client.clientShopName}</a></div>
				</c:if>
				<div class="data-info taobao-bc">${orderDetail.client.clientPhone}</div>
				<c:if test="${orderDetail.client.clientEmail != null && !orderDetail.client.clientEmail.equals('')}">
					<div class="data-info taobao-bc">${orderDetail.client.clientEmail}</div>
				</c:if>
			</div>
			<div class="clearfix">
				<div class="data-info twitter-bc">货品 </div>
				<c:choose>
					<c:when test="${orderDetail.orderGoods == null}">
						<input type="hidden" id="allOrderGoodsCount" value="0"/>
						<c:if test="${user.isAdmin == 1}">
							<button class="btn btn-info btn-data-info twitter-bc" onclick="showAddOrderGoodsWindow(${orderDetail.id})">添加</button>
						</c:if>
					</c:when>
					<c:otherwise>
						<input type="hidden" id="allOrderGoodsCount" value="${orderDetail.orderGoods.allCount}"/>
						<c:if test="${orderDetail.orderGoods.coatCount > 0}">
							<div class="data-info twitter-bc">上装 ${orderDetail.orderGoods.coatCount}件</div>
						</c:if>
						<c:if test="${orderDetail.orderGoods.pantsCount > 0}">
							<div class="data-info twitter-bc">下装 ${orderDetail.orderGoods.pantsCount}件</div>
						</c:if>
						<c:if test="${orderDetail.orderGoods.jumpsuitsCount > 0}">
							<div class="data-info twitter-bc">连体衣 ${orderDetail.orderGoods.jumpsuitsCount}件</div>
						</c:if>
						<c:if test="${orderDetail.orderGoods.shoesCount > 0}">
							<div class="data-info twitter-bc">鞋子 ${orderDetail.orderGoods.shoesCount}件</div>
						</c:if>
						<c:if test="${orderDetail.orderGoods.hatCount > 0}">
							<div class="data-info twitter-bc">帽子 ${orderDetail.orderGoods.hatCount}件</div>
						</c:if>
						<c:if test="${orderDetail.orderGoods.bagCount > 0}">
							<div class="data-info twitter-bc">包包 ${orderDetail.orderGoods.bagCount}件</div>
						</c:if>
						<c:if test="${orderDetail.orderGoods.otherCount > 0}">
							<div class="data-info twitter-bc">其他 ${orderDetail.orderGoods.otherCount}件</div>
						</c:if>
						<c:if test="${user.isAdmin == 1 || user.role.name.equals('ASSISTANT')}">
							<button class="btn btn-info btn-data-info twitter-bc"
								onclick="showUpdateOrderGoodsWindow(
									${orderDetail.id}, 
									${orderDetail.orderGoods.coatCount}, 
									${orderDetail.orderGoods.pantsCount}, 
									${orderDetail.orderGoods.jumpsuitsCount}, 
									${orderDetail.orderGoods.shoesCount},
									${orderDetail.orderGoods.hatCount},
									${orderDetail.orderGoods.bagCount},
									${orderDetail.orderGoods.otherCount})">
								修改
							</button>
						</c:if>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="clearfix">
				<input type="hidden" id="photographerId" value="${orderDetail.photographer.id}"/>
				<div class="data-info facebook-bc">拍摄</div>
				<div class="data-info facebook-bc order-detail-header">摄影师 ${orderDetail.photographer.name} <img src="${orderDetail.photographer.header}"/></div>
				<c:if test="${orderDetail.assistant != null}">
					<div class="data-info facebook-bc order-detail-header">助理 ${orderDetail.assistant.name} <img src="${orderDetail.assistant.header}"/></div>
				</c:if>
				<div class="data-info facebook-bc">模特 ${orderDetail.modelName}</div>
				<div class="data-info facebook-bc">化妆师 ${orderDetail.dresserName}</div>
				<div class="data-info facebook-bc">搭配师 ${orderDetail.stylistName}</div>
				<div class="data-info facebook-bc">经纪人 ${orderDetail.brokerName}</div>
				<div class="data-info facebook-bc">电话 ${orderDetail.brokerPhone}</div>
			</div>
			<div class="clearfix">
				<div class="data-info progress-bc">后期</div>
				<div class="data-info progress-bc order-detail-header">
					修皮肤
					<c:choose>
						<c:when test="${orderFixSkin != null}">
							${orderFixSkin.operator.name} <img style="height:30px;" src="${orderFixSkin.operator.header}"/>
						</c:when>
						<c:otherwise>
							未开始
						</c:otherwise>
					</c:choose>
				</div>
				<div class="data-info progress-bc order-detail-header">
					修背景
					<c:choose>
						<c:when test="${orderFixBackground != null}">
							${orderFixBackground.operator.name} <img style="height:30px;" src="${orderFixBackground.operator.header}"/>
						</c:when>
						<c:otherwise>
							未开始
						</c:otherwise>
					</c:choose>
				</div>
				<div class="data-info progress-bc order-detail-header">
					裁图液化
					<c:choose>
						<c:when test="${orderCutLiquify != null}">
							${orderCutLiquify.operator.name} <img style="height:30px;" src="${orderCutLiquify.operator.header}"/>
						</c:when>
						<c:otherwise>
							未开始
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="clearfix">
				<div class="data-info blank-bc">
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
							<a id="blink4" onclick="changeBottomNavView(this)">历史状态</a>
						</li>
					</ul>
					<div id="blink1-block" class="detail-bottom-block clearfix">
						<c:forEach items="${orderTransferImageDataList}" var="imageData">
							<div class="pic-block photo-frame gallery">
								<a id="client-pic-${imageData.id}" href="<c:url value='/pictures/original/${imageData.orderId}/compress/${imageData.fileName}.jpg'/>">
									<img src="<c:url value='/pictures/original/${imageData.orderId}/compress/${imageData.fileName}.jpg'/>"/>
								</a>
								<c:choose>
									<c:when test="${imageData.isSelected == 1}">
										<p id="client-pic-label-${imageData.id}" class='taobao-color'>(${imageData.fileName})<span class='taobao-color'>已选</span></p>
									</c:when>
									<c:otherwise>
										<p id="client-pic-label-${imageData.id}">(${imageData.fileName})</p>
									</c:otherwise>
								</c:choose>
							</div>
						</c:forEach>
					</div>
					<div id="blink2-block" class="detail-bottom-block hidden clearfix">
						<c:forEach items="${orderFixedImageDataList}" var="imageData">
							<div class="pic-block photo-frame gallery">
								<a id="client-fixed-pic-${imageData.id}" href="<c:url value='/pictures/fixed/${imageData.orderId}/compress/${imageData.fileName}.jpg'/>">
									<img src="<c:url value='/pictures/fixed/${imageData.orderId}/compress/${imageData.fileName}.jpg'/>"/>
								</a>
								<c:choose>
									<c:when test="${imageData.isVerified == 1}">
										<p id="fixed-pic-label-${imageData.id}" class='progress-color'>(${imageData.fileName})<span>审核通过</span></p>
									</c:when>
									<c:when test="${imageData.isVerified == 0 && imageData.reason != null}">
										<p id="fixed-pic-label-${imageData.id}" class='netease-color'>(${imageData.fileName})</p>
										<p class='netease-color'>未通过：${imageData.reason}</p>
										<p>
											<button class="btn btn-danger btn-sm" onclick="completePostProduction(${imageData.id}, ${imageData.orderId}, '${imageData.fileName}')">重新上传</button>
										</p>
									</c:when>
									<c:otherwise>
										<p id="fixed-pic-label-${imageData.id}">(${imageData.fileName})</p>
									</c:otherwise>
								</c:choose>
							</div>
						</c:forEach>
					</div>
					<div id="blink3-block" class="detail-bottom-block hidden">
					</div>
					<div id="blink4-block" class="detail-bottom-block hidden">
						<c:forEach items="${orderHistoryList}" var="orderHistory">
							<div class="data-info golden-bc">${orderHistory.insertDatetimeLabel}</div>
							<div class="data-info golden-bc">${orderHistory.info}</div>
							<div class="data-info golden-bc">BY ${orderHistory.user.name}</div>
							<c:if test="${orderHistory.remark != null}">
								<div class="data-info golden-bc">备注 ${orderHistory.remark}</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>

	<input class="hidden" type="file" id="complete-post-production"/>

	<jsp:include page="panel.jsp" flush="true"/>
</div>
</div>
<script src="<c:url value='/js/zoom.js'/>"></script>
<script src="<c:url value='/js/util/transferUploader.js'/>"></script>
<script src="<c:url value='/js/util/ajax-util.js'/>"></script>
<script>
	$('#shootDate').datepicker();

	init();
	
	function init() {
		getClientList();
		getUserList();
	}
	
	var addOrderRules = {
		shootDate: { required: true },
		clientId: { required: true },
		modelName: { required: true },
		brokerName: { required: true },
		brokerPhone: { required: true, number: true },
		photographerId: { required: true }
	};
	
	var orderValidator = new Validator("editOrderForm", "btnEditOrder", addOrderRules, "<c:url value='/order/updateOrder/" + $("#orderId").val() + "'/>", editOrderCallback);
	
	function editOrder() {
		$("#editOrderForm").submit();
	}
	
	function editOrderCallback(response) {
		if (response.status == "success") {
			location.reload(true);
		} else {
			alert(response.msg);
		}
	}
	
	function showEditOrderWindow() {
		var orderId = $("#orderId").val();
		$.get("<c:url value='/order/getOrderDetail/" + orderId + "'/>", function(data) {
			if (data) {
				$("#shootDate").datepicker("setDate", new Date(data.shootDate));
				$("#shootHalf").val(data.shootHalf);
				$("#clientId").val(data.client.id);
				$("#modelName").val(data.modelName);
				$("#stylistName").val(data.stylistName);
				$("#dresserName").val(data.dresserName);
				$("#brokerName").val(data.brokerName);
				$("#brokerPhone").val(data.brokerPhone);
				$("#photographerId").val(data.photographerId);
				if (data.assistantId) {
					$("#assistantId").val(data.assistantId);
				}
				$("#editOrder").modal("show");
			}
		});
	}
	
	function getClientList() {
		$.get("<c:url value='/client/getClientList'/>", function(list, status) {
			var clientSelect = $("#clientId");
			var html = "";
			for (var i in list) {
				var data = list[i];
				html += ("<option value=" + data.id + ">" + data.clientName + "</option>");
			}
			clientSelect.html(html);
		});
	}
	
	function getUserList() {
		$.get("<c:url value='/user/getUserList'/>", function(list, status) {
			if (list) {
				$("#photographerId").html("");
				$("#assistantId").html("");
				var photographerHtml = "";
				var assistantHtml = "<option>请选择 </option>";
				for (var i in list) {
					var data = list[i];
					var option = "<option value='" + data.id + "'>" + data.name + "</option>";
					if (data.roleId == 2) {
						photographerHtml += option;
					} else if (data.roleId == 4) {
						assistantHtml += option;
					}
				}
				$("#photographerId").html(photographerHtml);
				$("#assistantId").html(assistantHtml);
			}
		});
	}
	
	var compId;
	var compOrderId;
	var compFileName;
	var reader = new FileReader();
	
	reader.onload = function(event) {
		var base64Data = event.target.result.split(",")[1];
		AjaxUtil.post("<c:url value='/orderPostProduction/reuploadFixedImage/" + compId + "'/>", {orderId:compOrderId, fileName:compFileName, base64Data:base64Data}, function(data) {
			if (data.status == "success") {
				location.reload(true);
			}
		});
	};
	
	$("#complete-post-production").bind("change", function(event) {
		var img = event.target.files[0];
		if (!img) {
			return;
		}
		var frontName = img.name.split(".")[0];
		if (frontName != compFileName) {
			alert("应选择图片" + compFileName + ".jpg");
			return;
		}
		reader.readAsDataURL(img);
	});
	
	function completePostProduction(id, orderId, fileName) {
		compId = id;
		compOrderId = orderId;
		compFileName = fileName;
		$("#complete-post-production").click();
	}

	function showSetConvertWindow() {
		$("#setConvertModal").modal("show");
	}

	function showSetVerifierWindow() {
		$("#setVerifyModal").modal("show");
	}
	
	function changeBottomNavView(nav) {
		var navheader = $("#" + nav.id);
		$(".detail-bottom-block").addClass("hidden");
		$(".detail-bottom-nav").removeClass("active");
		navheader.parent().addClass("active");
		$("#" + nav.id + "-block").removeClass("hidden");
	}
	
	function setRollback() {
		var reason = $("#rollback-reason").val();
		if (!reason) {
			alert("请填写原因");
			return;
		}
		var orderId = $("#orderId").val();
		var statusId = $("#orderStatus").val();
		AjaxUtil.post("<c:url value='/order/orderStatusRollback'/>", {orderId:orderId, statusId:statusId, reason:reason}, function(data, status) {
			if (data.status == "success") {
				location.reload(true);
			} else {
				console.log(data);
			}
		});
	}
	
	function updateOrderStatus() {
		var orderId = $("#orderId").val();
		var currentStatusId = parseInt($("#statusId").val());
		var statusId = parseInt($("#orderStatus").val());
		var userId = $("#photographerId").val();
		
		if (statusId < currentStatusId) {
			$("#statusRollbackModal").modal("show");
		} else {
			if (statusId == 2) {
				setOrderTransfer(orderId, userId);
			} else {
				setOrderStatus(orderId, statusId);
			}
		}
	}
	
	function setOrderStatus(orderId, statusId) {
		$.post("<c:url value='/order/updateOrderStatus/" + orderId + "/" + statusId + "'/>", null, function(data, status) {
			if (data.status == "success") {
				location.reload(true);
			} else {
				console.log(data);
			}
		});
	}
	
	function setOrderTransfer(orderId, userId) {
		$.post("<c:url value='/order/setOrderTransfer/" + orderId + "/" + userId + "'/>", null, function(data, status) {
			if (data.status == "success") {
				location.reload(true);
			} else {
				console.log(data);
			}
		});
	}
	
	var confirmGoodsRules = {
		coatCount: { digits: true },
		pantsCount: { digits: true },
		jumpsuitsCount: { digits: true },
		shoesCount: { digits: true },
		bagCount: { digits: true },
		hatCount: { digits: true },
		otherCount: { digits: true }
	};
	
	var goodsValidator = new Validator("orderGoodsForm", "btnConfirmGoods", confirmGoodsRules, "<c:url value='/orderGoods/updateShootGoods'/>", submitGoodsCallback);
	
	$("#orderGoodsModal").on("hidden.bs.modal", function(e) {
		document.getElementById("orderGoodsForm").reset();
	});
	
	function showUpdateOrderGoodsWindow(orderId, coatCount, pantsCount, jumpsuitsCount, shoesCount, hatCount, bagCount, otherCount) {
		goodsValidator.url = "<c:url value='/orderGoods/updateShootGoods'/>";
		$("#goodsOrderId").val(orderId);
		$("#coatCount").val(coatCount);
		$("#pantsCount").val(pantsCount);
		$("#jumpsuitsCount").val(jumpsuitsCount);
		$("#shoesCount").val(shoesCount);
		$("#hatCount").val(hatCount);
		$("#bagCount").val(bagCount);
		$("#otherCount").val(otherCount);
		$("#orderGoodsModal").modal("show");
	}
	
	function showAddOrderGoodsWindow(orderId) {
		goodsValidator.url = "<c:url value='/orderGoods/addShootGoods'/>";
		$("#goodsOrderId").val(orderId);
		$("#orderGoodsModal").modal("show");
	}
	
	function submitGoods() {
		$("#orderGoodsForm").submit();
	}
	
	function submitGoodsCallback(response) {
		if (response.status == "success") {
			location.reload(true);
		} else {
			alert(response.msg);
		}
	}
	
	getMessage();
	
	function getMessage() {
		$.get("<c:url value='/client/getClientMessageList/" + $("#clientHiddenId").val() + "/" + $("#orderId").val() + "'/>", function(list) {
			if (list) {
				$("#blink3-block").html("");
				var messageHtml = "";
				for (var i in list) {
					var data = list[i];
					messageHtml += ('<div class="clearfix"><div class="data-info cm-bc">' + data.insertDatetimeLabel + '</div><div class="data-info cm-bc">' + data.message + '</div></div>');
				}
				$("#blink3-block").html(messageHtml);
			}
		});
	}
</script>
</body>
</html>