$(window).load(function() {
	var options =
	{
		thumbBox: '.thumbBox',
		spinner: '.spinner',
		imgSrc: 'images/header/gray_blank.jpg'
	}
	var cropper = $('.imageBox').cropbox(options);
	$('#upload-file').on('change', function(){
		var reader = new FileReader();
		reader.onload = function(e) {
			options.imgSrc = e.target.result;
			cropper = $('.imageBox').cropbox(options);
		}
		reader.readAsDataURL(this.files[0]);
		this.files = [];
	})
	$('#btnCrop').on('click', function(){
		var img = cropper.getDataURL();
		$('.cropped').html('');
		$('.cropped').append('<img src="' + img + '" align="absmiddle" '
			+ 'style="width:64px;margin-top:4px;border-radius:1px;'
			+ 'box-shadow:0px 0px 2px #7E7E7E;" ><p>64px*64px</p>');
		$('.cropped').append('<img id="crop-header" src="' + img + '" align="absmiddle" '
			+ 'style="width:128px;margin-top:4px;border-radius:1px;'
			+ 'box-shadow:0px 0px 2px #7E7E7E;"><p>128px*128px</p>');
		$('.cropped').append('<img src="' + img + '" align="absmiddle" '
			+ 'style="width:180px;margin-top:4px;border-radius:1px;'
			+ 'box-shadow:0px 0px 2px #7E7E7E;"><p>180px*180px</p>');
	})
	$('#btnZoomIn').on('click', function(){
		cropper.zoomIn();
	})
	$('#btnZoomOut').on('click', function(){
		cropper.zoomOut();
	})
});