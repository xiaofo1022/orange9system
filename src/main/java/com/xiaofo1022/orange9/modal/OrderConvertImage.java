package com.xiaofo1022.orange9.modal;

import java.util.Date;

import com.xiaofo1022.orange9.dao.common.Column;
import com.xiaofo1022.orange9.dao.common.JoinTable;

public class OrderConvertImage {
  @Column("ID")
  private int id;
  @Column("ORDER_ID")
  private int orderId;
  @Column(value = "ORDER_ID", isOrderNo = true)
  private String orderNo;
  @Column("INSERT_DATETIME")
  private Date insertDatetime;
  @Column("UPDATE_DATETIME")
  private Date updateDatetime;
  @Column("OPERATOR_ID")
  private int operatorId;
  @Column("IS_DONE")
  private int isDone;
  @JoinTable(tableName = "USER", joinField = "operatorId")
  private User operator;
  @SuppressWarnings("unused")
  private long insertTime;
  private String fileNames;

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public int getOrderId() {
    return orderId;
  }

  public void setOrderId(int orderId) {
    this.orderId = orderId;
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

  public int getOperatorId() {
    return operatorId;
  }

  public void setOperatorId(int operatorId) {
    this.operatorId = operatorId;
  }

  public int getIsDone() {
    return isDone;
  }

  public void setIsDone(int isDone) {
    this.isDone = isDone;
  }

  public User getOperator() {
    return operator;
  }

  public void setOperator(User operator) {
    this.operator = operator;
  }

  public long getInsertTime() {
    if (this.insertDatetime != null) {
      return this.insertDatetime.getTime();
    } else {
      return 0;
    }
  }

  public void setInsertTime(long insertTime) {
    this.insertTime = insertTime;
  }

  public String getFileNames() {
    return fileNames;
  }

  public void setFileNames(String fileNames) {
    this.fileNames = fileNames;
  }

  public String getOrderNo() {
    return orderNo;
  }

  public void setOrderNo(String orderNo) {
    this.orderNo = orderNo;
  }
}
