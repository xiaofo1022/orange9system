package com.xiaofo1022.orange9.modal;

import com.xiaofo1022.orange9.dao.common.Column;

public class Client {
	@Column("ID")
	private int id;
	@Column("NAME")
	private String clientName;
	@Column("PHONE")
	private String clientPhone;
	@Column("EMAIL")
	private String clientEmail;
	@Column("SHOP_NAME")
	private String clientShopName;
	@Column("SHOP_LINK")
	private String clientShopLink;
	@Column("REMARK")
	private String clientRemark;
	@Column("OWNER_ID")
	private int ownerId;
	@Column("ACCOUNT_ID")
	private int accountId;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public String getClientPhone() {
		return clientPhone;
	}
	public void setClientPhone(String clientPhone) {
		this.clientPhone = clientPhone;
	}
	public String getClientEmail() {
		return clientEmail;
	}
	public void setClientEmail(String clientEmail) {
		this.clientEmail = clientEmail;
	}
	public String getClientShopName() {
		return clientShopName;
	}
	public void setClientShopName(String clientShopName) {
		this.clientShopName = clientShopName;
	}
	public String getClientShopLink() {
		return clientShopLink;
	}
	public void setClientShopLink(String clientShopLink) {
		this.clientShopLink = clientShopLink;
	}
	public String getClientRemark() {
		return clientRemark;
	}
	public void setClientRemark(String clientRemark) {
		this.clientRemark = clientRemark;
	}
	public int getOwnerId() {
		return ownerId;
	}
	public void setOwnerId(int ownerId) {
		this.ownerId = ownerId;
	}
	public int getAccountId() {
		return accountId;
	}
	public void setAccountId(int accountId) {
		this.accountId = accountId;
	}
}
