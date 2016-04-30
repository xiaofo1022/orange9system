package com.xiaofo1022.orange9.modal;

import com.xiaofo1022.orange9.dao.common.Column;

public class Performance {
  @Column("ID")
  private int id;
  @Column("POST_TYPE")
  private String type;
  @Column("BASE_COUNT")
  private int baseCount;
  @Column("PUSH_PER_IMAGE")
  private float push;

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public int getBaseCount() {
    return baseCount;
  }

  public void setBaseCount(int baseCount) {
    this.baseCount = baseCount;
  }

  public float getPush() {
    return push;
  }

  public void setPush(float push) {
    this.push = push;
  }
}
