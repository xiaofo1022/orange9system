package com.xiaofo1022.orange9.modal;

import java.util.Date;

import com.xiaofo1022.orange9.dao.common.Column;

public class OrderTransferImageData {
	@Column("ID")
	private int id;
	@Column("ORDER_TRANSFER_IMAGE_ID")
	private int orderTransferImageId;
	@Column("INSERT_DATETIME")
	private Date insertDatetime;
	private String imageData;
	@Column("ORDER_ID")
	private int orderId;
	@Column("FILE_NAME")
	private String fileName;
	@Column("IS_SELECTED")
	private int isSelected;
	
	private String serverPath;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getOrderTransferImageId() {
		return orderTransferImageId;
	}
	public void setOrderTransferImageId(int orderTransferImageId) {
		this.orderTransferImageId = orderTransferImageId;
	}
	public Date getInsertDatetime() {
		return insertDatetime;
	}
	public void setInsertDatetime(Date insertDatetime) {
		this.insertDatetime = insertDatetime;
	}
	public String getImageData() {
		return imageData;
	}
	public void setImageData(String imageData) {
		this.imageData = imageData;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getServerPath() {
		return serverPath;
	}
	public void setServerPath(String serverPath) {
		this.serverPath = serverPath;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public int getIsSelected() {
		return isSelected;
	}
	public void setIsSelected(int isSelected) {
		this.isSelected = isSelected;
	}
}
