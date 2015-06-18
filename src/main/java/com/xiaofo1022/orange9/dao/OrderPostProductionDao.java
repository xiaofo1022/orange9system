package com.xiaofo1022.orange9.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.common.OrderConst;
import com.xiaofo1022.orange9.common.OrderStatusConst;
import com.xiaofo1022.orange9.common.RoleConst;
import com.xiaofo1022.orange9.common.TimeLimitConst;
import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Count;
import com.xiaofo1022.orange9.modal.OrderFixedImageData;
import com.xiaofo1022.orange9.modal.OrderPostProduction;
import com.xiaofo1022.orange9.modal.OrderTimeLimit;
import com.xiaofo1022.orange9.modal.OrderTransferImageData;
import com.xiaofo1022.orange9.modal.User;
import com.xiaofo1022.orange9.util.DatetimeUtil;

@Repository
public class OrderPostProductionDao {
	@Autowired
	private CommonDao commonDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private OrderTransferDao orderTransferDao;
	@Autowired
	private OrderTimeLimitDao orderTimeLimitDao;
	
	public void allotImage(int orderId, int bossId) {
		int idleUserId = this.getIdleUserId(bossId);
		this.insertPostProductionRecord(OrderConst.TABLE_ORDER_FIX_BACKGROUND, orderId, idleUserId);
	}
	
	public int insertPostProductionRecord(String tableName, int orderId, int userId) {
		Date now = new Date();
		return commonDao.insert("INSERT INTO " + tableName + " (ORDER_ID, INSERT_DATETIME, UPDATE_DATETIME, OPERATOR_ID) VALUES (?, ?, ?, ?)",
				orderId, now, now, userId);
	}
	
	public int getOrderPostProductionCount(String tableName, int ownerId) {
		Count count = commonDao.getFirst(Count.class, "SELECT COUNT(A.ID) AS CNT FROM " + tableName + " A LEFT JOIN ORDERS B ON A.ORDER_ID = B.ID WHERE A.IS_DONE = 0 AND B.OWNER_ID = ?", ownerId);
		if (count != null) {
			return count.getCnt();
		} else {
			return 0;
		}
	}
	
	public List<OrderPostProduction> getPostProductionList(String tableName, String columnName, int ownerId) {
		List<OrderPostProduction> postProductionList = this.getPostProductionShowList(tableName, ownerId);
		if (postProductionList != null && postProductionList.size() > 0) {
			Date now = new Date();
			for (OrderPostProduction postProduction : postProductionList) {
				List<OrderTransferImageData> imageDataList = this.getImageDataList(columnName, postProduction.getOrderId());
				String fileNames = orderTransferDao.getConnectImageName(imageDataList);
				OrderTimeLimit timeLimit = orderTimeLimitDao.getTimeLimit(TimeLimitConst.getIdByTable(tableName));
				postProduction.setImageCount(imageDataList.size());
				postProduction.setTimeCost(DatetimeUtil.getDatetimeDiff(postProduction.getInsertDatetime(), now));
				postProduction.setLimitMinutes(timeLimit.getLimitMinutes() * postProduction.getImageCount());
				postProduction.setFileNames(fileNames);
				postProduction.setImageDataList(imageDataList);
			}
		}
		return postProductionList;
	}
	
	public List<OrderTransferImageData> getImageDataList(String columnName, int orderId) {
		return commonDao.query(OrderTransferImageData.class, "SELECT * FROM ORDER_TRANSFER_IMAGE_DATA WHERE ORDER_ID = ? AND IS_SELECTED = 1", orderId);
	}
	
	public OrderPostProduction getPostProductionByOrder(String tableName, int orderId) {
		return commonDao.getFirst(OrderPostProduction.class, "SELECT * FROM " + tableName + " WHERE ORDER_ID = ?", orderId);
	}
	
	public List<OrderPostProduction> getPostProductionShowList(String tableName, int ownerId) {
		String sql = "SELECT A.* FROM " + tableName + " A LEFT JOIN ORDERS B ON A.ORDER_ID = B.ID WHERE B.OWNER_ID = ? AND A.IS_DONE = 0";
		return commonDao.query(OrderPostProduction.class, sql, ownerId);
	}
	
