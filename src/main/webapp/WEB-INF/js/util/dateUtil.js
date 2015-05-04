var DateUtil = {
	getLastDayOfMonth: function(year, month) {
		switch (month) {
			case 2:
				if (this.isLeapYear(year)) {
					return 29;
				} else {
					return 28;
				}
			case 1:
			case 3:
			case 5:
			case 7:
			case 8:
			case 10:
			case 12:
				return 31;
			default:
				return 30;
		}
	},
	isLeapYear: function(year) {  
	    return !!((year & 3) == 0 && (year % 100 || (year % 400 == 0 && year)));  
	},
	weekMap: {
		0: 7,
		1: 1,
		2: 2,
		3: 3,
		4: 4,
		5: 5,
		6: 6
	},
	plusMonth: function(date) {
		var year = date.getFullYear();
		var month = date.getMonth();
		var day = date.getDate();
		month += 1;
		if (month > 11) {
			month = 0;
			year += 1;
		}
		return new Date(year, month, day, 0, 0, 0);
	},
	minusMonth: function(date) {
		var year = date.getFullYear();
		var month = date.getMonth();
		var day = date.getDate();
		month -= 1;
		if (month < 0) {
			month = 11;
			year -= 1;
		}
		return new Date(year, month, day, 0, 0, 0);
	},
	getDateString: function(date) {
		return date.getFullYear() + "-" + date.getMonth() + "-" + date.getDate();
	},
	getDisplayDateString: function(date) {
		return date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
	},
	getDateLabel: function(date) {
		return (date.getMonth() + 1) + "月" + date.getDate() + "日";
	}
};