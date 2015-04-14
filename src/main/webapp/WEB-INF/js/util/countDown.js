var CountDown = function(startTime, limitSecond, timeBarId, timeLabelId, remainTimeId) {
	var timeBar = $("#" + timeBarId);
	var timeLabel = $("#" + timeLabelId);
	var remainTime = $("#" + remainTimeId);
	
	caculateTime(startTime, limitSecond, timeBar, timeLabel, remainTime);
	
	function caculateTime(startTime, limitSecond, timeBar, timeLabel, remainTime) {
		var now = new Date();
		var diffSecond = Math.floor((now.getTime() - startTime.getTime()) / 1000);
		var remainSecond = Math.floor(limitSecond - diffSecond);
		var diffTimeLabel = getDiffTime(Math.abs(remainSecond));
		var diffPercent = 0;
		if (remainSecond > 0) {
			diffPercent = (remainSecond / limitSecond).toFixed(2) * 100;
			if (diffPercent < 65) {
				if (!timeBar.hasClass("progress-bar-warning")) {
					timeBar.removeClass("progress-bar-success");
					timeBar.addClass("progress-bar-warning");
				}
			}
			if (diffPercent < 35) {
				if (!timeBar.hasClass("progress-bar-danger")) {
					timeBar.removeClass("progress-bar-success");
					timeBar.removeClass("progress-bar-warning");
					timeBar.addClass("progress-bar-danger");
				}
			}
		} else {
			if (timeLabel.text() == "剩余时间") {
				timeLabel.text("已超时");
				remainTime.css("color", "#D9534F");
			}
		}
		timeBar.css("width", diffPercent + "%");
		remainTime.text(diffTimeLabel);
		setTimeout(arguments.callee, 1000, startTime, limitSecond, timeBar, timeLabel, remainTime);
	}
	
	function getDiffTime(totalSecond) {
		var remainSecond = totalSecond;
		var diffDay = Math.floor(remainSecond / (3600 * 24));
		remainSecond -= diffDay * 3600 * 24;
		var diffHour = Math.floor(remainSecond / 3600);
		remainSecond -= diffHour * 3600;
		var diffMinute = Math.floor(remainSecond / 60);
		remainSecond -= diffMinute * 60;
		var result = "";
		if (diffDay) {
			result += diffDay + "天";
		}
		if (diffHour) {
			result += diffHour + "小时";
		}
		if (diffMinute) {
			result += diffMinute + "分";
		}
		if (remainSecond) {
			result += remainSecond + "秒";
		}
		return result;
	}
};
