package com.xiaofo1022.orange9.util;

import java.util.Date;

public class DatetimeUtil {
	public static String getDatetimeDiff(Date startTime, Date endTime) {
		long diffTime = endTime.getTime() - startTime.getTime();
		long day = diffTime / (24 * 60 * 60 * 1000);
		long hour = (diffTime / (60 * 60 * 1000) - day * 24);
		long min = ((diffTime / (60 * 1000)) - day * 24 * 60 - hour * 60);
		long second = (diffTime / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60);
		String result = "";
		if (day > 0) {
			result += (day + "天");
		}
		if (hour > 0) {
			result += (hour + "小時");
		}
		if (min > 0) {
			result += (min + "分");
		}
		if (second > 0) {
			result += (second + "秒");
		}
		return result;
	}
}
