package com.xiaofo1022.orange9.modal;

import java.util.Date;

import com.xiaofo1022.orange9.dao.common.Column;

public class OrderGoods {
  @Column("ID")
  private int id;
  @Column("ORDER_ID")
  private int orderId;
  @Column(value = "ORDER_ID", isOrderNo = true)
  private String orderNo;
  @Column("INSERT_DATETIME")
  private Date insertDatetime;
  @Column(value = "INSERT_DATETIME", isFormatDate = true)
  private String insertDatetimeLabel;
  @Column("UPDATE_DATETIME")
  private Date updateDatetime;
  @Column("RECEIVE_EXPRESS_NO")
  private String receiveExpressNo;
  @Column("RECEIVE_EXPRESS_COMPANY")
  private String receiveExpressCompany;
  @Column("DELIVER_EXPRESS_NO")
  private String deliverExpressNo;
  @Column("DELIVER_EXPRESS_COMPANY")
  private String deliverExpressCompany;
  @Column("COAT_COUNT")
  private int coatCount;
  @Column("PANTS_COUNT")
  private int pantsCount;
  @Column("JUMPSUITS_COUNT")
  private int jumpsuitsCount;
  @Column("SHOES_COUNT")
  private int shoesCount;
  @Column("BAG_COUNT")
  private int bagCount;
  @Column("HAT_COUNT")
  private int hatCount;
  @Column("OTHER_COUNT")
  private int otherCount;
  @SuppressWarnings("unused")
  private int allCount;
  @Column("REMARK")
  private String remark;
  private String expressNo;
  private String expressCompany;
  private int goodsMethod;

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

  public String getReceiveExpressNo() {
    return receiveExpressNo;
  }

  public void setReceiveExpressNo(String receiveExpressNo) {
    this.receiveExpressNo = receiveExpressNo;
  }

  public String getReceiveExpressCompany() {
    return receiveExpressCompany;
  }

  public void setReceiveExpressCompany(String receiveExpressCompany) {
    this.receiveExpressCompany = receiveExpressCompany;
  }

  public String getDeliverExpressNo() {
    return deliverExpressNo;
  }

  public void setDeliverExpressNo(String deliverExpressNo) {
    this.deliverExpressNo = deliverExpressNo;
  }

  public String getDeliverExpressCompany() {
    return deliverExpressCompany;
  }

  public void setDeliverExpressCompany(String deliverExpressCompany) {
    this.deliverExpressCompany = deliverExpressCompany;
  }

  public int getCoatCount() {
    return coatCount;
  }

  public void setCoatCount(int coatCount) {
    this.coatCount = coatCount;
  }

  public int getPantsCount() {
    return pantsCount;
  }

  public void setPantsCount(int pantsCount) {
    this.pantsCount = pantsCount;
  }

  public int getJumpsuitsCount() {
    return jumpsuitsCount;
  }

  public void setJumpsuitsCount(int jumpsuitsCount) {
    this.jumpsuitsCount = jumpsuitsCount;
  }

  public int getShoesCount() {
    return shoesCount;
  }

  public void setShoesCount(int shoesCount) {
    this.shoesCount = shoesCount;
  }

  public int getBagCount() {
    return bagCount;
  }

  public void setBagCount(int bagCount) {
    this.bagCount = bagCount;
  }

  public int getHatCount() {
    return hatCount;
  }

  public void setHatCount(int hatCount) {
    this.hatCount = hatCount;
  }

  public int getOtherCount() {
    return otherCount;
  }

  public void setOtherCount(int otherCount) {
    this.otherCount = otherCount;
  }

  public String getRemark() {
    return remark;
  }

  public void setRemark(String remark) {
    this.remark = remark;
  }

  public String getExpressNo() {
    return expressNo;
  }

  public void setExpressNo(String expressNo) {
    this.expressNo = expressNo;
  }

  public String getExpressCompany() {
    return expressCompany;
  }

  public void setExpressCompany(String expressCompany) {
    this.expressCompany = expressCompany;
  }

  public String getInsertDatetimeLabel() {
    return insertDatetimeLabel;
  }

  public void setInsertDatetimeLabel(String insertDatetimeLabel) {
    this.insertDatetimeLabel = insertDatetimeLabel;
  }

  public int getAllCount() {
    return this.coatCount + this.pantsCount + this.jumpsuitsCount + this.hatCount + this.bagCount + this.shoesCount + this.otherCount;
  }

  public void setAllCount(int allCount) {
    this.allCount = allCount;
  }

  public String getOrderNo() {
    return orderNo;
  }

  public void setOrderNo(String orderNo) {
    this.orderNo = orderNo;
  }

  public int getGoodsMethod() {
    return goodsMethod;
  }

  public void setGoodsMethod(int goodsMethod) {
    this.goodsMethod = goodsMethod;
  }
}
