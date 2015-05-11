package com.xiaofo1022.orange9.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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
	
	public static int getLastDayOfMonth(int year, int month) {
		switch (month) {
			case 2:
				if (isLeapYear(year)) {
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
	}
	
	public static boolean isLeapYear(int year) {
		return !!((year & 3) == 0 && (year % 100 == 0 || (year % 400 == 0 && year > 0)));
	}
	
	public static Date getStandardClockDate(Date clockDate) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(clockDate);
		calendar.set(Calendar.HOUR_OF_DAY, 8);
		calendar.set(Calendar.MINUTE, 30);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		return calendar.getTime();
	}
	
	public static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	public static String[] getMonthStartAndEndDate(Date date) {
		String[] result = new String[2];
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.set(Calendar.DATE, 1);
		result[0] = dateFormat.format(calendar.getTime());
		calendar.set(Calendar.DATE, getLastDayOfMonth(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH) + 1));
		result[1] = dateFormat.format(calendar.getTime());
		return result;
	}
}
