package com.xiaofo1022.orange9.modal;

import com.xiaofo1022.orange9.dao.common.Column;

public class OrderTimeLimit {
  @Column("ID")
  private int id;
  @Column("NAME")
  private String name;
  @Column("LIMIT_MINUTES")
  private int limitMinutes;

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

  public int getLimitMinutes() {
    return limitMinutes;
  }

  public void setLimitMinutes(int limitMinutes) {
    this.limitMinutes = limitMinutes;
  }
}
