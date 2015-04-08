var Processer = function(title, bar, titleLabel) {
	this.title = title;
	this.bar = bar;
	this.titleLabel = titleLabel;
};

Processer.prototype = {
	run: function(num, count) {
		var controlTitle = $('#' + this.title).text(this.titleLabel);
		var controlBar = $('#' + this.bar).NumberProgressBar({
		  duration: 6000,
		  max: count,
		  current: num
		});
	}
};