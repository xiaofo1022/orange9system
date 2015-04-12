var Validator = function(formId, submitBtnId, rules, url, callback) {
	this.formId = formId;
	this.submitBtnId = submitBtnId;
	this.rules = rules;
	this.url = url;
	this.callback = callback;
	this.validate = this.doValidate(formId, submitBtnId, rules, url, callback);
};

Validator.prototype = {
	doValidate:	function(formId, submitBtnId, rules, url, callback) {
		var ins = this;
		return $("#" + formId).validate({
			rules: rules,
			highlight: function(element) {
				$(element).closest('.form-group').addClass('has-error');
			},
			unhighlight: function(element) {
				$(element).closest('.form-group').removeClass('has-error');
			},
			submitHandler:function(form) {
				ins.submitForm();
			},
			errorElement: 'p',
			errorPlacement: function(error, element) {
				error.insertAfter(element);
			}
		});
	},
	submitForm: function() {
		var ins = this;
		$("#" + this.submitBtnId).attr("disabled", true);
        $.ajax({  
            url: this.url,  
            type: 'post',  
            data: $("#" + this.formId).serialize(),  
            success: function(data) {
            	$("#" + ins.submitBtnId).attr("disabled", false);
            	ins.callback(data);
            },  
            error: function(data) {
            	$("#" + ins.submitBtnId).attr("disabled", false);
                console.log(data);
            }  
        });
	}
};