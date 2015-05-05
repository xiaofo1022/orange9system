package com.xiaofo1022.orange9.dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Count;
import com.xiaofo1022.orange9.modal.ClockIn;

@Repository
public class ClockInDao {
	@Autowired
	private CommonDao commonDao;
	
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	public ClockIn clockIn(int userId) {
		Date now = new Date();
		String clockDate = sdf.format(now);
		if (!isClocked(userId, clockDate)) {
			int id = commonDao.insert("INSERT INTO EMPLOYEE_CLOCK_IN (USER_ID, CLOCK_DATE, CLOCK_DATETIME) VALUES (?, ?, ?)", userId, clockDate, now);
			return this.getEmployeeClockIn(id);
		} else {
			return null;
		}
	}
	
	public boolean isClocked(int userId, String clockDate) {
		Count count = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM EMPLOYEE_CLOCK_IN WHERE CLOCK_DATE = ? AND USER_ID = ?", clockDate, userId);
		if (count != null && count.getCnt() > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public ClockIn getEmployeeClockIn(int id) {
		return commonDao.getFirst(ClockIn.class, "SELECT * FROM EMPLOYEE_CLOCK_IN WHERE ID = ?", id);
	}
	
	public List<ClockIn> getMonthClockInList(int userId, String startDate, String endDate) {
		return commonDao.query(ClockIn.class, "SELECT * FROM EMPLOYEE_CLOCK_IN WHERE USER_ID = ? AND CLOCK_DATETIME BETWEEN '" + startDate + " 00:00:00' AND '" + endDate + " 23:59:59' ORDER BY CLOCK_DATETIME", userId);
	}
}
