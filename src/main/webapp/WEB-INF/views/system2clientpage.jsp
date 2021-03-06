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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system/transfer.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/zoom.css'/>"/>
<script src="<c:url value='/js/jquery-1.11.2.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
</head>
<body>
<div id="st-container" class="st-container">
<div class="st-pusher">
	<jsp:include page="system2header.jsp" flush="true"/>
	
	<div class="panel-group" style="margin:20px;" id="accordion" role="tablist" aria-multiselectable="true">
		<input type="hidden" id="allOrderGoodsCount" value="${order.goodsCount}"/>
		<input type="hidden" id="orderId" value="${order.orderId}"/>
		<input type="hidden" id="clientId" value="${order.clientId}"/>
		<div class="panel panel-default">
			<div class="panel-heading" role="tab" id="headingOne">
				<h4 class="panel-title">
					<select id="order-list" class="form-control" style="width:120px;display:inline;margin-right:10px;" onchange="changeOrder()">
						<c:forEach items="${orderNoList}" var="orderNo">
							<c:choose>
								<c:when test="${orderNo.orderId == order.orderId}">
									<option value="${orderNo.orderId}" selected>${orderNo.orderNo}</option>
								</c:when>
								<c:otherwise>
									<option value="${orderNo.orderId}">${orderNo.orderNo}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
					${order.orderNo} 拍摄日期：${order.shootDateLabel} ${order.shootHalf}
					<c:choose>
						<c:when test="${order.status.equals('完成')}">
							<button class="btn btn-info" onclick="downloadZip(${order.orderId})">打包下载</button>
						</c:when>
						<c:otherwise>
							<c:if test="${order.status.equals('等待客户选片')}">
								<button class="btn btn-success" onclick="submitSelectedPictures()">选片完成</button>
							</c:if>
						</c:otherwise>
					</c:choose>
				</h4>
			</div>
			<div class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
	     	 	<div class="panel-body">
	     	 		<ul class="nav nav-tabs nav-justified">
						<li role="presentation" class="active detail-bottom-nav">
							<c:choose>
								<c:when test="${order.status.equals('完成')}">
									<a id="blink2" onclick="changeBottomNavView(this)">精修</a>
								</c:when>
								<c:otherwise>
									<a id="blink1" onclick="changeBottomNavView(this)">原片</a>
								</c:otherwise>
							</c:choose>
						</li>
						<li role="presentation" class="detail-bottom-nav">
							<a id="blink3" onclick="changeBottomNavView(this)">留言</a>
						</li>
					</ul>
					<c:choose>
						<c:when test="${order.status.equals('完成')}">
							<div id="blink2-block" class="detail-bottom-block">
								<c:forEach items="${order.orderFixedImageDataList}" var="imageData">
									<div class="pic-block photo-frame gallery">
										<a id="client-pic-fixed-${imageData.id}" href="<c:url value='/pictures/fixed/${imageData.orderId}/${imageData.id}.jpg'/>">
											<img src="<c:url value='/pictures/fixed/${imageData.orderId}/${imageData.id}.jpg'/>"/>
										</a>
										<p id="client-pic-fixed-label-${imageData.id}">(${imageData.fileName})</p>
									</div>
								</c:forEach>
								<div class="clear"></div>
							</div>
						</c:when>
						<c:otherwise>
							<div id="blink1-block" class="detail-bottom-block">
								<c:forEach items="${order.orderTransferImageDataList}" var="imageData">
									<div class="pic-block photo-frame gallery">
										<a id="client-pic-${imageData.id}" href="<c:url value='/pictures/original/${imageData.orderId}/${imageData.id}.jpg'/>">
											<img src="<c:url value='/pictures/original/${imageData.orderId}/${imageData.id}.jpg'/>"/>
										</a>
										<c:choose>
											<c:when test="${imageData.isSelected == 1}">
												<p id="client-pic-label-${imageData.id}">(${imageData.fileName})<span class='orange-color'>已选</span></p>
											</c:when>
											<c:otherwise>
												<p id="client-pic-label-${imageData.id}">(${imageData.fileName})</p>
											</c:otherwise>
										</c:choose>
									</div>
								</c:forEach>
								<div class="clear"></div>
							</div>
						</c:otherwise>
					</c:choose>
					<div id="blink3-block" class="detail-bottom-block hidden">
						<div id="message-block"></div>
						<textarea id="client-message" rows="4" class="form-control" style="margin-top:10px;"></textarea>
						<button class="btn btn-warning fright" style="margin-top:10px;" onclick="addMessage()">留言</button>
					</div>
	      		</div>
      		</div>
      	</div>
	</div>
