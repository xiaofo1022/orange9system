package com.xiaofo1022.orange9.response;

public class SuccessResponse extends CommonResponse {
  public SuccessResponse(String msg) {
    super("success", msg, "");
  }

  public SuccessResponse(String msg, String data) {
    super("success", msg, data);
  }
}