	public void setFixPostImageDone(String columnName, int orderId) {
		commonDao.update("UPDATE ORDER_TRANSFER_IMAGE_DATA SET " + columnName + " = 1 WHERE ORDER_ID = ?", orderId);
	}
	
	public void setFixPostImageDone(String columnName, int orderId, String imageName) {
		commonDao.update("UPDATE ORDER_TRANSFER_IMAGE_DATA SET " + columnName + " = 1 WHERE ORDER_ID = ? AND FILE_NAME = ?", orderId, imageName);
	}
	
	public int getUserAllPostCount(int userId) {
		Count fixSkinCount = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM ORDER_IMAGE_FIX_SKIN WHERE OPERATOR_ID = ? AND IS_DONE = 0", userId);
		Count fixBackgroundCount = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM ORDER_IMAGE_FIX_BACKGROUND WHERE OPERATOR_ID = ? AND IS_DONE = 0", userId);
		Count cutLiquifyCount = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM ORDER_IMAGE_CUT_LIQUIFY WHERE OPERATOR_ID = ? AND IS_DONE = 0", userId);
		return fixSkinCount.getCnt() + fixBackgroundCount.getCnt() + cutLiquifyCount.getCnt();
	}
	
	public int getUserPostCount(String tableName, int userId) {
		Count count = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM " + tableName + " WHERE OPERATOR_ID = ?", userId);
		return count.getCnt();
	}
	
	public int getUserPostCount(int userId) {
		Count fixSkinCount = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM " + OrderConst.TABLE_ORDER_FIX_SKIN + " WHERE OPERATOR_ID = ?", userId);
		Count fixBcCount = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM " + OrderConst.TABLE_ORDER_FIX_BACKGROUND + " WHERE OPERATOR_ID = ?", userId);
		Count cutCount = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM " + OrderConst.TABLE_ORDER_CUT_LIQUIFY + " WHERE OPERATOR_ID = ?", userId);
		return fixSkinCount.getCnt() + fixBcCount.getCnt() + cutCount.getCnt();
	}
	
	public int getIdleUserId(int bossId) {
		List<User> designerList = userDao.getUserListByRoleId(RoleConst.DESIGNER_ID, bossId);
		int minUserId = 0;
		if (designerList != null && designerList.size() > 0) {
			int minCount = -1;
			for (int i = 0; i < designerList.size(); i++) {
				User designer = designerList.get(i);
				int count = this.getUserPostCount(designer.getId());
				if (count < minCount || minCount == -1) {
					minCount = count;
					minUserId = designer.getId();
				}
			}
		}
		return minUserId;
	}
	
	public void allotPostProduction(String tableName, int orderId, int bossId) {
		int idleUserId = this.getIdleUserId(bossId);
		if (idleUserId != 0) {
			this.insertPostProductionRecord(tableName, orderId, idleUserId);
		}
	}
	
	public void insertOrderFixedImageData(OrderTransferImageData transferImageData) {
		Date now = new Date();
		int id = commonDao.insert("INSERT INTO ORDER_FIXED_IMAGE_DATA (INSERT_DATETIME, UPDATE_DATETIME, ORDER_ID, FILE_NAME) VALUES (?, ?, ?, ?)",
			now, now, transferImageData.getOrderId(), transferImageData.getFileName());
		transferImageData.setId(id);
	}
	
