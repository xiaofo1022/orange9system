﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system/transfer.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/sidebar/component.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/jquery-ui/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/zoom.css'/>"/>
<script src="<c:url value='/js/jquery-1.11.2.min.js'/>"></script>
<script src="<c:url value='/js/jquery-ui.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/js/notification/modernizr.custom.js'/>"></script>
<script src="<c:url value='/js/validation/jquery.validate.js'/>"></script>
<script src="<c:url value='/js/validation/validation-message-cn.js'/>"></script>
<script src="<c:url value='/js/validation/validator.js'/>"></script>
</head>
<body>
<div id="st-container" class="st-container">
<div class="st-pusher">
	<div style="text-align:center;">
		<p class="login-header"><span>ORANGE</span> 9 SYSTEM</p>
	</div>
	
	<jsp:include page="system2sidebar.jsp" flush="true"/>
	
	<div id="st-trigger-effects">
		<button class="btn btn-warning nav-btn" data-effect="st-effect-3">
			<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		</button>
	</div>
	
	<div id="setConvertModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">要指定谁来导图呢？</h4>
				</div>
				<div class="modal-body">	
					<div style="width:200px;">
						<select id="convertorSelect" class="form-control">
							<c:forEach items="${userList}" var="user">
								<option value="${user.id}">${user.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="modal-footer">
					<button id="btnSetTransfer" type="button" class="btn btn-primary" onclick="setConvert()">确定</button>
				</div>
			</div>
		</div>
	</div>
	
	<div id="setVerifyModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">要指定谁来审图呢？</h4>
				</div>
				<div class="modal-body">	
					<div style="width:200px;">
						<select id="verifySelect" class="form-control">
							<c:forEach items="${userList}" var="user">
								<option value="${user.id}">${user.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="modal-footer">
					<button id="btnSetTransfer" type="button" class="btn btn-primary" onclick="setVerifier()">确定</button>
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
	
	<div class="order-block">
		<div class="order-detail-block bd-blue">
			订单详情：
			<input type="hidden" id="orderId" value="${orderDetail.id}"/>
			<span>单号：<span class="oc-label">${orderDetail.id}</span></span>
			<span>拍摄日期：<span class="oc-label">${orderDetail.shootDateLabel}</span></span> 
			<span>状态：</span> 
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
			<span>共计用时：<span class="oc-label">${timeCost}</span></span>
		</div>
		<div class="order-detail-block bd-blue">
			客户信息：
			<span>名称：<span class="oc-label">${orderDetail.client.clientName}</span></span>
			<span>店铺：<a href="http://${orderDetail.client.clientShopLink}" target="_blank">${orderDetail.client.clientShopName}</a></span>
			<span>电话：<span class="oc-label">${orderDetail.client.clientPhone}</span></span>
			<span>邮箱：<span class="oc-label">${orderDetail.client.clientEmail}</span></span>
			<c:if test="${orderDetail.client.clientRemark != null && !orderDetail.client.clientRemark.equals('')}">
				<br/>
				<span class="p-newrow">备注：<span class="oc-label">${orderDetail.client.clientRemark}</span></span>
			</c:if>
		</div>
		<div class="order-detail-block bd-blue">
			货品信息：
			<c:choose>
				<c:when test="${orderDetail.orderGoods == null}">
					<input type="hidden" id="allOrderGoodsCount" value="0"/>
					<button class="btn btn-info" onclick="showAddOrderGoodsWindow(${orderDetail.id})">添加</button>
				</c:when>
				<c:otherwise>
					<input type="hidden" id="allOrderGoodsCount" value="${orderDetail.orderGoods.allCount}"/>
					<c:if test="${orderDetail.orderGoods.coatCount > 0}">
						<span><span class="oc-label">${orderDetail.orderGoods.coatCount}</span>件上装</span>
					</c:if>
					<c:if test="${orderDetail.orderGoods.pantsCount > 0}">
						<span><span class="oc-label">${orderDetail.orderGoods.pantsCount}</span>件下装</span>
					</c:if>
					<c:if test="${orderDetail.orderGoods.jumpsuitsCount > 0}">
						<span><span class="oc-label">${orderDetail.orderGoods.jumpsuitsCount}</span>件连体衣</span>
					</c:if>
					<c:if test="${orderDetail.orderGoods.shoesCount > 0}">
						<span><span class="oc-label">${orderDetail.orderGoods.shoesCount}</span>双鞋子</span>
					</c:if>
					<c:if test="${orderDetail.orderGoods.hatCount > 0}">
						<span><span class="oc-label">${orderDetail.orderGoods.hatCount}</span>顶帽子</span>
					</c:if>
					<c:if test="${orderDetail.orderGoods.bagCount > 0}">
						<span><span class="oc-label">${orderDetail.orderGoods.bagCount}</span>件包包</span>
					</c:if>
					<c:if test="${orderDetail.orderGoods.otherCount > 0}">
						<span><span class="oc-label">${orderDetail.orderGoods.otherCount}</span>件其他</span>
					</c:if>
					<button class="btn btn-info"
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
				</c:otherwise>
			</c:choose>
		</div>
		<div class="order-detail-block bd-blue">
			拍摄信息：
			<input type="hidden" id="photographerId" value="${orderDetail.photographer.id}"/>
			<span>摄影师：<img src="${orderDetail.photographer.header}"/><span class="oc-label">${orderDetail.photographer.name}</span></span>
			<c:if test="${orderDetail.assistant != null}">
				<span>助理：<img src="${orderDetail.assistant.header}"/><span class="oc-label">${orderDetail.assistant.name}</span></span>
			</c:if>
			<br/>
			<span class="p-newrow">模特：<span class="oc-label">${orderDetail.modelName}</span></span>
			<span>化妆师：<span class="oc-label">${orderDetail.dresserName}</span></span>
			<span>搭配师：<span class="oc-label">${orderDetail.stylistName}</span></span>
			<span>经纪人：<span class="oc-label">${orderDetail.brokerName}</span></span>
			<span>联系方式：<span class="oc-label">${orderDetail.brokerPhone}</span></span>
		</div>
		<div class="order-detail-block bd-blue">
			后期情况：
			<span>导图：
				<c:choose>
					<c:when test="${orderDetail.orderStatus.name.equals('导图')}">
						<c:choose>
							<c:when test="${orderConvert == null}">
								<button class="btn btn-info" onclick="showSetConvertWindow()">指定</button>
							</c:when>
							<c:otherwise>
								<img src="${orderConvert.operator.header}"/><span class="oc-label">${orderConvert.operator.name}</span>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${orderConvert == null}">
								<span class="oc-label">未开始</span>
							</c:when>
							<c:otherwise>
								<img src="${orderConvert.operator.header}"/><span class="oc-label">${orderConvert.operator.name}</span>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</span>
			<span>修皮肤及褶皱：
				<c:choose>
					<c:when test="${orderFixSkinList != null && orderFixSkinList.size() > 0}">
						<c:forEach items="${orderFixSkinList}" var="orderFixSkin">
							<img src="${orderFixSkin.operator.header}"/><span class="oc-label">${orderFixSkin.operator.name}</span>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<span class="oc-label">未开始</span>
					</c:otherwise>
				</c:choose>
			</span>
			<span>修背景：
				<c:choose>
					<c:when test="${orderFixBackgroundList != null && orderFixBackgroundList.size() > 0}">
						<c:forEach items="${orderFixBackgroundList}" var="orderFixBackground">
							<img src="${orderFixBackground.operator.header}"/><span class="oc-label">${orderFixBackground.operator.name}</span>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<span class="oc-label">未开始</span>
					</c:otherwise>
				</c:choose>
			</span>
			<span>裁图液化：
				<c:choose>
					<c:when test="${orderCutLiquifyList != null && orderCutLiquifyList.size() > 0}">
						<c:forEach items="${orderCutLiquifyList}" var="orderCutLiquify">
							<img src="${orderCutLiquify.operator.header}"/><span class="oc-label">${orderCutLiquify.operator.name}</span>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<span class="oc-label">未开始</span>
					</c:otherwise>
				</c:choose>
			</span>
			<br/>
			<span class="p-newrow">审图：
				<c:choose>
					<c:when test="${orderDetail.orderStatus.name.equals('等待审核')}">
						<c:choose>
							<c:when test="${orderVerifier == null}">
								<button class="btn btn-info" onclick="showSetVerifierWindow()">指定</button>
							</c:when>
							<c:otherwise>
								<img src="${orderVerifier.operator.header}"/><span class="oc-label">${orderVerifier.operator.name}</span>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${orderVerifier == null}">
								<span class="oc-label">未开始</span>
							</c:when>
							<c:otherwise>
								<img src="${orderVerifier.operator.header}"/><span class="oc-label">${orderVerifier.operator.name}</span>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</span>
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
			</ul>
			<div id="blink1-block" class="detail-bottom-block">
				<c:forEach items="${orderTransferImageDataList}" var="imageData">
					<div class="pic-block photo-frame gallery">
						<a id="client-pic-${imageData.id}" href="<c:url value='/pictures/original/${imageData.orderId}/${imageData.id}.jpg'/>">
							<img src="<c:url value='/pictures/original/${imageData.orderId}/${imageData.id}.jpg'/>"/>
						</a>
						<c:choose>
							<c:when test="${imageData.isSelected == 1}">
								<p id="client-pic-label-${imageData.id}">(${imageData.id})<span class='orange-color'>已选</span></p>
							</c:when>
							<c:otherwise>
								<p id="client-pic-label-${imageData.id}">(${imageData.id})</p>
							</c:otherwise>
						</c:choose>
					</div>
				</c:forEach>
				<div class="clear"></div>
			</div>
			<div id="blink2-block" class="detail-bottom-block hidden">
				<c:if test="${orderDetail.orderStatus.name.equals('完成')}">
					<div>
						<a href="<c:url value='/orderPostProduction/getFixedImageZipPackage/${orderDetail.id}'/>" target="_blank">打包下载</a>
					</div>
				</c:if>
				<c:forEach items="${orderFixedImageDataList}" var="imageData">
					<div class="pic-block photo-frame">
						<img src="<c:url value='/pictures/fixed/${imageData.orderId}/${imageData.id}.jpg'/>"/>
						<c:choose>
							<c:when test="${imageData.isVerified == 1}">
								<p id="fixed-pic-label-${imageData.id}" class='success-color'>(${imageData.fileName})<span>审核通过</span></p>
							</c:when>
							<c:when test="${imageData.isVerified == 0 && imageData.reason != null}">
								<p id="fixed-pic-label-${imageData.id}" class='danger-color'>(${imageData.fileName})</p>
								<p class='danger-color'>未通过：${imageData.reason}</p>
								<p><button class="btn btn-danger btn-sm" onclick="openUploadImageWindow(${imageData.id})">重新上传</button></p>
							</c:when>
							<c:otherwise>
								<p id="fixed-pic-label-${imageData.id}">(${imageData.fileName})</p>
							</c:otherwise>
						</c:choose>
					</div>
				</c:forEach>
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
				<c:forEach items="${orderHistoryList}" var="orderHistory">
					<p>
						${orderHistory.insertDatetimeLabel}
						<span class="oc-label">${orderHistory.info}</span>
						BY: 
						<span class="oc-label">${orderHistory.user.name}</span>
					</p>
				</c:forEach>
			</div>
		</div>
	</div>
	
	<jsp:include page="system2uploadimage.jsp"/>
</div>
</div>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script src="<c:url value='/js/zoom.js'/>"></script>
<script src="<c:url value='/js/util/transferUploader.js'/>"></script>
<script>
	init();

	function init() {
		$("#upload-image").removeAttr("multiple");
		$("#uploadImagesModal").on('hidden.bs.modal', function (e) {
			location.reload(true);
		});
	}

	function openUploadImageWindow(imageId) {
		$("#upload-url").val("<c:url value='/orderPostProduction/reuploadFixedImage/" + imageId + "'/>");
		$("#uploadImagesModal").modal("show");
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
	
	function updateOrderStatus() {
		var orderId = $("#orderId").val();
		var statusId = $("#orderStatus").val();
		var userId = $("#photographerId").val();
		if (statusId == 2) {
			$.post("<c:url value='/order/setOrderTransfer/" + orderId + "/" + userId + "'/>", null, function(data, status) {
				if (data.status == "success") {
					location.reload(true);
				} else {
					console.log(data);
				}
			});
		} else {
			$.post("<c:url value='/order/updateOrderStatus/" + orderId + "/" + statusId + "'/>", null, function(data, status) {
				if (data.status == "success") {
					location.reload(true);
				} else {
					console.log(data);
				}
			});
		}
	}
	
	function setVerifier() {
		var orderId = $("#orderId").val();
		var userId = $("#verifySelect").val();
		$.post("<c:url value='/orderVerify/setOrderVerifier/" + orderId + "/" + userId + "'/>", null, function(data, status) {
			if (data.status == "success") {
				location.reload(true);
			} else {
				console.log(data);
			}
		});
	}
	
	function setConvert() {
		var orderId = $("#orderId").val();
		var userId = $("#convertorSelect").val();
		$.post("<c:url value='/orderConvert/setOrderConvertor/" + orderId + "/" + userId + "'/>", null, function(data, status) {
			if (data.status == "success") {
				location.reload(true);
			} else {
				console.log(data);
			}
		});
	}
	
	var selectedPictureIdList = [];
	var CHOSEN_MAX = parseInt($("#allOrderGoodsCount").val()) * 8;
	var isConfirmOverSelect = false;
	var selectedLabel = "<span class='orange-color'>已选</span>";
	
	setChosenLabel();
	
	function clientPictureSelected(event) {
		var overlay = $(event.currentTarget);
		var img = overlay.next();
		var imgId = img.attr("id").replace("client-pic-", "");
		var clientLabel = $("#client-pic-label-" + imgId);
		if (overlay.hasClass("picture-selected")) {
			overlay.removeClass("picture-selected");
			removeSelectedPicture(imgId);
			clientLabel.html("(" + imgId + ")");
		} else {
			if (selectedPictureIdList.length == CHOSEN_MAX) {
				if (!isConfirmOverSelect) {
					var result = confirm("您选定的张数已超过上限，继续选择每张将收取10元的额外费用，是否继续选择？");
					isConfirmOverSelect = result;
				}
				if (isConfirmOverSelect) {
					overlay.addClass("picture-selected");
					selectedPictureIdList.push(imgId);
					CHOSEN_MAX++;
				}
			} else {
				overlay.addClass("picture-selected");
				selectedPictureIdList.push(imgId);
			}
			clientLabel.html(clientLabel.text() + selectedLabel);
		}
		setChosenLabel();
	}
	
	function setChosenLabel() {
		$("#chosen-label").text("已选 (" + selectedPictureIdList.length + " / " + CHOSEN_MAX + ") 张");
	}
	
	function isPictureSelected(linkId) {
		var id = linkId.replace("client-pic-", "");
		for (var i in selectedPictureIdList) {
			if (selectedPictureIdList[i] == id) {
				return true;
			}
		}
		return false;
	}
	
	function removeSelectedPicture(id) {
		for (var i in selectedPictureIdList) {
			if (selectedPictureIdList[i] == id) {
				selectedPictureIdList.splice(i, 1);
			}
		}
	}
	
	function submitSelectedPictures() {
		if (selectedPictureIdList.length == 0) {
			alert("您还未选定照片");
			return;
		}
		var result = confirm("您已选定" + selectedPictureIdList.length + "张照片，是否确定提交？");
		if (result) {
			$('#zoom .close').click();
			$.ajax({  
	            url: "<c:url value='/orderTransfer/setTransferImageSelected/" + $("#orderId").val() + "'/>",  
	            type: 'post',
	            contentType: 'application/json',
	            data: JSON.stringify(selectedPictureIdList),  
	            success: function(data) {
	            	location.reload(true);
	            },  
	            error: function(data) {
	            	console.log(data);
	            }
			});
		}
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
</script>
</body>
</html>