package com.xiaofo1022.orange9.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.OrderGoods;

@Repository
public class OrderGoodsDao {
  @Autowired
  private CommonDao commonDao;

  public void insertReceiveOrderGoods(OrderGoods orderGoods) {
    Date now = new Date();
    commonDao.insert(
        "INSERT INTO ORDER_GOODS (ORDER_ID, RECEIVE_EXPRESS_NO, RECEIVE_EXPRESS_COMPANY, INSERT_DATETIME, UPDATE_DATETIME, COAT_COUNT, PANTS_COUNT, JUMPSUITS_COUNT, SHOES_COUNT, BAG_COUNT, HAT_COUNT, OTHER_COUNT, REMARK) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        orderGoods.getOrderId(), orderGoods.getExpressNo(), orderGoods.getExpressCompany(), orderGoods.getInsertDatetime(), now, orderGoods.getCoatCount(),
        orderGoods.getPantsCount(), orderGoods.getJumpsuitsCount(), orderGoods.getShoesCount(), orderGoods.getBagCount(), orderGoods.getHatCount(),
        orderGoods.getOtherCount(), orderGoods.getRemark());
  }

  public void insertDeliverOrderGoods(OrderGoods orderGoods) {
    Date now = new Date();
    commonDao.insert(
        "INSERT INTO ORDER_GOODS (ORDER_ID, DELIVER_EXPRESS_NO, DELIVER_EXPRESS_COMPANY, INSERT_DATETIME, UPDATE_DATETIME, COAT_COUNT, PANTS_COUNT, JUMPSUITS_COUNT, SHOES_COUNT, BAG_COUNT, HAT_COUNT, OTHER_COUNT, REMARK) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        orderGoods.getOrderId(), orderGoods.getExpressNo(), orderGoods.getExpressCompany(), now, now, orderGoods.getCoatCount(), orderGoods.getPantsCount(),
        orderGoods.getJumpsuitsCount(), orderGoods.getShoesCount(), orderGoods.getBagCount(), orderGoods.getHatCount(), orderGoods.getOtherCount(),
        orderGoods.getRemark());
  }

  public OrderGoods getOrderShootGoods(int orderId) {
    return commonDao.getFirst(OrderGoods.class, "SELECT * FROM ORDER_SHOOT_GOODS WHERE ORDER_ID = ?", orderId);
  }

  public void setOrderShootGoods(OrderGoods orderGoods) {
    OrderGoods orderShootGoods = this.getOrderShootGoods(orderGoods.getOrderId());
    if (orderShootGoods == null) {
      this.insertOrderShootGoods(orderGoods);
      this.updateOrderGoodsId(orderGoods.getOrderId(), orderGoods.getId());
    } else {
      orderShootGoods.setCoatCount(orderShootGoods.getCoatCount() + orderGoods.getCoatCount());
      orderShootGoods.setPantsCount(orderShootGoods.getPantsCount() + orderGoods.getPantsCount());
      orderShootGoods.setJumpsuitsCount(orderShootGoods.getJumpsuitsCount() + orderGoods.getJumpsuitsCount());
      orderShootGoods.setBagCount(orderShootGoods.getBagCount() + orderGoods.getBagCount());
      orderShootGoods.setHatCount(orderShootGoods.getHatCount() + orderGoods.getHatCount());
      orderShootGoods.setShoesCount(orderShootGoods.getShoesCount() + orderGoods.getShoesCount());
      orderShootGoods.setOtherCount(orderShootGoods.getOtherCount() + orderGoods.getOtherCount());
      updateOrderShootGoods(orderShootGoods);
    }
  }

  public void addOrderShootGoods(OrderGoods orderGoods) {
    this.insertOrderShootGoods(orderGoods);
    this.updateOrderGoodsId(orderGoods.getOrderId(), orderGoods.getId());
  }

  public void insertOrderShootGoods(OrderGoods orderGoods) {
    Date now = new Date();
    int shootId = commonDao.insert(
        "INSERT INTO ORDER_SHOOT_GOODS (ORDER_ID, INSERT_DATETIME, UPDATE_DATETIME, COAT_COUNT, PANTS_COUNT, JUMPSUITS_COUNT, SHOES_COUNT, BAG_COUNT, HAT_COUNT, OTHER_COUNT) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        orderGoods.getOrderId(), now, now, orderGoods.getCoatCount(), orderGoods.getPantsCount(), orderGoods.getJumpsuitsCount(), orderGoods.getShoesCount(),
        orderGoods.getBagCount(), orderGoods.getHatCount(), orderGoods.getOtherCount());
    orderGoods.setId(shootId);
  }

  public void updateOrderShootGoods(OrderGoods orderGoods) {
    commonDao.update(
        "UPDATE ORDER_SHOOT_GOODS SET UPDATE_DATETIME = ?, COAT_COUNT = ?, PANTS_COUNT = ?, JUMPSUITS_COUNT = ?, SHOES_COUNT = ?, BAG_COUNT = ?, HAT_COUNT = ?, OTHER_COUNT = ? WHERE ORDER_ID = ?",
        new Date(), orderGoods.getCoatCount(), orderGoods.getPantsCount(), orderGoods.getJumpsuitsCount(), orderGoods.getShoesCount(), orderGoods.getBagCount(),
        orderGoods.getHatCount(), orderGoods.getOtherCount(), orderGoods.getOrderId());
  }

  public List<OrderGoods> getOrderGoodsList(int ownerId) {
    return commonDao.query(OrderGoods.class,
        "SELECT A.* FROM ORDER_GOODS A LEFT JOIN ORDERS B ON A.ORDER_ID = B.ID WHERE B.OWNER_ID = ? ORDER BY INSERT_DATETIME DESC", ownerId);
  }

  public void updateOrderGoodsId(int orderId, int orderGoodsId) {
    commonDao.update("UPDATE ORDERS SET GOODS_ID = ? WHERE ID = ?", orderGoodsId, orderId);
  }
}
