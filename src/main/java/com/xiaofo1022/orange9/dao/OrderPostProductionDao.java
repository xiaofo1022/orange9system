package com.xiaofo1022.orange9.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.common.OrderConst;
import com.xiaofo1022.orange9.common.OrderStatusConst;
import com.xiaofo1022.orange9.common.RoleConst;
import com.xiaofo1022.orange9.common.TimeLimitConst;
import com.xiaofo1022.orange9.controller.PictureController;
import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.AllotImage;
import com.xiaofo1022.orange9.modal.Count;
import com.xiaofo1022.orange9.modal.Order;
import com.xiaofo1022.orange9.modal.OrderFixedImageData;
import com.xiaofo1022.orange9.modal.OrderPostProduction;
import com.xiaofo1022.orange9.modal.OrderTimeLimit;
import com.xiaofo1022.orange9.modal.OrderTransferImageData;
import com.xiaofo1022.orange9.modal.Result;
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
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private PictureController pictureController;
	
	public void allotImage(int orderId, int bossId) {
		int idleUserId = this.getIdleUserId(bossId);
		this.insertPostProductionRecord(OrderConst.TABLE_ORDER_FIX_BACKGROUND, orderId, idleUserId);
	}
	
	public void skipAllotImage(int orderId, String fixedColumn) {
		commonDao.update("UPDATE ORDER_TRANSFER_IMAGE_DATA SET " + fixedColumn + " = 1 WHERE ORDER_ID = ?", orderId);
	}
	
	public void setOrderCompleteRemark(int orderId, String remark) {
		commonDao.update("UPDATE ORDERS SET COMPLETE_REMARK = ? WHERE ID = ?", remark, orderId);
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
	
	public int getTransferPostProductionCount(String fixedColumn, int ownerId) {
		Count count = commonDao.getFirst(Count.class, "SELECT COUNT(A.ID) AS CNT FROM ORDER_TRANSFER_IMAGE_DATA A LEFT JOIN ORDERS B ON A.ORDER_ID = B.ID WHERE A." + fixedColumn + " = 0 AND B.OWNER_ID = ? AND A.IS_SELECTED = 1 AND B.STATUS_ID = ?", ownerId, OrderStatusConst.POST_PRODUCTION);
		if (count != null) {
			return count.getCnt();
		} else {
			return 0;
		}
	}
	
	public int getFixedDoneCount(int ownerId) {
		int count = 0;
		List<Order> postOrderList = orderDao.getOrderListByStatus(OrderStatusConst.POST_PRODUCTION, ownerId);
		if (postOrderList != null && postOrderList.size() > 0) {
			for (Order order : postOrderList) {
				if (this.isAllTransferPictureFixed(order.getId())) {
					count++;
				}
			}
		}
		return count;
	}
	
	public boolean isAllTransferPictureFixed(int orderId) {
		Count fixedCount = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM ORDER_TRANSFER_IMAGE_DATA WHERE ORDER_ID = ? AND IS_FIXED_SKIN = 1 AND IS_FIXED_BACKGROUND = 1 AND IS_CUT_LIQUIFY = 1 AND IS_SELECTED = 1", orderId);
		Count selectedCount = orderTransferDao.getSelectedTransferImageDataCount(orderId);
		if (fixedCount.getCnt() == selectedCount.getCnt()) {
			return true;
		} else {
			return false;
		}
	}
	
	public List<OrderPostProduction> getPostProductionList(String tableName, String columnName, int ownerId) {
		List<OrderPostProduction> postProductionList = this.getPostProductionShowList(tableName, ownerId);
		if (postProductionList != null && postProductionList.size() > 0) {
			Date now = new Date();
			for (OrderPostProduction postProduction : postProductionList) {
				List<OrderTransferImageData> imageDataList = this.getImageDataList(postProduction.getOrderId());
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
	
	public List<OrderPostProduction> getPostProductionListByTransfer(String fixedColumn, String operatorColumn, int ownerId) {
		List<OrderPostProduction> postProductionList = this.getPostProductionTransferList(fixedColumn, operatorColumn, ownerId);
		if (postProductionList != null && postProductionList.size() > 0) {
			for (OrderPostProduction postProduction : postProductionList) {
				List<OrderTransferImageData> imageDataList = this.getImageDataListByOperator(postProduction.getOrderId(), postProduction.getOperatorId(), operatorColumn);
				String fileNames = orderTransferDao.getConnectImageName(imageDataList);
				postProduction.setImageCount(imageDataList.size());
				postProduction.setFileNames(fileNames);
				postProduction.setImageDataList(imageDataList);
			}
		}
		return postProductionList;
	}
	
	public List<OrderPostProduction> getUploadFixedImageOrderList(int ownerId, HttpServletRequest request) {
		List<Order> postOrderList = orderDao.getOrderListByStatus(OrderStatusConst.POST_PRODUCTION, ownerId);
		List<OrderPostProduction> resultList = null;
		if (postOrderList != null && postOrderList.size() > 0) {
			resultList = new ArrayList<OrderPostProduction>();
			for (Order order : postOrderList) {
				if (this.isAllTransferPictureFixed(order.getId())) {
					Result result = pictureController.getUnuploadFixedImageFileNames(order.getId(), request);
					OrderPostProduction postProduction = new OrderPostProduction();
					postProduction.setOrderId(order.getId());
					postProduction.setOrderNo(order.getOrderNo());
					postProduction.setFileNames(result.getFileNames());
					postProduction.setImageCount(result.getUnuploadCount());
					resultList.add(postProduction);
				}
			}
		}
		return resultList;
	}
	
	public List<Order> getUnAllotOrderList(int ownerId, String fixedColumn, String operatorColumn) {
		List<Order> postOrderList = orderDao.getOrderListByStatus(OrderStatusConst.POST_PRODUCTION, ownerId);
		List<Order> resultList = new ArrayList<Order>();
		if (postOrderList != null && postOrderList.size() > 0) {
			for (Order order : postOrderList) {
				int unAllotCount = this.getUnAllotOrderCount(order.getId(), fixedColumn, operatorColumn);
				if (unAllotCount > 0) {
					order.setUnAllotCount(unAllotCount);
					resultList.add(order);
				}
			}
		}
		return resultList;
	}
	
	public void allotImage(int orderId, String fixedColumn, String operatorColumn, List<AllotImage> allotList) {
		List<OrderTransferImageData> unAllotImageList = this.getUnAllotTransferImageDataList(orderId, fixedColumn, operatorColumn);
		int imageSize = unAllotImageList.size();
		int imageIndex = 0;
		if (unAllotImageList != null && imageSize > 0) {
			for (AllotImage allotImage : allotList) {
				if (allotImage.getAllotCount() > 0) {
					int allotCount = 0;
					for (int i = imageIndex; i < imageSize; i++) {
						OrderTransferImageData transferImageData = unAllotImageList.get(i);
						this.setTransferImageOperator(allotImage.getDesignerId(), transferImageData.getId(), operatorColumn);
						allotCount++;
						if (allotCount == allotImage.getAllotCount()) {
							imageIndex += allotCount;
							allotCount = 0;
							break;
						}
					}
				}
			}
		}
	}
	
	public void setTransferImageOperator(int operatorId, int imageId, String operatorColumn) {
		commonDao.update("UPDATE ORDER_TRANSFER_IMAGE_DATA SET " + operatorColumn + " = ? WHERE ID = ?", operatorId, imageId);
	}
	
	public int getUnAllotOrderCount(int orderId, String fixedColumn, String operatorColumn) {
		Count count = commonDao.getFirst(Count.class, "SELECT COUNT(ID) AS CNT FROM ORDER_TRANSFER_IMAGE_DATA WHERE ORDER_ID = ? AND " + fixedColumn + " = 0 AND " + operatorColumn + " = 0 AND IS_SELECTED = 1", orderId);
		return count.getCnt();
	}
	
	public List<OrderTransferImageData> getUnAllotTransferImageDataList(int orderId, String fixedColumn, String operatorColumn) {
		return commonDao.query(OrderTransferImageData.class, "SELECT * FROM ORDER_TRANSFER_IMAGE_DATA WHERE ORDER_ID = ? AND " + fixedColumn + " = 0 AND " + operatorColumn + " = 0 AND IS_SELECTED = 1 ORDER BY ID", orderId);
	}
	
	public List<OrderTransferImageData> getImageDataList(int orderId) {
		return commonDao.query(OrderTransferImageData.class, "SELECT * FROM ORDER_TRANSFER_IMAGE_DATA WHERE ORDER_ID = ? AND IS_SELECTED = 1", orderId);
	}
	
	public List<OrderTransferImageData> getImageDataListByOperator(int orderId, int operatorId, String operatorColumn) {
		return commonDao.query(OrderTransferImageData.class, "SELECT * FROM ORDER_TRANSFER_IMAGE_DATA WHERE ORDER_ID = ? AND IS_SELECTED = 1 AND " + operatorColumn + " = ?", orderId, operatorId);
	}
	
	public OrderPostProduction getPostProductionByOrder(String tableName, int orderId) {
		return commonDao.getFirst(OrderPostProduction.class, "SELECT * FROM " + tableName + " WHERE ORDER_ID = ?", orderId);
	}
	
	public OrderPostProduction getPostProductionFixer(String operatorColumn, int orderId) {
		OrderTransferImageData imageData = commonDao.getFirst(OrderTransferImageData.class, "SELECT ORDER_ID, " + operatorColumn + " AS OPERATOR_ID FROM ORDER_TRANSFER_IMAGE_DATA WHERE ORDER_ID = ? AND " + operatorColumn + " <> 0", orderId);
		OrderPostProduction postProduction = null;
		if (imageData != null) {
			postProduction = new OrderPostProduction();
			postProduction.setOrderId(imageData.getOrderId());
			postProduction.setOrderNo(imageData.getOrderNo());
			postProduction.setOperatorId(imageData.getOperatorId());
			postProduction.setOperator(userDao.getUserById(imageData.getOperatorId()));
		}
		return postProduction;
	}
	
	public List<OrderPostProduction> getPostProductionShowList(String tableName, int ownerId) {
		String sql = "SELECT A.* FROM " + tableName + " A LEFT JOIN ORDERS B ON A.ORDER_ID = B.ID WHERE B.OWNER_ID = ? AND A.IS_DONE = 0";
		return commonDao.query(OrderPostProduction.class, sql, ownerId);
	}
	
	public List<OrderPostProduction> getPostProductionTransferList(String fixedColumn, String operatorColumn, int ownerId) {
		List<OrderTransferImageData> imageDataList = commonDao.query(OrderTransferImageData.class, "SELECT A.ORDER_ID, A." + operatorColumn + " AS OPERATOR_ID FROM ORDER_TRANSFER_IMAGE_DATA A LEFT JOIN ORDERS B ON A.ORDER_ID = B.ID WHERE A.IS_SELECTED = 1 AND B.OWNER_ID = ? AND " + fixedColumn + " = 0 AND " + operatorColumn + " <> 0 GROUP BY ORDER_ID, " + operatorColumn, ownerId);
		List<OrderPostProduction> resultList = null;
		if (imageDataList != null && imageDataList.size() > 0) {
			resultList = new ArrayList<OrderPostProduction>();
			for (OrderTransferImageData imageData : imageDataList) {
				OrderPostProduction postProduction = new OrderPostProduction();
				postProduction.setOrderId(imageData.getOrderId());
				postProduction.setOrderNo(imageData.getOrderNo());
				postProduction.setOperatorId(imageData.getOperatorId());
				postProduction.setOperator(userDao.getUserById(imageData.getOperatorId()));
				resultList.add(postProduction);
			}
		}
		return resultList;
	}
	
	public void setFixPostImageDone(String columnName, int orderId) {
		commonDao.update("UPDATE ORDER_TRANSFER_IMAGE_DATA SET " + columnName + " = 1 WHERE ORDER_ID = ?", orderId);
	}
	
	public void setFixPostImageDone(String fixedColumn, String operatorColumn, int orderId, int operatorId) {
		commonDao.update("UPDATE ORDER_TRANSFER_IMAGE_DATA SET " + fixedColumn + " = 1 WHERE ORDER_ID = ? AND " + operatorColumn + " = ?", orderId, operatorId);
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
	
	public boolean isExitDesigner(int bossId) {
		List<User> designerList = userDao.getUserListByRoleId(RoleConst.DESIGNER_ID, bossId);
		if (designerList != null && designerList.size() > 0) {
			return true;
		} else {
			return false;
		}
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
	
	public Count getAllPostProductionDoneCount(int userId, String fixedColumn, String operatorColumn, String startDate, String endDate) {
		return commonDao.getFirst(Count.class, "SELECT COUNT(A.ID) AS CNT FROM ORDER_TRANSFER_IMAGE_DATA A LEFT JOIN ORDERS B ON A.ORDER_ID = B.ID WHERE A." + operatorColumn + " = ? AND " + fixedColumn + " = 1 AND B.INSERT_DATETIME BETWEEN '" + startDate + " 00:00:00' AND '" + endDate + " 23:59:59'", userId);
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
