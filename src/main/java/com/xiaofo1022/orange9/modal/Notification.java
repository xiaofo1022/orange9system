package com.xiaofo1022.orange9.modal;

import java.util.Date;

import com.xiaofo1022.orange9.dao.common.Column;
import com.xiaofo1022.orange9.dao.common.JoinTable;

public class Notification {
  @Column("ID")
  private int id;
  @Column("INSERT_DATETIME")
  private Date insertDatetime;
  @Column("UPDATE_DATETIME")
  private Date updateDatetime;
  @Column("SENDER_ID")
  private int senderId;
  @Column("RECEIVER_ID")
  private int receiverId;
  @Column("MESSAGE")
  private String message;
  @Column("IS_READ")
  private int isRead;
  @JoinTable(tableName = "USER", joinField = "senderId")
  private User sender;

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

  public int getSenderId() {
    return senderId;
  }

  public void setSenderId(int senderId) {
    this.senderId = senderId;
  }

  public int getReceiverId() {
    return receiverId;
  }

  public void setReceiverId(int receiverId) {
    this.receiverId = receiverId;
  }

  public String getMessage() {
    return message;
  }

  public void setMessage(String message) {
    this.message = message;
  }

  public int getIsRead() {
    return isRead;
  }

  public void setIsRead(int isRead) {
    this.isRead = isRead;
  }

  public User getSender() {
    return sender;
  }

  public void setSender(User sender) {
    this.sender = sender;
  }
}
