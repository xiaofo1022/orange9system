var AjaxUtil = {
	post: function(url, data, callback) {
		$.ajax({  
            url: url,  
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify(data),  
            success: function(data) {
            	callback(data);
            },
            error: function(data) {
            	console.log(data);
            }
		});
	}
};