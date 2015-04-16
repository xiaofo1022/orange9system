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
				</div>
				<div class="modal-footer">
					<input class="btn btn-primary" style="float:left;" type="file" multiple="multiple" id="upload-image"/>
					<button type="button" class="btn btn-success" style="float:right;" onclick="uploadImage()">开始上传</button>
					<button type="button" class="btn btn-info" style="float:right;" onclick="emptyUploadContainer()">清空</button>
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
			+ '单号：<span>O9' + data.id + '</span><span id="time-label-' + data.id + '" class="ml10" style="color:#F0AD4E;">'
			+ '剩余时间</span>：<span id="remain-time-' + data.id + '"></span></p>';
	}
	
	function getTransferInfo(data) {
		return '<p class="model-label transfer-label">'
			+ '导图人：<img src="' + data.operator.header + '"/><span class="ml10">' + data.operator.name + '</span>'
			+ '<button class="btn btn-danger ml10">催一下</button><button class="btn btn-success ml10" onclick="openUploadImageWindow(' + data.id + ')">导图</button></p>';
	}
	
	function getTransferBar(data) {
		return '<div class="progress" style="margin-bottom:0;">'
			+ '<div id="time-bar-' + data.id + '" class="progress-bar progress-bar-success" role="progressbar"'
			+ 'aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:0%"></div></div>';	
	}
	
	function openUploadImageWindow(orderTransferId) {
		$("#orderTransferImageId").val(orderTransferId);
		$("#uploadImagesModal").modal("show");
	}
	
	var fileMap = {};
	var fileCount = 0;
	var uploadContainer = $("#upload-container");
	
	document.getElementById("upload-image").onchange = selectImage;
	
	function emptyUploadContainer() {
		fileMap = {};
		$("#upload-container").empty();
	}
	
	$("#uploadImagesModal").on("hidden.bs.modal", function() {
		emptyUploadContainer();
	});
	
	function selectImage(event) {
		if (this.files) {
			for (var i in this.files) {
				var file = this.files[i];
				if (!(file.type && file.type.indexOf('image') == 0 && /\.(?:jpg)$/.test(file.name))) {
					return;
				}
				if (file.size > 1024 * 1024 * 512) {
					return;
				}
				if (typeof(file) == "object") {
					var fileReader = new FileReader();
					fileReader.fileIndex = fileCount;
					fileReader.fileLoaded = 0;
					fileReader.fileLoadedTotal = file.size;
					fileReader.onload = function(event) {
						var result = event.target.result;
						$("#upload-img-" + event.currentTarget.fileIndex).attr("src", result);
						fileMap[event.target.fileIndex] = result.split(",")[1];
					};
					fileReader.onprogress = function(event) {
						var fr = event.currentTarget;
						fr.fileLoaded += event.loaded;
						var loadPercent = Math.floor((fr.fileLoaded / fr.fileLoadedTotal) * 100);
						$("#upload-bar-" + fr.fileIndex).css("width", loadPercent + "%");
					};
					fileReader.onloadstart = function(event) {
						uploadContainer.html(uploadContainer.html() + getUploadBlock(event.currentTarget.fileIndex));
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
	
	function getUploadBlock(id) {
		return '<div id="update-block-' + id + '" class="upload-block"><div class="progress upload-bar">'
			+ '<div id="upload-bar-' + id + '" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:0%"></div></div>'
			+ '<span class="glyphicon glyphicon-remove upload-remove" onclick="removeSelectedImage(' + id + ')"></span>'
			+ '<img id="upload-img-' + id + '" src="<c:url value="/images/loading.gif"/>"/></div>';
	}
	
	function uploadImage() {
		$("#uploadImagesModal").modal("hide");
		var orderTransferImageId = $("#orderTransferImageId").val();
		for (var key in fileMap) {
			var fileData = fileMap[key];
			var transferImageData = {
				orderTransferImageId: orderTransferImageId,
				imageData: fileData
			};
			$.ajax({  
	            url: "<c:url value='/orderTransfer/uploadTransferImage'/>",  
	            type: 'post',
	            contentType : 'application/json',
	            data: JSON.stringify(transferImageData),  
	            success: function(data) {
	            	delete fileMap[key];
	            	if (data.status == "success") {
	            		
	            	} else {
	            		
	            	}
	            },  
	            error: function(data) {
	            	delete fileMap[key];
	                console.log(data);
	            }  
	        });
		}
	}
</script>
</body>
</html>