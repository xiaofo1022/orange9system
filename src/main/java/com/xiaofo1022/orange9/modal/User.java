package com.xiaofo1022.orange9.modal;

import com.xiaofo1022.orange9.dao.common.Column;
import com.xiaofo1022.orange9.dao.common.JoinTable;

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
}
