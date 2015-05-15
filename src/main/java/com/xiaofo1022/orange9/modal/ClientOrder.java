package com.xiaofo1022.orange9.modal;

import java.util.List;

public class ClientOrder {
	private int orderId;
	private int clientId;
	private String shootDateLabel;
	private String shootHalf;
	private List<OrderTransferImageData> orderTransferImageDataList;
	private List<OrderFixedImageData> orderFixedImageDataList;
	private boolean first = false;
	private int goodsCount;
	private String status;
	
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getShootDateLabel() {
		return shootDateLabel;
	}
	public void setShootDateLabel(String shootDateLabel) {
		this.shootDateLabel = shootDateLabel;
	}
	public String getShootHalf() {
		return shootHalf;
	}
	public void setShootHalf(String shootHalf) {
		if (shootHalf.equals("AM")) {
			this.shootHalf = "上午";
		} else {
			this.shootHalf = "下午";
		}
	}
	public List<OrderTransferImageData> getOrderTransferImageDataList() {
		return orderTransferImageDataList;
	}
	public void setOrderTransferImageDataList(List<OrderTransferImageData> orderTransferImageDataList) {
		this.orderTransferImageDataList = orderTransferImageDataList;
	}
	public List<OrderFixedImageData> getOrderFixedImageDataList() {
		return orderFixedImageDataList;
	}
	public void setOrderFixedImageDataList(List<OrderFixedImageData> orderFixedImageDataList) {
		this.orderFixedImageDataList = orderFixedImageDataList;
	}
	public boolean getFirst() {
		return first;
	}
	public void setFirst(boolean first) {
		this.first = first;
	}
	public int getGoodsCount() {
		return goodsCount;
	}
	public void setGoodsCount(int goodsCount) {
		this.goodsCount = goodsCount;
	}
	public int getClientId() {
		return clientId;
	}
	public void setClientId(int clientId) {
		this.clientId = clientId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
