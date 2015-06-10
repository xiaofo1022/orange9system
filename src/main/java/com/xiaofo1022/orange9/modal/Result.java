package com.xiaofo1022.orange9.modal;

public class Result {
	private boolean result;
	private String message;
	
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
}
