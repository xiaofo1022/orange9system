package com.xiaofo1022.orange9.modal;

import java.util.Date;

import com.xiaofo1022.orange9.dao.common.Column;

public class Order {
	@Column("ID")
	private int id;
	@Column("INSERT_DATETIME")
	private Date insertDatetime;
	@Column("UPDATE_DATETIME")
	private Date updateDatetime;
	@Column("SHOOT_DATE")
	private Date shootDate;
	@Column("SHOOT_HALF")
	private String shootHalf;
	@Column("CLIENT_ID")
	private int clientId;
	@Column("GOODS_ID")
	private int goodsId;
	@Column("MODEL_NAME")
	private String modelName;
	@Column("DRESSER_NAME")
	private String dresserName;
	@Column("STYLIST_NAME")
	private String stylistName;
	@Column("BROKER_NAME")
	private String brokerName;
	@Column("BROKER_PHONE")
	private String brokerPhone;
	@Column("PHOTOGRAPHER_ID")
	private int photographerId;
	@Column("ASSISTANT_ID")
	private int assistantId;
	@Column("STATUS_ID")
	private int statusId;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getInsertDatetime() {
		return insertDatetime;
	}
	public void setInsertDatetime(Date insertDatetime) {
		this.insertDatetime = insertDatetime;
	}
	public Date getUpdateDatetime() {
		return updateDatetime;
	}
	public void setUpdateDatetime(Date updateDatetime) {
		this.updateDatetime = updateDatetime;
	}
	public Date getShootDate() {
		return shootDate;
	}
	public void setShootDate(Date shootDate) {
		this.shootDate = shootDate;
	}
	public String getShootHalf() {
		return shootHalf;
	}
	public void setShootHalf(String shootHalf) {
		this.shootHalf = shootHalf;
	}
	public int getClientId() {
		return clientId;
	}
	public void setClientId(int clientId) {
		this.clientId = clientId;
	}
	public int getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}
	public String getModelName() {
		return modelName;
	}
	public void setModelName(String modelName) {
		this.modelName = modelName;
	}
	public String getDresserName() {
		return dresserName;
	}
	public void setDresserName(String dresserName) {
		this.dresserName = dresserName;
	}
	public String getStylistName() {
		return stylistName;
	}
	public void setStylistName(String stylistName) {
		this.stylistName = stylistName;
	}
	public String getBrokerName() {
		return brokerName;
	}
	public void setBrokerName(String brokerName) {
		this.brokerName = brokerName;
	}
	public String getBrokerPhone() {
		return brokerPhone;
	}
	public void setBrokerPhone(String brokerPhone) {
		this.brokerPhone = brokerPhone;
	}
	public int getPhotographerId() {
		return photographerId;
	}
	public void setPhotographerId(int photographerId) {
		this.photographerId = photographerId;
	}
	public int getAssistantId() {
		return assistantId;
	}
	public void setAssistantId(int assistantId) {
		this.assistantId = assistantId;
	}
	public int getStatusId() {
		return statusId;
	}
	public void setStatusId(int statusId) {
		this.statusId = statusId;
	}
}
