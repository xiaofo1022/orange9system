package com.xiaofo1022.orange9.response;

public class FailureResponse extends CommonResponse {
  public FailureResponse(String msg) {
    super("failure", msg, "");
  }

  public FailureResponse(String msg, String data) {
    super("failure", msg, data);
  }
}
