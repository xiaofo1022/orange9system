package com.xiaofo1022.orange9.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Count;
import com.xiaofo1022.orange9.modal.OrderTransferImage;
import com.xiaofo1022.orange9.modal.OrderTransferImageData;

@Repository
public class OrderTransferDao {
	@Autowired
	private CommonDao commonDao;
	
	public void insertOrderTransfer(int orderId, int userId) {
		Date now = new Date();
		commonDao.insert("INSERT INTO ORDER_TRANSFER_IMAGE (ORDER_ID, INSERT_DATETIME, UPDATE_DATETIME, OPERATOR_ID) VALUES (?, ?, ?, ?)", 
				orderId, now, now, userId);
	}
	
	public OrderTransferImage getOrderTransfer(int orderId) {
		return commonDao.getFirst(OrderTransferImage.class, "SELECT * FROM ORDER_TRANSFER_IMAGE WHERE ORDER_ID = ?", orderId);
	}
	
	public OrderTransferImage getOrderTransferById(int orderTransferId) {
		return commonDao.getFirst(OrderTransferImage.class, "SELECT * FROM ORDER_TRANSFER_IMAGE WHERE ID = ?", orderTransferId);
	}
	
	public List<OrderTransferImage> getOrderTransferImageList(int ownerId) {
		List<OrderTransferImage> transferList = commonDao.query(OrderTransferImage.class, "SELECT A.* FROM ORDER_TRANSFER_IMAGE A LEFT JOIN ORDERS B ON A.ORDER_ID = B.ID WHERE A.IS_DONE = 0 AND B.OWNER_ID = ? ORDER BY A.INSERT_DATETIME DESC", ownerId);
		if (transferList != null && transferList.size() > 0) {
			for (OrderTransferImage transfer : transferList) {
				Count count = this.getTransferImageDataCount(transfer.getOrderId());
				if (count != null) {
					transfer.setImageDataCount(count.getCnt());
				}
			}
		}
		return transferList;
	}
	
	public List<OrderTransferImageData> getTransferImageDataListByOrder(int orderId) {
		return commonDao.query(OrderTransferImageData.class, "SELECT * FROM ORDER_TRANSFER_IMAGE_DATA WHERE ORDER_ID = ? ORDER BY ID", orderId);
	}
	
	public Count getTransferImageDataCount(int orderId) {
		return commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM ORDER_TRANSFER_IMAGE_DATA WHERE ORDER_ID = ?", orderId);
	}
	
	public List<OrderTransferImageData> getSelectedTransferImageDataList(int orderId) {
		return commonDao.query(OrderTransferImageData.class, "SELECT * FROM ORDER_TRANSFER_IMAGE_DATA WHERE ORDER_ID = ? AND IS_SELECTED = 1 ORDER BY ID", orderId);
	}
	
	public void insertOrderTransferImageData(OrderTransferImageData transferImageData) {
		Date now = new Date();
		int id = commonDao.insert("INSERT INTO ORDER_TRANSFER_IMAGE_DATA (ORDER_TRANSFER_IMAGE_ID, INSERT_DATETIME, UPDATE_DATETIME, ORDER_ID, FILE_NAME) VALUES (?, ?, ?, ?, ?)",
			transferImageData.getOrderTransferImageId(), now, now, transferImageData.getOrderId(), transferImageData.getFileName());
		transferImageData.setId(id);
	}
	
	public void setTransferImageIsDone(int tansferId, int isDone) {
		commonDao.update("UPDATE ORDER_TRANSFER_IMAGE SET IS_DONE = ?, UPDATE_DATETIME = ? WHERE ID = ?", isDone, new Date(), tansferId);
	}
	
	public void setTransferImageSelected(int tansferImgId) {
		commonDao.update("UPDATE ORDER_TRANSFER_IMAGE_DATA SET IS_SELECTED = 1, UPDATE_DATETIME = ? WHERE ID = ?", new Date(), tansferImgId);
	}
	
	public String getTransferImageNames(int orderId) {
		return getConnectImageName(this.getSelectedTransferImageDataList(orderId));
	}
	
	public String getConnectImageName(List<OrderTransferImageData> transferImageDataList) {
		if (transferImageDataList != null && transferImageDataList.size() > 0) {
			StringBuilder builder = new StringBuilder();
			for (int i = 0; i < transferImageDataList.size(); i++) {
				OrderTransferImageData transferImageData = transferImageDataList.get(i);
				String fileName = transferImageData.getFileName();
				builder.append(fileName == null ? "" : fileName);
				if (i < transferImageDataList.size() - 1) {
					builder.append(" OR ");
				}
			}
			return builder.toString();
		}
		return "";
	}
	
	public void setImageDataFixSkin(int imageId, int fixSkinId) {
		commonDao.update("UPDATE ORDER_TRANSFER_IMAGE_DATA SET FIX_SKIN_ID = ?, UPDATE_DATETIME = ? WHERE ID = ?",
			fixSkinId, new Date(), imageId);
	}
}
