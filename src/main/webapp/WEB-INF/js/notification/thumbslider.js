var NotificationThumbslider = function() {
};

NotificationThumbslider.prototype = {
	showMessage: function(msg) {
		setTimeout( function() {

			// create the notification
			var notification = new NotificationFx({
				message : '<div class="ns-thumb"><img src="../images/header/boss.png" style="width:64px;"/></div><div class="ns-content"><p>' + msg + '</p></div>',
				layout : 'other',
				ttl : 6000,
				effect : 'thumbslider',
				type : 'warning', // notice, warning, error or success
				onClose : function() {
					// Can be some callback here!
				}
			});

			// show the notification
			notification.show();

		}, 1200 );
	}
};