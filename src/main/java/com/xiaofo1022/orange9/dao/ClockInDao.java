package com.xiaofo1022.orange9.dao;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Count;
import com.xiaofo1022.orange9.modal.ClockIn;
import com.xiaofo1022.orange9.modal.LeaveRequest;
import com.xiaofo1022.orange9.modal.User;
import com.xiaofo1022.orange9.util.DatetimeUtil;

@Repository
public class ClockInDao {
	@Autowired
	private CommonDao commonDao;
	@Autowired
	private UserDao userDao;
	
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	private static Calendar calendar = Calendar.getInstance();
	
	public void clockIn(int userId) {
		Date now = new Date();
		String clockDate = sdf.format(now);
		int isDelay = 0;
		Date standardClock = DatetimeUtil.getStandardClockDate(now);
		if (now.getTime() - standardClock.getTime() > 0) {
			isDelay = 1;
		}
		if (!isClocked(userId, clockDate)) {
			commonDao.insert("INSERT INTO EMPLOYEE_CLOCK_IN (USER_ID, CLOCK_DATE, CLOCK_DATETIME, IS_DELAY) VALUES (?, ?, ?, ?)", userId, clockDate, now, isDelay);
		}
	}
	
	public void absenceCheck(int bossId) {
		List<User> userList = userDao.getUserList(bossId);
		for (User user : userList) {
			calendar.setTime(new Date());
			calendar.add(Calendar.DATE, -1);
			Date yesterday = calendar.getTime();
			Date entryday = user.getInsertDatetime();
			while (entryday.getTime() < yesterday.getTime()) {
				String entryDayLabel = sdf.format(entryday);
				if (this.isClocked(user.getId(), entryDayLabel)) {
					this.insertAbsence(user.getId(), entryday);
				}
			}
		}
	}
	
	public void insertAbsence(int userId, Date clockDate) {
		commonDao.insert("INSERT INTO EMPLOYEE_CLOCK_IN (USER_ID, CLOCK_DATE, CLOCK_DATETIME, IS_ABSENCE) VALUES (?, ?, ?, ?)",
				userId, sdf.format(clockDate), clockDate, 1);
	}
	
	public void addLeaveRequest(LeaveRequest leaveRequest) {
		calendar.setTime(leaveRequest.getStartDate());
		Date startDate = calendar.getTime();
		calendar.setTime(leaveRequest.getEndDate());
		Date endDate = calendar.getTime();
		while (endDate.getTime() - startDate.getTime() >= 0) {
			String startDateLabel = sdf.format(startDate);
			if (!this.isClocked(leaveRequest.getUserId(), startDateLabel)) {
				this.insertLeaveRequest(leaveRequest.getUserId(), startDate, leaveRequest.getReason());
			} else {
				this.updateToLeaveRequest(leaveRequest.getUserId(), startDate, leaveRequest.getReason());
			}
			calendar.setTime(startDate);
			calendar.add(Calendar.DATE, 1);
			startDate = calendar.getTime();
		}
	}
	
	public void insertLeaveRequest(int userId, Date clockDate, String reason) {
		commonDao.insert("INSERT INTO EMPLOYEE_CLOCK_IN (USER_ID, CLOCK_DATE, CLOCK_DATETIME, REMARK, IS_LEAVE) VALUES (?, ?, ?, ?, ?)",
				userId, sdf.format(clockDate), clockDate, reason, 1);
	}
	
	public void updateToLeaveRequest(int userId, Date clockDate, String reason) {
		commonDao.update("UPDATE EMPLOYEE_CLOCK_IN SET REMARK = ?, IS_LEAVE = ? WHERE CLOCK_DATE = ? AND USER_ID = ?", reason, 1, sdf.format(clockDate), userId);
	}
	
	public boolean isClocked(int userId, String clockDate) {
		Count count = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM EMPLOYEE_CLOCK_IN WHERE CLOCK_DATE = ? AND USER_ID = ?", clockDate, userId);
		if (count != null && count.getCnt() > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public ClockIn getEmployeeClockIn(int userId) {
		return commonDao.getFirst(ClockIn.class, "SELECT * FROM EMPLOYEE_CLOCK_IN WHERE USER_ID = ? ORDER BY ID DESC", userId);
	}
	
	public List<ClockIn> getMonthClockInList(int userId, String startDate, String endDate) {
		return commonDao.query(ClockIn.class, "SELECT * FROM EMPLOYEE_CLOCK_IN WHERE USER_ID = ? AND CLOCK_DATETIME BETWEEN '" + startDate + " 00:00:00' AND '" + endDate + " 23:59:59' ORDER BY CLOCK_DATETIME", userId);
	}
	
	public List<ClockIn> getLeaveClockInList(int isLeave) {
		return commonDao.query(ClockIn.class, "SELECT * FROM EMPLOYEE_CLOCK_IN WHERE REMARK IS NOT NULL AND IS_LEAVE = ? ORDER BY USER_ID", isLeave);
	}
	
	public void addLeaveRequestRecord(LeaveRequest leaveRequest) {
		commonDao.insert("INSERT INTO EMPLOYEE_LEAVE_REQUEST (USER_ID, START_DATE, END_DATE, REASON) VALUES (?, ?, ?, ?)",
				leaveRequest.getUserId(), leaveRequest.getStartDate(), leaveRequest.getEndDate(), leaveRequest.getReason());
	}
	
	public List<LeaveRequest> getUnconfirmLeaveRequestList() {
		return commonDao.query(LeaveRequest.class, "SELECT * FROM EMPLOYEE_LEAVE_REQUEST WHERE IS_CONFIRM = 0 AND REMARK IS NULL ORDER BY USER_ID");
	}
	
	public int getUnconfirmLeaveRequestCount() {
		Count count = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM EMPLOYEE_LEAVE_REQUEST WHERE IS_CONFIRM = 0 AND REMARK IS NULL");
		return count.getCnt();
	}
	
	public void confirmLeaveRequest(int id) {
		commonDao.update("UPDATE EMPLOYEE_LEAVE_REQUEST SET IS_CONFIRM = 1 WHERE ID = ?", id);
	}
	
	public LeaveRequest getLeaveRequest(int id) {
		return commonDao.getFirst(LeaveRequest.class, "SELECT * FROM EMPLOYEE_LEAVE_REQUEST WHERE ID = ?", id);
	}
	
	public void denailLeaveRequest(int id, String remark) {
		commonDao.update("UPDATE EMPLOYEE_LEAVE_REQUEST SET REMARK = ? WHERE ID = ?", remark, id);
	}
}
