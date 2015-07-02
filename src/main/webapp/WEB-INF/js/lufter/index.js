function createIndexLink() {
	$(".index-pic-link").mouseover(function(e) {
		var current = $(e.currentTarget);
		current.find("span.index-info-block").css("height", "120px");
	});
	$(".index-pic-link").mouseout(function(e) {
		var current = $(e.currentTarget);
		current.find("span.index-info-block").css("height", "0");
	});
	$(".index-pic-link").click(function(e) {
		var current = $(e.currentTarget);
		var ids = current.attr("id").split("-");
		location.assign("/" + ids[1] + "/" + ids[2]);
	});
}
createIndexLink();