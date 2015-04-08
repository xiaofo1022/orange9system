var TripperControl = function(idList, textList) {
	this.tripperList = [];
	this.delay = false;
	for (var i in idList) {
		this.tripperList.push(new Tripper(idList[i], textList[i]));
	}
};

TripperControl.prototype = {
	flipTimer: function(time, ins) {
		if (!ins) {
			ins = this;
		}
		if (ins.delay) {
			for (var i in ins.tripperList) {
				ins.tripperList[i].domouseover();
			}
		}
		ins.delay = true;
		setTimeout(arguments.callee, time, time, ins)
	}
};