package com.xiaofo1022.orange9.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.common.OrderConst;
import com.xiaofo1022.orange9.common.RoleConst;
import com.xiaofo1022.orange9.common.TimeLimitConst;
import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Count;
import com.xiaofo1022.orange9.modal.OrderFixedImageData;
import com.xiaofo1022.orange9.modal.OrderPostProduction;
import com.xiaofo1022.orange9.modal.OrderStatusCount;
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
	
	//private static final int DESIGNER_MAX_IMAGE = 500;
	
	public void allotImage(int orderId) {
		List<User> designerList = userDao.getUserListByRoleId(RoleConst.DISIGNER_ID);
		if (designerList != null && designerList.size() > 0) {
			List<OrderTransferImageData> imageList = orderTransferDao.getSelectedTransferImageDataList(orderId);
			if (imageList != null && imageList.size() > 0) {
				int avgImageCount = (int) imageList.size() / designerList.size();
				if (avgImageCount == 0) {
					avgImageCount = 1;
				}
				int addImageCount = 0;
				int designerIndex = 0;
				User designer = designerList.get(designerIndex);
				Date now = new Date();
				for (OrderTransferImageData imageData : imageList) {
					this.insertPostProductionImage(OrderConst.TABLE_ORDER_FIX_SKIN, orderId, designer.getId(), imageData.getId(), now);
					addImageCount++;
					if (addImageCount == avgImageCount) {
						addImageCount = 0;
						designerIndex++;
						if (designerIndex > designerList.size() - 1) {
							designerIndex = designerList.size() - 1;
						}
						designer = designerList.get(designerIndex);
					}
				}
			}
		}
	}
	
	public int insertPostProductionImage(String tableName, int orderId, int userId, int imageId, Date now) {
		return commonDao.insert("INSERT INTO " + tableName + " (ORDER_ID, INSERT_DATETIME, UPDATE_DATETIME, OPERATOR_ID, IMAGE_ID) VALUES (?, ?, ?, ?, ?)",
				orderId, now, now, userId, imageId);
	}
	
	public OrderStatusCount getOrderPostProductionCount(String tableName, int userId) {
		OrderStatusCount orderStatusCount = new OrderStatusCount();
		List<OrderPostProduction> postProductionList = this.getPostProductionGroupList(tableName, userId);
		int statusCount = 0;
		if (postProductionList != null && postProductionList.size() > 0) {
			for (OrderPostProduction postProduction : postProductionList) {
				List<OrderTransferImageData> imageDataList = this.getImageDataList(tableName, postProduction.getOperatorId());
				statusCount += imageDataList.size();
			}
		}
		orderStatusCount.setStatusCount(statusCount);
		return orderStatusCount;
	}
	
	public List<OrderPostProduction> getPostProductionList(String tableName, int userId) {
		List<OrderPostProduction> postProductionList = this.getPostProductionGroupList(tableName, userId);
		if (postProductionList != null && postProductionList.size() > 0) {
			Date now = new Date();
			for (OrderPostProduction postProduction : postProductionList) {
				List<OrderTransferImageData> imageDataList = this.getImageDataList(tableName, postProduction.getOperatorId());
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
	
	public List<OrderTransferImageData> getImageDataList(String tableName, int operatorId) {
		return commonDao.query(OrderTransferImageData.class, "SELECT B.* FROM " + tableName + " A LEFT JOIN ORDER_TRANSFER_IMAGE_DATA B ON A.IMAGE_ID = B.ID WHERE A.OPERATOR_ID = ? AND A.IS_DONE = 0",
			operatorId);
	}
	
	public List<OrderPostProduction> getPostProductionListByOrder(String tableName, int orderId) {
		return commonDao.query(OrderPostProduction.class, "SELECT ORDER_ID, OPERATOR_ID, INSERT_DATETIME, UPDATE_DATETIME, IS_DONE FROM " + tableName + " WHERE ORDER_ID = ? GROUP BY ORDER_ID, OPERATOR_ID", orderId);
	}
	
	public List<OrderPostProduction> getPostProductionGroupList(String tableName, int userId) {
		String sql = "SELECT ID, ORDER_ID, OPERATOR_ID, INSERT_DATETIME, UPDATE_DATETIME FROM " + tableName + " WHERE IS_DONE = 0";
		if (userId != 0) {
			sql += " AND OPERATOR_ID = " + userId;
		}
		sql += " GROUP BY OPERATOR_ID";
		return commonDao.query(OrderPostProduction.class, sql);
	}
	
	public List<OrderPostProduction> getPostProductionListByOrderAndOperator(String tableName, int orderId, int userId) {
		return commonDao.query(OrderPostProduction.class, "SELECT * FROM " + tableName + " WHERE IS_DONE = 0 AND ORDER_ID = ? AND OPERATOR_ID = ?", orderId, userId);
	}
	
	public List<OrderPostProduction> setPostProductionDone(String tableName, int orderId, int userId) {
		List<OrderPostProduction> postProductionList = this.getPostProductionListByOrderAndOperator(tableName, orderId, userId);
		Date now = new Date();
		for (OrderPostProduction postProduction : postProductionList) {
			commonDao.update("UPDATE " + tableName + " SET IS_DONE = 1, UPDATE_DATETIME = ? WHERE ID = ?", now, postProduction.getId());
		}
		return postProductionList;
	}
	
	public int getUserAllPostCount(int userId) {
		Count fixSkinCount = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM ORDER_IMAGE_FIX_SKIN WHERE OPERATOR_ID = ? AND IS_DONE = 0", userId);
		Count fixBackgroundCount = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM ORDER_IMAGE_FIX_BACKGROUND WHERE OPERATOR_ID = ? AND IS_DONE = 0", userId);
		Count cutLiquifyCount = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM ORDER_IMAGE_CUT_LIQUIFY WHERE OPERATOR_ID = ? AND IS_DONE = 0", userId);
		return fixSkinCount.getCnt() + fixBackgroundCount.getCnt() + cutLiquifyCount.getCnt();
	}
	
	public int getIdleUserId() {
		List<User> designerList = userDao.getUserListByRoleId(RoleConst.DISIGNER_ID);
		int minUserId = 0;
		if (designerList != null && designerList.size() > 0) {
			int minCount = 0;
			for (int i = 0; i < designerList.size(); i++) {
				User designer = designerList.get(i);
				int count = this.getUserAllPostCount(designer.getId());
				if (count < minCount || minCount == 0) {
					minCount = count;
					minUserId = designer.getId();
				}
			}
		}
		return minUserId;
	}
	
	public void allotPostProduction(String tableName, List<OrderPostProduction> postProductionList) {
		int idleUserId = this.getIdleUserId();
		if (idleUserId != 0) {
			Date now = new Date();
			for (OrderPostProduction postProduction : postProductionList) {
				commonDao.insert("INSERT INTO " + tableName + " (ORDER_ID, INSERT_DATETIME, UPDATE_DATETIME, OPERATOR_ID, IMAGE_ID) VALUES (?, ?, ?, ?, ?)",
						postProduction.getOrderId(), now, now, idleUserId, postProduction.getImageId());
			}
		}
	}
	
	public void insertOrderFixedImageData(OrderTransferImageData transferImageData) {
		Date now = new Date();
		int id = commonDao.insert("INSERT INTO ORDER_FIXED_IMAGE_DATA (INSERT_DATETIME, UPDATE_DATETIME, ORDER_ID, FILE_NAME) VALUES (?, ?, ?, ?)",
			now, now, transferImageData.getOrderId(), transferImageData.getFileName());
		transferImageData.setId(id);
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
	
	public Count getAllPostProductionCount(int userId, String tableName, String startDate, String endDate) {
		return commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM " + tableName + " WHERE OPERATOR_ID = ? AND INSERT_DATETIME BETWEEN '" + startDate + " 00:00:00' AND '" + endDate + " 23:59:59'", userId);
	}
	
	public Count getAllPostProductionDoneCount(int userId, String tableName, String startDate, String endDate) {
		return commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM " + tableName + " WHERE OPERATOR_ID = ? AND IS_DONE = 1 AND INSERT_DATETIME BETWEEN '" + startDate + " 00:00:00' AND '" + endDate + " 23:59:59'", userId);
	}
}
