var Validator = function(formId, rules, url, callback) {
	this.doValidate(formId, rules, url, callback);
};

Validator.prototype = {
	doValidate:	function(formId, rules, url, callback) {
		return $("#" + formId).validate({
			rules: rules,
			highlight: function(element) {
				$(element).closest('.form-group').addClass('has-error');
			},
			unhighlight: function(element) {
				$(element).closest('.form-group').removeClass('has-error');
			},
			submitHandler:function(form){
				console.log("submit");
				var headerFile = document.getElementById("i-upload-header").files[0];
				var reader = new FileReader();
			    reader.readAsDataURL(headerFile);
			    reader.onload = function(evt) {
			    	var value = evt.target.result;
			    	value = value.split(",")[1];
			        document.getElementById("header").value = value;
			        $.ajax({  
		                url: url,  
		                type: 'post',  
		                data: $("#" + formId).serialize(),  
		                success: function(data) {  
		                	callback(data);
		                },  
		                error: function(data) {  
		                    console.log(data); 
		                }  
		            });
			    }
			},
			errorElement: 'p',
			errorPlacement: function(error, element) {
				error.insertAfter(element.parent());
			}
		});
	}
};