</div>
</div>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<c:choose>
	<c:when test="${order.status.equals('等待客户选片')}">
		<script src="<c:url value='/js/zoom-select.js'/>"></script>
	</c:when>
	<c:otherwise>
		<script src="<c:url value='/js/zoom.js'/>"></script>
	</c:otherwise>
</c:choose>
<script src="<c:url value='/js/util/ajax-util.js'/>"></script>
<script>
	var selectedPictureIdList = [];
	var CHOSEN_MAX = parseInt($("#allOrderGoodsCount").val()) * 8;
	var isConfirmOverSelect = false;
	var selectedLabel = "<span class='orange-color'>已选</span>";
	
	function clientPictureSelected(event) {
		var overlay = $(event.currentTarget);
		var img = overlay.next();
		var imgId = img.attr("id").replace("client-pic-", "");
		var clientLabel = $("#client-pic-label-" + imgId);
		var selectButton = $("#select-button");
		if (selectButton.hasClass("picture-button-selected")) {
			selectButton.removeClass("picture-button-selected");
			removeSelectedPicture(imgId);
			clientLabel.html("(" + imgId + ")");
		} else {
			if (selectedPictureIdList.length == CHOSEN_MAX) {
				if (!isConfirmOverSelect) {
					var result = confirm("您选定的张数已超过上限，继续选择每张将收取10元的额外费用，是否继续选择？");
					isConfirmOverSelect = result;
				}
				if (isConfirmOverSelect) {
					selectButton.addClass("picture-button-selected");
					selectedPictureIdList.push(imgId);
					CHOSEN_MAX++;
				}
			} else {
				selectButton.addClass("picture-button-selected");
				selectedPictureIdList.push(imgId);
			}
			clientLabel.html(clientLabel.text() + selectedLabel);
		}
		setChosenLabel();
	}
	
	setChosenLabel();
	
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
	
	function changeBottomNavView(nav) {
		var navheader = $("#" + nav.id);
		$(".detail-bottom-block").addClass("hidden");
		$(".detail-bottom-nav").removeClass("active");
		navheader.parent().addClass("active");
		$("#" + nav.id + "-block").removeClass("hidden");
	}
	
	getMessage();
	
	function getMessage() {
		$.get("<c:url value='/client/getClientMessageList/" + $("#clientId").val() + "/" + $("#orderId").val() + "'/>", function(list) {
			if (list) {
				$("#message-block").html("");
				var messageHtml = "";
				for (var i in list) {
					var data = list[i];
					messageHtml += ("<p><span class='oc-label'>" + data.insertDatetimeLabel + "</span><br/>" + data.message + "</p>");
				}
				$("#message-block").html(messageHtml);
			}
		});
	}
	
	function addMessage() {
		if ($("#client-message").val()) {
			AjaxUtil.post("<c:url value='/client/addClientMessage'/>", {orderId:$("#orderId").val(), clientId:$("#clientId").val(), message:$("#client-message").val()}, function(data) {
				$("#client-message").val("");
				getMessage();
			});
		}
	}
	
	function changeOrder() {
		var selectedOrderId = $("#order-list").val();
		location.assign("<c:url value='/client/main/" + $("#clientId").val() + "/" + selectedOrderId + "'/>");
	}
	
	function downloadZip(orderId) {
		window.open("<c:url value='/orderPostProduction/getFixedImageZipPackage/" + orderId + "'/>");
	}
</script>
</body>
</html>