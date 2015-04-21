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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/system/transfer.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/sidebar/component.css'/>" />
<script src="<c:url value='/js/jquery-1.11.2.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
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
	
	<div id="transferContainer"></div>
	
	<div id="uploadImagesModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">图片上传  <span style="font-size:14px;">(注：大于10MB的图片和非JPG格式的图片会被自动过滤)</span></h4>
				</div>
				<div class="modal-body">
					<div id="upload-container" class="upload-container"></div>
					<div class="clear"></div>
					<input id="orderTransferImageId" type="hidden"/>
					<input id="orderId" type="hidden"/>
				</div>
				<div class="modal-footer">
					<input class="btn btn-primary" style="float:left;" type="file" multiple="multiple" id="upload-image"/>
					<button id="btn-upload" type="button" class="btn btn-success" style="float:right;" onclick="uploadImage()">开始上传</button>
					<button id="btn-clear" type="button" class="btn btn-info" style="float:right;" onclick="emptyUploadContainer()">清空</button>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<input type="hidden" id="limitMinutes" value="${limitMinutes}"/>
<script src="<c:url value='/js/svg/classie.js'/>"></script>
<script src="<c:url value='/js/sidebar/sidebarEffects.js'/>"></script>
<script src="<c:url value='/js/util/countDown.js'/>"></script>
<script src="<c:url value='/js/util/transferUploader.js'/>"></script>
<script>
	var limitSecond = parseInt($("#limitMinutes").val()) * 60;
	
	init();
	
	function init() {
		$.get("<c:url value='/orderTransfer/getOrderList'/>", function(list, status) {
			if (list) {
				var container = $("#transferContainer");
				var transferHtml = "";
				for (var i in list) {
					var data = list[i];
					transferHtml += '<div class="order-block">';
					transferHtml += getTransferHeader(data);
					transferHtml += getTransferInfo(data);
					transferHtml += getTransferBar(data);
					transferHtml += '</div>';
				}
				container.html(transferHtml);
				for (var i in list) {
					var data = list[i];
					var id = data.id;
					var startTime = new Date();
					startTime.setTime(data.insertDatetime);
					new CountDown(startTime, limitSecond, "time-bar-" + id, "time-label-" + id, "remain-time-" + id);
				}
			}
		});
	}
	
	function getTransferHeader(data) {
		return '<p class="model-label transfer-label">'
			+ '单号：<a href="<c:url value="/order/orderDetail/' + data.orderId + '"/>" target="_blank">O9' + data.orderId + '</a><span id="time-label-' + data.id + '" class="ml10" style="color:#F0AD4E;">'
			+ '剩余时间：</span><span id="remain-time-' + data.id + '"></span></p>';
	}
	
	function getTransferInfo(data) {
		return '<p class="model-label transfer-label">'
			+ '摄影师：<img src="' + data.operator.header + '"/><span class="ml10">' + data.operator.name + '</span>'
			+ '<button id="btn-transfer-' + data.id + '" class="btn btn-info ml10" onclick="openUploadImageWindow(' + data.id + ', ' + data.orderId + ')">上传</button>'
			+ '<button id="btn-transfer-done-' + data.id + '" class="btn btn-success ml10" onclick="setTransferComplete(' + data.id + ', ' + data.orderId + ')">完成</button></p>';
	}
	
	function getTransferBar(data) {
		return '<div id="time-progress-bar-' + data.id + '" class="progress" style="margin-bottom:0;">'
			+ '<div id="time-bar-' + data.id + '" class="progress-bar progress-bar-success" role="progressbar"'
			+ 'aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:0%"></div></div>';	
	}
	
	function openUploadImageWindow(orderTransferId, orderId) {
		$("#orderTransferImageId").val(orderTransferId);
		$("#orderId").val(orderId);
		$("#uploadImagesModal").modal("show");
	}
	
	function setTransferComplete(orderTransferId, orderId) {
		var result = confirm("确定原片已上传完成吗？");
		if (result) {
			$.ajax({  
	            url: "<c:url value='/orderTransfer/setTransferImageIsDone/" + orderId + "/" + orderTransferId + "'/>",  
	            type: 'post',
	            success: function(data) {
	            	location.reload(true);
	            },  
	            error: function(data) {
	                console.log(data);
	            }  
	        });
		}
	}
	
	var fileMap = {};
	var fileCount = 0;
	var uploadContainer = $("#upload-container");
	
	document.getElementById("upload-image").onchange = selectImage;
	
	function emptyUploadContainer() {
		fileMap = {};
		$("#upload-container").empty();
		$("#btn-upload").text("开始上传");
	}
	
	$("#uploadImagesModal").on("hide.bs.modal", function(event) {
		if ($("#btn-upload").attr("disabled")) {
			event.preventDefault();
			return;
		}
	});
	
	$("#uploadImagesModal").on("hidden.bs.modal", function() {
		if (!$("#btn-upload").attr("disabled")) {
			emptyUploadContainer();
		}
	});
	
	function selectImage(event) {
		if (this.files) {
			for (var i in this.files) {
				var file = this.files[i];
				if (!(file.type && file.type.indexOf('image') == 0 && /\.(?:jpg|JPG)$/.test(file.name))) {
					continue;
				}
				if (file.size > 1024 * 1024 * 1024) {
					continue;
				}
				if (typeof(file) == "object") {
					var fileReader = new FileReader();
					fileReader.fileIndex = fileCount;
					fileReader.fileLoaded = 0;
					fileReader.fileName = file.name.split(".")[0];
					fileReader.fileLoadedTotal = file.size;
					fileReader.onload = function(event) {
						var result = event.target.result;
						$("#upload-img-" + event.currentTarget.fileIndex).attr("src", result);
						var fileData = result.split(",")[1];
						var fileName = event.currentTarget.fileName;
						fileMap[event.target.fileIndex] = {fileName:fileName, fileData:fileData};
					};
					fileReader.onprogress = function(event) {
					};
					fileReader.onloadstart = function(event) {
						var fileIndex = event.currentTarget.fileIndex;
						var fileName = event.currentTarget.fileName;
						if (fileName.length > 12) {
							fileName = fileName.substring(0, 8) + "...";
						}
						uploadContainer.html(uploadContainer.html() + getUploadBlock(fileIndex, fileName));
					};
					fileReader.readAsDataURL(file);
					fileCount++;
				}
			}
		}
	}
	
	function removeSelectedImage(id) {
		$("#update-block-" + id).remove();
		delete fileMap[id];
	}
	
	function getUploadBlock(id, fileName) {
		return '<div id="update-block-' + id + '" class="upload-block"><div class="progress upload-bar">'
			+ '<div id="upload-bar-' + id + '" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:0%;"></div></div>'
			+ '<span class="glyphicon glyphicon-remove upload-remove" onclick="removeSelectedImage(' + id + ')"></span>'
			+ '<img id="upload-img-' + id + '" src="<c:url value="/images/loading.gif"/>"/>'
			+ '<p>' + fileName + '</p></div>';
	}
	
	function uploadImage() {
		if ($("#btn-upload").text() == "开始上传") {
			var orderTransferImageId = $("#orderTransferImageId").val();
			var orderId = $("#orderId").val();
			var transferButton = $("#btn-upload");
			var clearButton = $("#btn-clear");
			var uploadFileMap = fileMap;
			var transferUploader = new TransferUploader(orderId, orderTransferImageId, transferButton, clearButton, uploadFileMap);
			transferUploader.setUploadUrl("<c:url value='/orderTransfer/uploadTransferImage'/>");
			transferUploader.uploadImage();
		} else {
			$("#uploadImagesModal").modal("hide");
		}
	}
</script>
</body>
</html>