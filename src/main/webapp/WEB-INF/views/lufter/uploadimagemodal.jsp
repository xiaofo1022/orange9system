<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<input class="hidden" multiple="multiple" type="file" id="complete-post-production"/>

<div id="uploadImagesModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">上传中 休息一下吧</h4>
			</div>
			<div class="modal-body">
				<div id="upload-container" class="upload-container clearfix">
					<div class="progress clearfix" style="margin-bottom:0;">
						<div id="upload-progress-bar" class="progress-bar progress-bar-success fleft" role="progressbar"
							aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:0%;">
							 <span id="upload-bar-info">[0 / 0]</span>
						</div>
					</div>
				</div>
				<input id="orderTransferImageId" type="hidden"/>
				<input id="orderId" type="hidden"/>
			</div>
		</div>
	</div>
</div>

<script>
	var compOrderId;
	var completeCount = 0;
	var allCount = 0;
	var uploadUrl = "";
	var fileReader = new FileReader();
	
	$("#complete-post-production").bind("change", function(event) {
		var files = event.target.files;
		completeCount = 0;
		allCount = files.length;
		if (allCount > 0) {
			var container = $("#upload-container");
			changeUploadBar();
			for (var i = 0; i < allCount; i++) {
				var file = files[i];
				container.append($(
						'<div class="fleft upload-filename-block">' + file.name + 
						'<span id="upload-span-' + i + '" class="glyphicon glyphicon-ok lofter-color"></span></div>'));
			}
			$("#uploadImagesModal").modal("show");
			startTime = new Date();
			uploadImageAction(files, 0, compOrderId);
		}
	});
	
	function changeUploadBar() {
		$("#upload-bar-info").text("[" + completeCount + "/" + allCount + "]");
		$("#upload-progress-bar").css("width", parseInt((completeCount / allCount) * 100) + "%");
	}
	
	function uploadImageAction(files, index, orderId) {
		var file = files[index];
		if (file) {
			try {
				var frontName = file.name.split(".")[0];
				fileReader.frontName = frontName;
				fileReader.onload = function(event) {
					var base64Data = event.target.result.split(",")[1];
					var frontName = this.frontName;
					AjaxUtil.post(uploadUrl, {orderId:orderId, fileName:this.frontName, base64Data:base64Data}, function(data) {
						var uploadSpan = $("#upload-span-" + index);
						if (data && data.status == "success") {
							completeCount++;
							uploadSpan.removeClass("lofter-color");
							uploadSpan.addClass("success-color");
							changeUploadBar();
							if (completeCount == allCount) {
								location.reload(true);
							}
						} else {
							uploadSpan.attr("class", "glyphicon glyphicon-remove netease-color");
						}
						uploadImageAction(files, index + 1, orderId);
					});
				};
				try {
					fileReader.readAsDataURL(file);
				} catch (exp) {
				}
			} catch (exp) {
			}
		}
	}
</script>