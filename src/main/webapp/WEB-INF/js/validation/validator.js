var Validator = function() {};

Validator.prototype = {
	doValidate:	function(formId, rules) {
		return $("#" + formId).validate({
			rules: rules,
			highlight: function(element) {
				$(element).closest('.form-group').addClass('has-error');
			},
			unhighlight: function(element) {
				$(element).closest('.form-group').removeClass('has-error');
			},
			submitHandler:function(form){
			},
			errorElement: 'span',
			errorPlacement: function(error, element) {
				error.insertAfter(element.parent());
			}
		});
	}
};