var Notification = function(senderId, baseUrl) {
	this.senderId = senderId;
	this.baseUrl = baseUrl;
};

Notification.prototype = {
	send: function(receiverId, orderNo, action) {
		var canSend = false;
		if (!this.lastSendTime) {
			canSend = true;
		} else {
			var now = new Date();
			var sendInterval = (now.getTime() - this.lastSendTime.getTime()) / 1000;
			if (sendInterval > 30) {
				canSend = true;
			}
		}
		if (canSend) {
			var message = "订单" + orderNo + action + "快一点！";
			var sendData = {senderId:this.senderId, receiverId:receiverId, message:message};
			this.lastSendTime = now;
			$.ajax({  
	            url: this.baseUrl + "notification/addNotification",  
	            type: 'post',
	            contentType: 'application/json',
	            data: JSON.stringify(sendData),  
	            success: function(data) {
	            	console.log(data);
	            },
	            error: function(data) {
	            	console.log(data);
	            }
			});
		}
	},
	get: function(thumbslider) {
		var ins = this;
		$.get(this.baseUrl + "notification/getNotification", function(data) {
			if (data && thumbslider) {
				thumbslider.showMessage(data.sender.header, data.message);
				ins.read(data.id);
			}
		});
	},
	read: function(id) {
		$.post(this.baseUrl + "notification/readNotification/" + id, null, function(data) {
			console.log(data);
		});
	}
};