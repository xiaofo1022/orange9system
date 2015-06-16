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
	@Column("UPDATE_DATETIME")
	private Date updateDatetime;
	private String base64Data;
	@Column("ORDER_ID")
	private int orderId;
	@Column(value="ORDER_ID", isOrderNo=true)
	private String orderNo;
	@Column("FILE_NAME")
	private String fileName;
	@Column("IS_SELECTED")
	private int isSelected;
	@Column("IS_FIXED_SKIN")
	private int isFixedSkin;
	@Column("IS_FIXED_BACKGROUND")
	private int isFixedBackground;
	@Column("IS_CUT_LIQUIFY")
	private int isCutLiquify;
	
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
	public String getBase64Data() {
		return base64Data;
	}
	public void setBase64Data(String base64Data) {
		this.base64Data = base64Data;
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
	public Date getUpdateDatetime() {
		return updateDatetime;
	}
	public void setUpdateDatetime(Date updateDatetime) {
		this.updateDatetime = updateDatetime;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public int getIsFixedSkin() {
		return isFixedSkin;
	}
	public void setIsFixedSkin(int isFixedSkin) {
		this.isFixedSkin = isFixedSkin;
	}
	public int getIsFixedBackground() {
		return isFixedBackground;
	}
	public void setIsFixedBackground(int isFixedBackground) {
		this.isFixedBackground = isFixedBackground;
	}
	public int getIsCutLiquify() {
		return isCutLiquify;
	}
	public void setIsCutLiquify(int isCutLiquify) {
		this.isCutLiquify = isCutLiquify;
	}
}
