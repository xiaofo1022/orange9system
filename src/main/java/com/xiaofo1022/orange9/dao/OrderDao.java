package com.xiaofo1022.orange9.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.xiaofo1022.orange9.common.OrderStatusConst;
import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Broker;
import com.xiaofo1022.orange9.modal.Name;
import com.xiaofo1022.orange9.modal.Order;
import com.xiaofo1022.orange9.modal.OrderNo;
import com.xiaofo1022.orange9.modal.OrderStatus;
import com.xiaofo1022.orange9.util.DatetimeUtil;

@Repository
@Transactional
public class OrderDao {
  @Autowired
  private CommonDao commonDao;
  @Autowired
  private OrderHistoryDao orderHistoryDao;

  public void insertOrder(Order order) {
    Date now = new Date();
    int id = commonDao.insert(
        "INSERT INTO ORDERS (INSERT_DATETIME, UPDATE_DATETIME, SHOOT_DATE, CLIENT_ID, MODEL_NAME, BROKER_NAME, BROKER_PHONE, SHOOT_HALF, DRESSER_NAME, STYLIST_NAME, PHOTOGRAPHER_ID, ASSISTANT_ID, STATUS_ID, OWNER_ID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        now, now, order.getShootDate(), order.getClientId(), order.getModelName(), order.getBrokerName(), order.getBrokerPhone(), order.getShootHalf(),
        order.getDresserName(), order.getStylistName(), order.getPhotographerId(), order.getAssistantId(), OrderStatusConst.SHOOTING, order.getOwnerId());
    order.setId(id);
    orderHistoryDao.addOrderHistory(order, OrderStatusConst.CREATE_ORDER, null);
  }

  public void updateOrder(Order order) {
    commonDao.update(
        "UPDATE ORDERS SET UPDATE_DATETIME = ?, SHOOT_DATE = ?, CLIENT_ID = ?, MODEL_NAME = ?, BROKER_NAME = ?, BROKER_PHONE = ?, SHOOT_HALF = ?, DRESSER_NAME = ?, STYLIST_NAME = ?, PHOTOGRAPHER_ID = ?, ASSISTANT_ID = ? WHERE ID = ?",
        new Date(), order.getShootDate(), order.getClientId(), order.getModelName(), order.getBrokerName(), order.getBrokerPhone(), order.getShootHalf(),
        order.getDresserName(), order.getStylistName(), order.getPhotographerId(), order.getAssistantId(), order.getId());
  }

  public List<Order> getOrderList() {
    return commonDao.query(Order.class, "SELECT * FROM ORDERS WHERE ACTIVE = 1 ORDER BY SHOOT_DATE, SHOOT_HALF");
  }

  public List<Order> getOrderListByClient(int clientId) {
    return commonDao.query(Order.class, "SELECT * FROM ORDERS WHERE CLIENT_ID = ? AND STATUS_ID >= ? AND ACTIVE = 1 ORDER BY STATUS_ID ASC, ID DESC", clientId,
        OrderStatusConst.WAITING_FOR_CLIENT_CHOSE);
  }

  public List<Order> getOrderListByDate(String startDate, String endDate, int ownerId) {
    return commonDao.query(Order.class, "SELECT * FROM ORDERS WHERE ACTIVE = 1 AND SHOOT_DATE BETWEEN '" + startDate + " 00:00:00' AND '" + endDate
        + " 00:00:00' AND OWNER_ID = ? ORDER BY SHOOT_DATE, SHOOT_HALF", ownerId);
  }

  public Order getOrderDetail(int orderId) {
    return commonDao.getFirst(Order.class, "SELECT * FROM ORDERS WHERE ID = ? AND ACTIVE = 1", orderId);
  }

  public void updateOrderStatus(Order order, OrderStatus orderStatus, String reason) {
    commonDao.update("UPDATE ORDERS SET STATUS_ID = ?, UPDATE_DATETIME = ? WHERE ID = ?", orderStatus.getId(), new Date(), order.getId());
    orderHistoryDao.addOrderHistory(order, OrderStatusConst.STATUS_CHANGE + orderStatus.getName(), reason);
  }

  public List<Order> getOrderListByStatus(int statusId, int ownerId) {
    return commonDao.query(Order.class, "SELECT * FROM ORDERS WHERE ACTIVE = 1 AND STATUS_ID = ? AND OWNER_ID = ? ORDER BY SHOOT_DATE, SHOOT_HALF", statusId,
        ownerId);
  }

  public List<Name> getModelNameList(int ownerId) {
    return commonDao.query(Name.class, "SELECT DISTINCT(MODEL_NAME) AS NAME FROM ORDERS WHERE OWNER_ID = ? ORDER BY NAME", ownerId);
  }

  public List<Name> getDresserNameList(int ownerId) {
    return commonDao.query(Name.class, "SELECT DISTINCT(DRESSER_NAME) AS NAME FROM ORDERS WHERE OWNER_ID = ? ORDER BY NAME", ownerId);
  }

  public List<Name> getStylistNameList(int ownerId) {
    return commonDao.query(Name.class, "SELECT DISTINCT(STYLIST_NAME) AS NAME FROM ORDERS WHERE OWNER_ID = ? ORDER BY NAME", ownerId);
  }

  public List<Broker> getBrokerList(int ownerId) {
    return commonDao.query(Broker.class, "SELECT DISTINCT(BROKER_NAME) AS NAME, BROKER_PHONE AS PHONE FROM ORDERS WHERE OWNER_ID = ? ORDER BY NAME", ownerId);
  }

  public String getOrderTimeCost(Order order) {
    if (order.getStatusId() == OrderStatusConst.COMPLETE) {
      return DatetimeUtil.getDatetimeDiff(order.getInsertDatetime(), order.getUpdateDatetime());
    } else {
      return DatetimeUtil.getDatetimeDiff(order.getInsertDatetime(), new Date());
    }
  }

  public List<OrderNo> getOrderNoList(int ownerId) {
    return commonDao.query(OrderNo.class, "SELECT ID FROM ORDERS WHERE OWNER_ID = ? ORDER BY ID", ownerId);
  }
}
