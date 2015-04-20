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
	
	<div id="setTransferModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">要指定谁来导图呢？</h4>
				</div>
				<div class="modal-body">	
					<div style="width:200px;">
						<select id="transferSelect" class="form-control">
							<c:forEach items="${userList}" var="user">
								<option value="${user.id}">${user.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="modal-footer">
					<button id="btnSetTransfer" type="button" class="btn btn-primary" onclick="setTransfer()">确定</button>
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
					<c:when test="${orderTransfer != null}">
						<img src="${orderTransfer.operator.header}"/>
						<span class="oc-label">${orderTransfer.operator.name}</span>
					</c:when>
					<c:otherwise>
						<span class="oc-label">未开始</span>
					</c:otherwise>
				</c:choose>
			</span>
			<span>修皮肤及褶皱：<span class="oc-label">未开始</span></span>
			<span>修背景：<span class="oc-label">未开始</span></span>
			<span>裁图液化：<span class="oc-label">未开始</span></span>
			<!-- 
			<span>导图：<img src="<c:url value='/images/header/old_man.png'/>"/><span class="oc-label">李学华</span></span>
			<span>修皮肤及褶皱：<img src="<c:url value='/images/header/shenyulin.png'/>"/><span class="oc-label">沈玉琳</span></span>
			<span>修背景：<img src="<c:url value='/images/header/zhanglidong.png'/>"/><span class="oc-label">张立东</span></span>
			<span>裁图液化：<img src="<c:url value='/images/header/awei.png'/>"/><span class="oc-label">常威</span></span>
			-->
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
						<a id="client-pic-${imageData.id}" href="<c:url value='/pictures/${imageData.orderId}/${imageData.id}.jpg'/>">
							<img src="<c:url value='/pictures/${imageData.orderId}/${imageData.id}.jpg'/>"/>
						</a>
						<p>(${imageData.id})</p>
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
		if (statusId == 3) {
			$("#setTransferModal").modal("show");
		} else {
			$.post("<c:url value='/order/updateOrderStatus/" + orderId + "/" + statusId + "'/>", null, function(data, status) {
				if (data.status == "success") {
					location.reload(true);
				} else {
					console.log(data.msg);
				}
			});
		}
	}
	
	function setTransfer() {
		$("#setTransferModal").modal("hide");
		var orderId = $("#orderId").val();
		var userId = $("#transferSelect").val();
		$.post("<c:url value='/order/setOrderTransfer/" + orderId + "/" + userId + "'/>", null, function(data, status) {
			if (data.status == "success") {
				location.reload(true);
			} else {
				console.log(data.msg);
			}
		});
	}
	
	var selectedPictureIdList = [];
	
	function clientPictureSelected(event) {
		var overlay = $(event.currentTarget);
		var img = overlay.next();
		var imgId = img.attr("id").replace("client-pic-", "");
		if (overlay.hasClass("picture-selected")) {
			overlay.removeClass("picture-selected");
			removeSelectedPicture(imgId);
		} else {
			overlay.addClass("picture-selected");
			selectedPictureIdList.push(imgId);
		}
	}
	
	function removeSelectedPicture(id) {
		for (var i in selectedPictureIdList) {
			if (selectedPictureIdList[i] == id) {
				selectedPictureIdList.slice(i, 1);
			}
		}
	}
</script>
</body>
</html>