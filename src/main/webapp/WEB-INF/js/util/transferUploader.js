var TransferUploader = function(orderId, orderTransferImageId, transferButton, timeLabelId, remainTimeId, timeBarId, uploadFileMap) {
	this.orderId = orderId;
	this.orderTransferImageId = orderTransferImageId;
	this.transferButton = transferButton;
	this.timeLabelId = timeLabelId;
	this.remainTimeId = remainTimeId;
	this.timeBarId = timeBarId;
	this.uploadFileMap = uploadFileMap;
};

TransferUploader.prototype = {
	setUploadUrl: function(url) {
		this.url = url;
	},
		
	setUploadDoneUrl: function(doneUrl) {
		this.doneUrl = doneUrl;
	},
	
	uploadImage: function() {
		var transferTip = "传输中...";
		this.transferButton.attr("disabled", true);
		this.transferButton.text(transferTip);
		var mapSize = this.getMapCount(this.uploadFileMap);
		var uploadedCount = 0;
		var successCount = 0;
		var failureCount = 0;
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
	            contentType : 'application/json',
	            data: JSON.stringify(transferImageData),  
	            success: function(data) {
	            	uploadedCount++
	            	if (data.status == "success") {
	            		successCount++;
	            	} else {
	            		failureCount++;
	            	}
	            	ins.transferButton.text(transferTip + "(" + successCount + ")");
	            	if (uploadedCount == mapSize) {
	            		ins.setFinalTip(successCount, failureCount);
	            	}
	            },  
	            error: function(data) {
	            	uploadedCount++;
	            	failureCount++;
	            	if (uploadedCount == mapSize) {
	            		ins.setFinalTip(successCount, failureCount);
	            	}
	                console.log(data);
	            }  
	        });
		}
	},
	
	setFinalTip: function(successCount, failureCount) {
		this.transferButton.text("上传完成：成功(" + successCount + ")张 失败(" + failureCount + ")张");
		$("#" + this.timeLabelId).hide();
		$("#" + this.remainTimeId).hide();
		$("#" + this.timeBarId).hide();
		this.setUploadDone();
	},
	
	setUploadDone: function() {
		$.ajax({  
            url: this.doneUrl + "/" + this.orderId + "/" + this.orderTransferImageId,  
            type: 'post',
            success: function(data) {
            	console.log(data.msg);
            },  
            error: function(data) {
                console.log(data);
            }  
        });
	},
	
	getMapCount: function(map) {
		var count = 0;
		for (var key in map) {
			count++;
		}
		return count;
	}
};