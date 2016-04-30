package com.xiaofo1022.orange9.modal;

import java.util.Date;

import com.xiaofo1022.orange9.dao.common.Column;

public class ClientMessage {
  @Column("ID")
  private int id;
  @Column("INSERT_DATETIME")
  private Date insertDatetime;
  @Column(value = "INSERT_DATETIME", isFormatDatetime = true)
  private String insertDatetimeLabel;
  @Column("UPDATE_DATETIME")
  private Date updateDatetime;
  @Column("CLIENT_ID")
  private int clientId;
  @Column("ORDER_ID")
  private int orderId;
  @Column("MESSAGE")
  private String message;
  @Column("REPLY")
  private String reply;

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

  public String getInsertDatetimeLabel() {
    return insertDatetimeLabel;
  }

  public void setInsertDatetimeLabel(String insertDatetimeLabel) {
    this.insertDatetimeLabel = insertDatetimeLabel;
  }

  public Date getUpdateDatetime() {
    return updateDatetime;
  }

  public void setUpdateDatetime(Date updateDatetime) {
    this.updateDatetime = updateDatetime;
  }

  public int getClientId() {
    return clientId;
  }

  public void setClientId(int clientId) {
    this.clientId = clientId;
  }

  public int getOrderId() {
    return orderId;
  }

  public void setOrderId(int orderId) {
    this.orderId = orderId;
  }

  public String getMessage() {
    return message;
  }

  public void setMessage(String message) {
    this.message = message;
  }

  public String getReply() {
    return reply;
  }

  public void setReply(String reply) {
    this.reply = reply;
  }
}
