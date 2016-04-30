package com.xiaofo1022.orange9.modal;

public class Result {
  private boolean result;
  private String message;
  private String fileNames;
  private int unuploadCount;

  public Result() {
  }

  public Result(boolean result, String message) {
    this.result = result;
    this.message = message;
  }

  public boolean getResult() {
    return result;
  }

  public void setResult(boolean result) {
    this.result = result;
  }

  public String getMessage() {
    return message;
  }

  public void setMessage(String message) {
    this.message = message;
  }

  public String getFileNames() {
    return fileNames;
  }

  public void setFileNames(String fileNames) {
    this.fileNames = fileNames;
  }

  public int getUnuploadCount() {
    return unuploadCount;
  }

  public void setUnuploadCount(int unuploadCount) {
    this.unuploadCount = unuploadCount;
  }
}
