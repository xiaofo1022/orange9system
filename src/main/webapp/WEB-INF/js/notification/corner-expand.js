(function() {
	var svgshape = document.getElementById( 'notification-shape' ),
		s = Snap( svgshape.querySelector( 'svg' ) ),
		path = s.select( 'path' ),
		pathConfig = {
			from : path.attr( 'd' ),
			to : svgshape.getAttribute( 'data-path-to' )
		};
	
	showMessage();
		
	function showMessage() {
		setTimeout( function() {

			path.animate( { 'path' : pathConfig.to }, 300, mina.easeinout );
			
			// create the notification
			var notification = new NotificationFx({
				wrapper : svgshape,
				message : '<p style="font-size:16px;margin-top:30px;"> 亲，您于早上8点30分打卡成功了哟！努力开始今天的工作吧，加油！</p>',
				layout : 'other',
				effect : 'cornerexpand',
				type : 'notice', // notice, warning or error
				onClose : function() {
					setTimeout(function() {
						path.animate( { 'path' : pathConfig.from }, 300, mina.easeinout );
					}, 200 );
				}
			});

			// show the notification
			notification.show();
		}, 800);
	};
})();