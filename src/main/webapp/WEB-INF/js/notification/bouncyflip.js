var NotificationMemo = function() {
	
};

NotificationMemo.prototype = {
	showMemo: function(title, memo) {
		setTimeout( function() {

			// create the notification
			var notification = new NotificationFx({
				message : '<span class="icon icon-calendar"></span><p>哈哈哈哈哈</p>',
				layout : 'attached',
				effect : 'bouncyflip',
				type : 'notice', // notice, warning or error
				onClose : function() {
					//Call back;
				}
			});

			// show the notification
			notification.show();

		}, 1200 );
	}
};