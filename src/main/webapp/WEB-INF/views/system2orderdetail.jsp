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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/zoom.css'/>"/>
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
			<br/>
			<span class="p-newrow">备注：<span class="oc-label">${orderDetail.client.clientRemark}</span></span>
		</div>
		<div class="order-detail-block bd-blue">
			货品信息：
			<span class="oc-label">暂无信息</span>
			<!--
			<span><span class="oc-label">10</span>件上装</span>
			<span><span class="oc-label">20</span>件下装</span>
			<span><span class="oc-label">15</span>件连体衣</span>
			<span><span class="oc-label">4</span>双鞋子</span>
			-->
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
				<c:forEach items="${orderHistoryList}" var="orderHistory">
					<p>
						${orderHistory.insertDatetimeLabel}
						<span class="oc-label">${orderHistory.info}</span>
						BY: 
						<span class="oc-label">${orderHistory.user.name}</span>
					</p>
				</c:forEach>
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
<script src="<c:url value='/js/zoom.js'/>"></script>
<script>
	function showSetConvertWindow() {
		$("#setConvertModal").modal("show");
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
		if (statusId == 2 || statusId == 3) {
			setTransfer();
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
	
	function setTransfer() {
		var orderId = $("#orderId").val();
		var userId = $("#photographerId").val();
		$.post("<c:url value='/order/setOrderTransfer/" + orderId + "/" + userId + "'/>", null, function(data, status) {
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
	var CHOSEN_MAX = 4;
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
</script>
</body>
</html>