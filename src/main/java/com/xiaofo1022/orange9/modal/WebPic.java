package com.xiaofo1022.orange9.modal;

import java.util.Date;

import com.xiaofo1022.orange9.dao.common.Column;

public class WebPic {

  @Column("ID")
  private int id;
  @Column("INSERT_DATETIME")
  private Date insertDatetime;
  @Column("UPDATE_DATETIME")
  private Date updateDatetime;
  @Column("PIC_KEY")
  private String picKey;
  @Column("PIC_TYPE")
  private String picType;
  @Column("PIC_INDEX")
  private int picIndex;
  @Column("IS_FOLDER")
  private int isFolder;
  @Column("IS_ACTIVE")
  private int isActive;
  private String picUrl;
  
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
  public String getPicKey() {
    return picKey;
  }
  public void setPicKey(String picKey) {
    this.picKey = picKey;
  }
  public String getPicType() {
    return picType;
  }
  public void setPicType(String picType) {
    this.picType = picType;
  }
  public int getPicIndex() {
    return picIndex;
  }
  public void setPicIndex(int picIndex) {
    this.picIndex = picIndex;
  }
  public int getIsFolder() {
    return isFolder;
  }
  public void setIsFolder(int isFolder) {
    this.isFolder = isFolder;
  }
  public int getIsActive() {
    return isActive;
  }
  public void setIsActive(int isActive) {
    this.isActive = isActive;
  }
  public String getPicUrl() {
    return picUrl;
  }
  public void setPicUrl(String picUrl) {
    this.picUrl = picUrl;
  }
}
