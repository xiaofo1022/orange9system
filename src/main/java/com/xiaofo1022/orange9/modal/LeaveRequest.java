package com.xiaofo1022.orange9.modal;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.xiaofo1022.orange9.dao.common.Column;
import com.xiaofo1022.orange9.dao.common.JoinTable;

public class LeaveRequest {
	@Column("ID")
	private int id;
	@Column("USER_ID")
	private int userId;
	@Column("START_DATE")
	private Date startDate;
	@Column("END_DATE")
	private Date endDate;
	@Column("REASON")
	private String reason;
	@Column("IS_CONFIRM")
	private int isConfirm;
	@Column("REMARK")
	private String remark;
	@SuppressWarnings("unused")
	private String startDateLabel;
	@SuppressWarnings("unused")
	private String endDateLabel;
	@JoinTable(tableName="USER", joinField="userId")
	private User user;
	
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getIsConfirm() {
		return isConfirm;
	}
	public void setIsConfirm(int isConfirm) {
		this.isConfirm = isConfirm;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getStartDateLabel() {
		return sdf.format(startDate);
	}
	public void setStartDateLabel(String startDateLabel) {
		this.startDateLabel = startDateLabel;
	}
	public String getEndDateLabel() {
		return sdf.format(endDate);
	}
	public void setEndDateLabel(String endDateLabel) {
		this.endDateLabel = endDateLabel;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
}
