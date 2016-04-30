package com.xiaofo1022.orange9.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.common.OrderConst;
import com.xiaofo1022.orange9.common.OrderStatusConst;
import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Order;
import com.xiaofo1022.orange9.modal.OrderStatus;
import com.xiaofo1022.orange9.modal.OrderStatusCount;
import com.xiaofo1022.orange9.modal.User;

@Repository
public class OrderStatusDao {
  @Autowired
  private CommonDao commonDao;
  @Autowired
  private ClockInDao clockInDao;
  @Autowired
  private OrderDao orderDao;
  @Autowired
  private OrderPostProductionDao orderPostProductionDao;
  @Autowired
  private OrderConvertDao orderConvertDao;

  public List<OrderStatus> getOrderStatusList() {
    return commonDao.query(OrderStatus.class, "SELECT * FROM ORDER_STATUS ORDER BY ID");
  }

  public OrderStatus getOrderStatus(int statusId) {
    return commonDao.getFirst(OrderStatus.class, "SELECT * FROM ORDER_STATUS WHERE ID = ?", statusId);
  }

  public Map<String, Integer> getOrderStatusCountMap(int userId, int bossId) {
    List<OrderStatus> orderStatusList = this.getOrderStatusList();
    Map<String, Integer> statusCountMap = new HashMap<String, Integer>();
    for (OrderStatus orderStatus : orderStatusList) {
      OrderStatusCount orderStatusCount = this.getOrderStatusCount(orderStatus.getId(), bossId);
      statusCountMap.put(orderStatus.getName(), orderStatusCount == null ? 0 : orderStatusCount.getStatusCount());
    }
    statusCountMap.put(OrderStatusConst.CONVERT, orderConvertDao.getOrderConvert(bossId).size());
    statusCountMap.put(OrderStatusConst.FIX_SKIN, orderPostProductionDao.getTransferPostProductionCount(OrderConst.COLUMN_FIXED_SKIN, bossId));
    statusCountMap.put(OrderStatusConst.FIX_BACKGROUND, orderPostProductionDao.getTransferPostProductionCount(OrderConst.COLUMN_FIXED_BACKGROUND, bossId));
    statusCountMap.put(OrderStatusConst.CUT_LIQUIFY, orderPostProductionDao.getTransferPostProductionCount(OrderConst.COLUMN_CUT_LIQUIFY, bossId));
    statusCountMap.put(OrderStatusConst.UPLOAD_FIXED, orderPostProductionDao.getFixedDoneCount(bossId));
    statusCountMap.put(OrderStatusConst.LEAVE_VERIFY, clockInDao.getUnconfirmLeaveRequestCount());
    return statusCountMap;
  }

  public OrderStatusCount getOrderStatusCount(int statusId, int ownerId) {
    return commonDao.getFirst(OrderStatusCount.class, "SELECT COUNT(ID) AS STATUS_COUNT FROM ORDERS WHERE STATUS_ID = ? AND OWNER_ID = ?", statusId, ownerId);
  }

  public void updateOrderStatus(int orderId, User user, int statusId) {
    Order order = orderDao.getOrderDetail(orderId);
    if (order != null) {
      if (user != null) {
        order.setUserId(user.getId());
      }
      OrderStatus orderStatus = this.getOrderStatus(statusId);
      orderDao.updateOrderStatus(order, orderStatus, null);
    }
  }
}
