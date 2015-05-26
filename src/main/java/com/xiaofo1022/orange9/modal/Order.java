package com.xiaofo1022.orange9.modal;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.xiaofo1022.orange9.dao.common.Column;
import com.xiaofo1022.orange9.dao.common.JoinTable;

public class Order {
	@Column("ID")
	private int id;
	@Column(value="ID", isOrderNo=true)
	private String orderNo;
	@Column("INSERT_DATETIME")
	private Date insertDatetime;
	@Column("UPDATE_DATETIME")
	private Date updateDatetime;
	@Column("SHOOT_DATE")
	private Date shootDate;
	@Column(value="SHOOT_DATE", isFormatDate=true)
	private String shootDateLabel;
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
	private int userId;
	@JoinTable(tableName="ORDER_STATUS", joinField="statusId")
	private OrderStatus orderStatus;
	@JoinTable(tableName="USER", joinField="photographerId")
	private User photographer;
	@JoinTable(tableName="USER", joinField="assistantId")
	private User assistant;
	@JoinTable(tableName="ORDER_SHOOT_GOODS", joinField="goodsId")
	private OrderGoods orderGoods;
	@JoinTable(tableName="CLIENT", joinField="clientId")
	private Client client;
	private List<OrderGoods> orderGoodsList;
	@SuppressWarnings("unused")
	private long shootTime;
	
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
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public OrderStatus getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(OrderStatus orderStatus) {
		this.orderStatus = orderStatus;
	}
	public User getPhotographer() {
		return photographer;
	}
	public void setPhotographer(User photographer) {
		this.photographer = photographer;
	}
	public User getAssistant() {
		return assistant;
	}
	public void setAssistant(User assistant) {
		this.assistant = assistant;
	}
	public OrderGoods getOrderGoods() {
		return orderGoods;
	}
	public void setOrderGoods(OrderGoods orderGoods) {
		this.orderGoods = orderGoods;
	}
	public Client getClient() {
		return client;
	}
	public void setClient(Client client) {
		this.client = client;
	}
	public String getShootDateLabel() {
		return shootDateLabel;
	}
	public void setShootDateLabel(String shootDateLabel) {
		this.shootDateLabel = shootDateLabel;
	}
	public List<OrderGoods> getOrderGoodsList() {
		return orderGoodsList;
	}
	public void setOrderGoodsList(List<OrderGoods> orderGoodsList) {
		this.orderGoodsList = orderGoodsList;
	}
	public long getShootTime() {
		if (this.shootDate != null) {
			Date shootDatetime = new Date(shootDate.getTime());
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(shootDatetime);
			if (this.shootHalf != null) {
				if (this.shootHalf.equals("AM")) {
					calendar.set(Calendar.HOUR_OF_DAY, 9);
				} else {
					calendar.set(Calendar.HOUR_OF_DAY, 14);
				}
			}
			return calendar.getTimeInMillis();
		} else {
			return 0;
		}
	}
	public void setInsertTime(long shootTime) {
		this.shootTime = shootTime;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
}
