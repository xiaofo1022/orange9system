var Base64 = function(inputId, imageHiddenId) {
	if (inputId && imageHiddenId) {
		var fileInput = document.getElementById(inputId);
		var imageHidden = document.getElementById(imageHiddenId);
		var complete = false;
		var base64Data = false;
		var reader = new FileReader();
		reader.onload = function(event) {
			base64Data = event.target.result.split(",")[1];
			imageHidden.value = base64Data;
			complete = true;
		};
		fileInput.onchange = function(event) {
			var img = event.target.files[0];
			if (!img) {
				return;
			}
			if (!(img.type && img.type.indexOf('image') == 0 && /\.(?:jpg|png|gif)$/.test(img.name))) {
				alert("上传的图片只能是jpg，png或者gif格式。");
				return;
			}
			if (img.size > 1024 * 1024 * 1024) {
				alert("上传的图片不能大于10MB。");
				return;
			}
			complete = false;
			imageHidden.value = "";
			reader.readAsDataURL(img);
		};
	}
};

Base64.prototype = {
	getJpgHeader: function() {
		return "data:image/jpeg;base64,";
	}
}