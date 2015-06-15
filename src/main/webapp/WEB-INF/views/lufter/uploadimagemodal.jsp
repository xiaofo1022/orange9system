<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<input type="hidden" id="upload-url"/>

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

<script>
	var fileMap = {};
	var fileCount = 0;
	var uploadContainer = $("#upload-container");
	
	document.getElementById("upload-image").onchange = selectImage;
	
	function emptyUploadContainer() {
		fileMap = {};
		$("#upload-container").empty();
		$("#btn-upload").text("开始上传");
	}
	
	$("#uploadImagesModal").on("hidden.bs.modal", function(event) {
		if (!$("#btn-upload").attr("disabled")) {
			event.preventDefault();
			emptyUploadContainer();
			location.reload(true);
			return;
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
			transferUploader.setUploadUrl($("#upload-url").val());
			transferUploader.uploadImage();
		} else {
			$("#uploadImagesModal").modal("hide");
		}
	}
</script>