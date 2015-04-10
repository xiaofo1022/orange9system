var Validator = function(formId, submitBtnId, rules, url, callback) {
	this.doValidate(formId, submitBtnId, rules, url, callback);
};

Validator.prototype = {
	doValidate:	function(formId, submitBtnId, rules, url, callback) {
		return $("#" + formId).validate({
			rules: rules,
			highlight: function(element) {
				$(element).closest('.form-group').addClass('has-error');
			},
			unhighlight: function(element) {
				$(element).closest('.form-group').removeClass('has-error');
			},
			submitHandler:function(form){
				$("#" + submitBtnId).attr("disabled", true);
		        $.ajax({  
	                url: url,  
	                type: 'post',  
	                data: $("#" + formId).serialize(),  
	                success: function(data) {
	                	$("#" + submitBtnId).attr("disabled", false);
	                	callback(data);
	                },  
	                error: function(data) {
	                	$("#" + submitBtnId).attr("disabled", false);
	                    console.log(data); 
	                }  
	            });
			},
			errorElement: 'p',
			errorPlacement: function(error, element) {
				error.insertAfter(element.parent());
			}
		});
	}
};