(function($) {
	$('body').append(
		'<div id="zoom" style="text-align:center;">' +
			'<span id="chosen-label" style="color:white;"></span>' + 
				'<a class="close"></a><a href="#previous" class="previous"></a><a href="#next" class="next"></a>' + 
					'<div class="content loading"></div></div>');

	var zoom = $('#zoom').hide(),
	    zoomContent = $('#zoom .content'),
	    selectButton = '<span id="select-button" class="glyphicon glyphicon-ok picture-button"></span>',
	    selectedButton = '<span id="select-button" class="glyphicon glyphicon-ok picture-button picture-button-selected"></span>',
	    overlay = '<div class="overlay select-picture-overlay" onclick="clientPictureSelected(event)"></div>',
	    zoomedIn = false,
	    openedImage = null,
	    windowWidth = $(window).width(),
	    windowHeight = $(window).height();
		
	function open(event) {
		if (event) {
			event.preventDefault();
		}
		var link = $(this),
		    src = link.attr('href')
		    linkId = link.attr('id');
		if (!src) {
			return;
		}
		var image = $(new Image()).hide();
		$('#zoom .previous, #zoom .next').show();
		if (link.hasClass('zoom')) {
			$('#zoom .previous, #zoom .next').hide();
		}
		if (!zoomedIn) {
			zoomedIn = true;
			zoom.show();
			$('body').addClass('zoomed');
		}
		zoomContent.html(image).delay(500).addClass('loading');
		zoomContent.prepend(overlay);
		if (isPictureSelected(linkId)) {
			zoomContent.prepend(selectedButton);
		} else {
			zoomContent.prepend(selectButton);
		}
		image.load(render).attr('src', src);
		image.attr('id', linkId);
		openedImage = link;
		
		function render() {
			var image = $(this),
			    borderWidth = parseInt(zoomContent.css('borderLeftWidth')),
			    maxImageWidth = windowWidth - (borderWidth * 2) - 80,
			    maxImageHeight = windowHeight - (borderWidth * 2) - 80,
			    imageWidth = image.width(),
			    imageHeight = image.height();
			if (imageWidth == zoomContent.width() && imageWidth <= maxImageWidth && imageHeight == zoomContent.height() && imageHeight <= maxImageHeight) {
					show(image);
					return;
			}
			if (imageWidth > maxImageWidth || imageHeight > maxImageHeight) {
				var desiredHeight = maxImageHeight < imageHeight ? maxImageHeight : imageHeight,
				    desiredWidth  = maxImageWidth  < imageWidth  ? maxImageWidth  : imageWidth;
				if ( desiredHeight / imageHeight <= desiredWidth / imageWidth ) {
					image.width(Math.round(imageWidth * desiredHeight / imageHeight));
					image.height(desiredHeight);
				} else {
					image.width(desiredWidth);
					image.height(Math.round(imageHeight * desiredWidth / imageWidth));
				}
			}
			zoomContent.animate({
				width: image.width(),
				height: image.height(),
				marginTop: -(image.height() / 2) - borderWidth,
				marginLeft: -(image.width() / 2) - borderWidth
			}, 200, function() {
				show(image);
			});

			function show(image) {
				image.show();
				zoomContent.removeClass('loading');
			}
		}
	}
	
	function openPrevious() {
		var prev = openedImage.parent('div').prev();
		if (prev.length == 0 || prev.hasClass("clear")) {
			prev = $('#blink1-block div:last-child').prev();
		}
		prev.find('a').trigger('click');
	}
	
	function openNext() {
		var next = openedImage.parent('div').next();
		if (next.length == 0 || next.hasClass("clear")) {
			next = $('#blink1-block div:first-child');
		}
		next.children('a').trigger('click');
	}
		
	function close(event) {
		if (event) {
			event.preventDefault();
		}
		zoomedIn = false;
		openedImage = null;
		zoom.hide();
		$('body').removeClass('zoomed');
		zoomContent.empty();
	}
	
	function changeImageDimensions() {
		windowWidth = $(window).width();
		windowHeight = $(window).height();
	}
	
	(function bindNavigation() {
		zoom.on('click', function(event) {
			event.preventDefault();
			if ($(event.target).attr('id') == 'zoom') {
				close();
			}
		});
		
		$('#zoom .close').on('click', close);
		$('#zoom .previous').on('click', openPrevious);
		$('#zoom .next').on('click', openNext);
		$(document).keydown(function(event) {
			if (!openedImage) {
				return;
			}
			if (event.which == 38 || event.which == 40) {
				event.preventDefault();
			}
			if (event.which == 27) {
				close();
			}
			if (event.which == 37 && !openedImage.hasClass('zoom')) {
				openPrevious();
			}
			if (event.which == 39 && !openedImage.hasClass('zoom')) {
				openNext();
			}
		});

		if ($('.gallery a').length == 1) {
			$('.gallery a')[0].addClass('zoom');
		}
		$('.zoom, .gallery a').on('click', open);
	})();

	(function bindChangeImageDimensions() {
		$(window).on('resize', changeImageDimensions);
	})();

	(function bindScrollControl() {
		$(window).on('mousewheel DOMMouseScroll', function(event) {
			if (!openedImage) {
				return;
			}
			event.stopPropagation();
			event.preventDefault();
			event.cancelBubble = false;
		});
	})();
})(jQuery);
