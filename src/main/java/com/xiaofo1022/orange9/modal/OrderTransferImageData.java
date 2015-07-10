package com.xiaofo1022.orange9.modal;

import java.util.Date;

import com.xiaofo1022.orange9.dao.common.Column;

public class OrderTransferImageData {
	@Column("ID")
	private int id;
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
	@Column("FIX_SKIN_OPERATOR_ID")
	private int fixSkinOperatorId;
	@Column("FIX_BACKGROUND_OPERATOR_ID")
	private int fixBackgroundOperatorId;
	@Column("CUT_LIQUIFY_OPERATOR_ID")
	private int cutLiquifyOperatorId;
	@Column("OPERATOR_ID")
	private int operatorId;
	private String serverPath;
	private int index;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public int getFixSkinOperatorId() {
		return fixSkinOperatorId;
	}
	public void setFixSkinOperatorId(int fixSkinOperatorId) {
		this.fixSkinOperatorId = fixSkinOperatorId;
	}
	public int getFixBackgroundOperatorId() {
		return fixBackgroundOperatorId;
	}
	public void setFixBackgroundOperatorId(int fixBackgroundOperatorId) {
		this.fixBackgroundOperatorId = fixBackgroundOperatorId;
	}
	public int getCutLiquifyOperatorId() {
		return cutLiquifyOperatorId;
	}
	public void setCutLiquifyOperatorId(int cutLiquifyOperatorId) {
		this.cutLiquifyOperatorId = cutLiquifyOperatorId;
	}
	public int getOperatorId() {
		return operatorId;
	}
	public void setOperatorId(int operatorId) {
		this.operatorId = operatorId;
	}
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
}