	public boolean isExistFixedImageData(int orderId, String fileName) {
		Count count = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM ORDER_FIXED_IMAGE_DATA WHERE ORDER_ID = ? AND FILE_NAME = ?",
				orderId, fileName);
		if (count != null && count.getCnt() > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public List<OrderFixedImageData> getOrderFixedImageDataList(int orderId) {
		return commonDao.query(OrderFixedImageData.class, "SELECT * FROM ORDER_FIXED_IMAGE_DATA WHERE ORDER_ID = ? ORDER BY ID", orderId);
	}
	
	public OrderFixedImageData getVerifyImageData(int orderId) {
		return commonDao.getFirst(OrderFixedImageData.class, "SELECT * FROM ORDER_FIXED_IMAGE_DATA WHERE ORDER_ID = ? AND IS_VERIFIED = 0 AND REASON IS NULL ORDER BY ID", orderId);
	}
	
	public void reverifyFixedImageData(OrderTransferImageData transferImageData) {
		commonDao.update("UPDATE ORDER_FIXED_IMAGE_DATA SET IS_VERIFIED = 0, REASON = NULL, UPDATE_DATETIME = ? WHERE ID = ?",
				new Date(), transferImageData.getId());
	}
	
	public Count getVerifiedImageCount(int orderId) {
		return commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM ORDER_FIXED_IMAGE_DATA WHERE IS_VERIFIED = 1 AND ORDER_ID = ?", orderId);
	}
	
	public Count getAllOriginalImageCount(int orderId) {
		return commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM ORDER_TRANSFER_IMAGE_DATA WHERE ORDER_ID = ? AND IS_SELECTED = 1", orderId);
	}
	
	public Count getAllFixedImageCount(int orderId) {
		return commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM ORDER_FIXED_IMAGE_DATA WHERE ORDER_ID = ?", orderId);
	}
	
	public Count getAllFixedImageCount(int orderId, String columnName) {
		return commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM ORDER_TRANSFER_IMAGE_DATA WHERE ORDER_ID = ? AND IS_SELECTED = 1 AND " + columnName + " = 1", orderId);
	}
	
	public Count getAllPostProductionCount(int userId, String tableName, String startDate, String endDate) {
		return commonDao.getFirst(Count.class, "SELECT COUNT(A.ID) AS CNT FROM ORDER_TRANSFER_IMAGE_DATA A LEFT JOIN " + tableName + " B ON A.ORDER_ID = B.ORDER_ID WHERE B.OPERATOR_ID = ? AND B.INSERT_DATETIME BETWEEN '" + startDate + " 00:00:00' AND '" + endDate + " 23:59:59'", userId);
	}
	
	public Count getAllPostProductionDoneCount(int userId, String tableName, String columnName, String startDate, String endDate) {
		return commonDao.getFirst(Count.class, "SELECT COUNT(A.ID) AS CNT FROM ORDER_TRANSFER_IMAGE_DATA A LEFT JOIN " + tableName + " B ON A.ORDER_ID = B.ORDER_ID WHERE OPERATOR_ID = ? AND " + columnName + " = 1 AND B.INSERT_DATETIME BETWEEN '" + startDate + " 00:00:00' AND '" + endDate + " 23:59:59'", userId);
	}
	
	public Count getOrderPostProductionDoneCount(int userId, String columnName, String startDate, String endDate) {
		return commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM ORDERS WHERE STATUS_ID = ? AND " + columnName + " = ? AND INSERT_DATETIME BETWEEN '" + startDate + " 00:00:00' AND '" + endDate + " 23:59:59'",
				OrderStatusConst.COMPLETE, userId);
	}
	
	public boolean isAllPictureFixed(int orderId) {
		Count originalCount = this.getAllOriginalImageCount(orderId);
		Count fixedCount = this.getAllFixedImageCount(orderId);
		if (originalCount.getCnt() == fixedCount.getCnt()) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean isAllPictureFixed(int orderId, String columnName) {
		Count originalCount = this.getAllOriginalImageCount(orderId);
		Count fixedCount = this.getAllFixedImageCount(orderId, columnName);
		if (originalCount.getCnt() == fixedCount.getCnt()) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean isSelectedPicture(int orderId, String fileName) {
		Count count = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM ORDER_TRANSFER_IMAGE_DATA WHERE ORDER_ID = ? AND FILE_NAME = ? AND IS_SELECTED = 1", orderId, fileName);
		if (count != null && count.getCnt() == 1) {
			return true;
		} else {
			return false;
		}
	}
	
	public void setPostProductionDone(int orderId, String tableName) {
		commonDao.update("UPDATE " + tableName + " SET IS_DONE = 1, UPDATE_DATETIME = ? WHERE ORDER_ID = ?", new Date(), orderId);
	}
}
