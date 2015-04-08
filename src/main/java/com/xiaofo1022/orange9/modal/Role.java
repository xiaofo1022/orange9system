package com.xiaofo1022.orange9.modal;

import com.xiaofo1022.orange9.dao.common.Column;

public class Role {
	@Column("ID")
	private int id;
	@Column("NAME")
	private String name;
	@Column("NAME_CN")
	private String nameCN;
	@Column("IS_SHOW")
	private int isShow;
	
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
	public String getNameCN() {
		return nameCN;
	}
	public void setNameCN(String nameCN) {
		this.nameCN = nameCN;
	}
	public int getIsShow() {
		return isShow;
	}
	public void setIsShow(int isShow) {
		this.isShow = isShow;
	}
}
