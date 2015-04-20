var TransferUploader = function(orderId, orderTransferImageId, transferButton, clearButton, uploadFileMap) {
	this.orderId = orderId;
	this.orderTransferImageId = orderTransferImageId;
	this.transferButton = transferButton;
	this.clearButton = clearButton;
	this.uploadFileMap = uploadFileMap;
	this.mapSize = this.getMapCount(this.uploadFileMap);
	this.uploadedCount = 0;
	this.successCount = 0;
	this.failureCount = 0;
};

TransferUploader.prototype = {
	setUploadUrl: function(url) {
		this.url = url;
	},
		
	uploadImage: function() {
		if (this.mapSize > 0) {
			var transferTip = "传输中...";
			this.transferButton.attr("disabled", true);
			this.clearButton.attr("disabled", true);
			this.transferButton.text(transferTip);
			var ins = this;
			for (var key in this.uploadFileMap) {
				var fileData = this.uploadFileMap[key];
				var transferImageData = {
					orderTransferImageId: this.orderTransferImageId,
					orderId: this.orderId,
					imageData: fileData
				};
				$.ajax({  
		            url: this.url,  
		            type: 'post',
		            contentType: 'application/json',
		            tempFileKey: key,
		            data: JSON.stringify(transferImageData),  
		            success: function(data) {
		            	ins.uploadedCount++;
		            	if (data.status == "success") {
		            		ins.successCount++;
		            		ins.setBarSuccessStyle(this.tempFileKey);
		            	} else {
		            		ins.failureCount++;
		            		ins.setBarFailureStyle(this.tempFileKey);
		            	}
		            	ins.transferButton.text(transferTip + "(" + ins.successCount + ")");
		            	if (ins.uploadedCount == ins.mapSize) {
		            		ins.setFinalTip();
		            	}
		            },  
		            error: function(data) {
		            	ins.uploadedCount++;
		            	ins.failureCount++;
		            	ins.setBarFailureStyle(this.tempFileKey);
		            	if (ins.uploadedCount == ins.mapSize) {
		            		ins.setFinalTip();
		            	}
		                console.log(data);
		            }  
		        });
			}
		}
	},
	
	setBarSuccessStyle: function(index) {
		$("#upload-bar-" + index).css("width", "100%");
	},
	
	setBarFailureStyle: function(index) {
		var bar = $("#upload-bar-" + index);
		bar.removeClass("progress-bar-success");
		bar.addClass("progress-bar-danger");
		$("#upload-bar-" + index).css("width", "100%");
	},
	
	setFinalTip: function() {
		this.transferButton.text("上传完成：成功(" + this.successCount + ")张 失败(" + this.failureCount + ")张");
		this.transferButton.attr("disabled", false);
		this.clearButton.attr("disabled", false);
	},
	
	getMapCount: function(map) {
		var count = 0;
		for (var key in map) {
			count++;
		}
		return count;
	}
};