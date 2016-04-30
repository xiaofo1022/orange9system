package com.xiaofo1022.orange9.response;

public class CommonResponse {
  private String status;
  private String msg;
  private String data;

  public CommonResponse() {
  }

  public CommonResponse(String status, String msg, String data) {
    this.status = status;
    this.msg = msg;
    this.data = data;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public String getMsg() {
    return msg;
  }

  public void setMsg(String msg) {
    this.msg = msg;
  }

  public String getData() {
    return data;
  }

  public void setData(String data) {
    this.data = data;
  }
}
