package com.xiaofo1022.orange9.modal;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.xiaofo1022.orange9.dao.common.Column;

public class ClockIn {
	@Column("ID")
	private int id;
	@Column("USER_ID")
	private int userId;
	@Column("CLOCK_DATE")
	private String clockDate;
	@Column("CLOCK_DATETIME")
	private Date clockDatetime;
	@SuppressWarnings("unused")
	private String clockDatetimeLabel;
	@Column("REMARK")
	private String remark;
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
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
	public String getClockDate() {
		return clockDate;
	}
	public void setClockDate(String clockDate) {
		this.clockDate = clockDate;
	}
	public Date getClockDatetime() {
		return clockDatetime;
	}
	public void setClockDatetime(Date clockDatetime) {
		this.clockDatetime = clockDatetime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getClockDatetimeLabel() {
		if (this.clockDatetime != null) {
			return sdf.format(this.clockDatetime);
		} else {
			return "";
		}
	}
	public void setClockDatetimeLabel(String clockDatetimeLabel) {
		this.clockDatetimeLabel = clockDatetimeLabel;
	}
}
