package com.xiaofo1022.orange9.modal;

public class OrderNo {
	private int orderId;
	private String orderNo;
	
	public OrderNo() {}
	
	public OrderNo(int orderId, String orderNo) {
		this.orderId = orderId;
		this.orderNo = orderNo;
	}
	
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
}
