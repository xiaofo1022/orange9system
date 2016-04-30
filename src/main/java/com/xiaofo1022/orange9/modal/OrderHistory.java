package com.xiaofo1022.orange9.modal;

import java.util.Date;

import com.xiaofo1022.orange9.dao.common.Column;
import com.xiaofo1022.orange9.dao.common.JoinTable;

public class OrderHistory {
  @Column("ID")
  private int id;
  @Column("INSERT_DATETIME")
  private Date insertDatetime;
  @Column(value = "INSERT_DATETIME", isFormatDatetime = true)
  private String insertDatetimeLabel;
  @Column("UPDATE_DATETIME")
  private Date updateDatetime;
  @Column("ORDER_ID")
  private int orderId;
  @Column("OPERATOR_ID")
  private int operatorId;
  @Column("INFO")
  private String info;
  @Column("REMARK")
  private String remark;
  @JoinTable(tableName = "USER", joinField = "operatorId")
  private User user;

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

  public int getOrderId() {
    return orderId;
  }

  public void setOrderId(int orderId) {
    this.orderId = orderId;
  }

  public int getOperatorId() {
    return operatorId;
  }

  public void setOperatorId(int operatorId) {
    this.operatorId = operatorId;
  }

  public String getInfo() {
    return info;
  }

  public void setInfo(String info) {
    this.info = info;
  }

  public String getRemark() {
    return remark;
  }

  public void setRemark(String remark) {
    this.remark = remark;
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

  public String getInsertDatetimeLabel() {
    return insertDatetimeLabel;
  }

  public void setInsertDatetimeLabel(String insertDatetimeLabel) {
    this.insertDatetimeLabel = insertDatetimeLabel;
  }
}
