(function logoStart() {
	var textList = ["凡", "是", "屌", "或", "美", "的", "人", "事", "物", "我", "们", "都", "感", "兴", "趣"];
	var idList = [];
	for (var i = 1; i <= textList.length; i++) {
		idList.push("block" + i);
	}
	var tripperControl = new TripperControl(idList, textList);
	tripperControl.flipTimer(3000);
})();