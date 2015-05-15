package com.xiaofo1022.orange9.modal;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.xiaofo1022.orange9.dao.common.Column;
import com.xiaofo1022.orange9.dao.common.JoinTable;
import com.xiaofo1022.orange9.util.DatetimeUtil;

public class User {
	@Column("ID")
	private int id;
	@Column("NAME")
	private String name;
	@Column("ACCOUNT")
	private String account;
	@Column("PASSWORD")
	private String password;
	@Column("PHONE")
	private String phone;
	@Column("ROLE_ID")
	private int roleId;
	@Column("ACTIVE")
	private int active;
	@Column("IS_ADMIN")
	private int isAdmin;
	@Column("SALARY")
	private double salary;
	@Column("PERFORMANCE_PAY")
	private double performancePay;
	@Column(value="HEADER", isImage=true)
	private String header;
	@Column("BOSS_ID")
	private int bossId;
	@JoinTable(tableName="ROLE", joinField="roleId")
	private Role role;
	private ClockIn clockIn;
	private List<ClockIn> normalClockInList = new ArrayList<ClockIn>();
	private List<ClockIn> delayClockInList = new ArrayList<ClockIn>();
	private List<ClockIn> leaveClockInList = new ArrayList<ClockIn>();
	private int monthPostProduction;
	private int monthDonePostProduction;
	private float performance;
	@SuppressWarnings("unused")
	private int normalCount;
	@SuppressWarnings("unused")
	private int delayCount;
	@SuppressWarnings("unused")
	private int leaveCount;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	public double getSalary() {
		return salary;
	}
	public void setSalary(double salary) {
		this.salary = salary;
	}
	public double getPerformancePay() {
		return performancePay;
	}
	public void setPerformancePay(double performancePay) {
		this.performancePay = performancePay;
	}
	public String getHeader() {
		return header;
	}
	public void setHeader(String header) {
		this.header = header;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getBossId() {
		return bossId;
	}
	public void setBossId(int bossId) {
		this.bossId = bossId;
	}
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	public ClockIn getClockIn() {
		return clockIn;
	}
	public void setClockIn(ClockIn clockIn) {
		this.clockIn = clockIn;
	}
	public void addClockIn(ClockIn clockIn) {
		if (clockIn.getRemark() != null) {
			this.leaveClockInList.add(clockIn);
		} else {
			Date standardClock = DatetimeUtil.getStandardClockDate(clockIn.getClockDatetime());
			if (standardClock.getTime() - clockIn.getClockDatetime().getTime() > 0) {
				this.normalClockInList.add(clockIn);
			} else {
				this.delayClockInList.add(clockIn);
			}
		}
	}
	public List<ClockIn> getNormalClockInList() {
		return normalClockInList;
	}
	public void setNormalClockInList(List<ClockIn> normalClockInList) {
		this.normalClockInList = normalClockInList;
	}
	public List<ClockIn> getDelayClockInList() {
		return delayClockInList;
	}
	public void setDelayClockInList(List<ClockIn> delayClockInList) {
		this.delayClockInList = delayClockInList;
	}
	public List<ClockIn> getLeaveClockInList() {
		return leaveClockInList;
	}
	public void setLeaveClockInList(List<ClockIn> leaveClockInList) {
		this.leaveClockInList = leaveClockInList;
	}
	public int getMonthPostProduction() {
		return monthPostProduction;
	}
	public void setMonthPostProduction(int monthPostProduction) {
		this.monthPostProduction = monthPostProduction;
	}
	public int getMonthDonePostProduction() {
		return monthDonePostProduction;
	}
	public void setMonthDonePostProduction(int monthDonePostProduction) {
		this.monthDonePostProduction = monthDonePostProduction;
	}
	public float getPerformance() {
		return performance;
	}
	public void setPerformance(float performance) {
		this.performance = performance;
	}
	public void addPerformance(int baseCount, int postCount, float push) {
		int overCount = postCount - baseCount;
		if (overCount < 0) {
			overCount = 0;
		}
		this.performance += overCount * push;
	}
	public int getNormalCount() {
		return this.normalClockInList.size();
	}
	public void setNormalCount(int normalCount) {
		this.normalCount = normalCount;
	}
	public int getDelayCount() {
		return this.delayClockInList.size();
	}
	public void setDelayCount(int delayCount) {
		this.delayCount = delayCount;
	}
	public int getLeaveCount() {
		return this.leaveClockInList.size();
	}
	public void setLeaveCount(int leaveCount) {
		this.leaveCount = leaveCount;
	}
	public int getActive() {
		return active;
	}
	public void setActive(int active) {
		this.active = active;
	}
	public int getIsAdmin() {
		return isAdmin;
	}
	public void setIsAdmin(int isAdmin) {
		this.isAdmin = isAdmin;
	}
}
