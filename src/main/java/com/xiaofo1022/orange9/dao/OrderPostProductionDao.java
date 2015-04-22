package com.xiaofo1022.orange9.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.common.RoleConst;
import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.OrderImageFixSkin;
import com.xiaofo1022.orange9.modal.OrderStatusCount;
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
					this.insertImageFixSkin(orderId, designer.getId(), imageData.getId(), now);
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
	
	public int insertImageFixSkin(int orderId, int userId, int imageId, Date now) {
		return commonDao.insert("INSERT INTO ORDER_IMAGE_FIX_SKIN (ORDER_ID, INSERT_DATETIME, UPDATE_DATETIME, OPERATOR_ID, IMAGE_ID) VALUES (?, ?, ?, ?, ?)",
				orderId, now, now, userId, imageId);
	}
	
	public OrderStatusCount getOrderFixSkinCount() {
		OrderStatusCount orderStatusCount = new OrderStatusCount();
		List<OrderImageFixSkin> fixSkinGroupList = this.getFixSkinGroupList();
		if (fixSkinGroupList != null && fixSkinGroupList.size() > 0) {
			orderStatusCount.setStatusCount(fixSkinGroupList.size());
		}
		return orderStatusCount;
	}
	
	public List<OrderImageFixSkin> getFixSkinList() {
		List<OrderImageFixSkin> fixSkinGroupList = getFixSkinGroupList();
		if (fixSkinGroupList != null && fixSkinGroupList.size() > 0) {
			Date now = new Date();
			for (OrderImageFixSkin fixSkin : fixSkinGroupList) {
				List<OrderTransferImageData> imageDataList = this.getImageDataList(fixSkin.getOrderId(), fixSkin.getOperatorId());
				String fileNames = orderTransferDao.getConnectImageName(imageDataList);
				fixSkin.setImageCount(imageDataList.size());
				fixSkin.setTimeCost(DatetimeUtil.getDatetimeDiff(fixSkin.getInsertDatetime(), now));
				fixSkin.setFileNames(fileNames);
			}
		}
		return fixSkinGroupList;
	}
	
	public List<OrderTransferImageData> getImageDataList(int orderId, int operatorId) {
		return commonDao.query(OrderTransferImageData.class, "SELECT B.* FROM ORDER_IMAGE_FIX_SKIN A LEFT JOIN ORDER_TRANSFER_IMAGE_DATA B ON A.IMAGE_ID = B.ID WHERE A.ORDER_ID = ? AND A.OPERATOR_ID = ?",
			orderId, operatorId);
	}
	
	public List<OrderImageFixSkin> getFixSkinGroupListByOrder(int orderId) {
		return commonDao.query(OrderImageFixSkin.class, "SELECT ORDER_ID, OPERATOR_ID, INSERT_DATETIME, UPDATE_DATETIME FROM ORDER_IMAGE_FIX_SKIN WHERE IS_DONE = 0 AND ORDER_ID = ? GROUP BY ORDER_ID, OPERATOR_ID", orderId);
	}
	
	public List<OrderImageFixSkin> getFixSkinGroupList() {
		return commonDao.query(OrderImageFixSkin.class, "SELECT ORDER_ID, OPERATOR_ID, INSERT_DATETIME, UPDATE_DATETIME FROM ORDER_IMAGE_FIX_SKIN WHERE IS_DONE = 0 GROUP BY ORDER_ID, OPERATOR_ID");
	}
}
