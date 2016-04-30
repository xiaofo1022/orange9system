package com.xiaofo1022.orange9.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Client;
import com.xiaofo1022.orange9.modal.ClientMessage;

@Repository
public class ClientDao {
  @Autowired
  private CommonDao commonDao;

  public void insertClient(Client client) {
    Date now = new Date();
    int id = commonDao.insert(
        "INSERT INTO CLIENT (INSERT_DATETIME, UPDATE_DATETIME, NAME, PHONE, EMAIL, SHOP_NAME, SHOP_LINK, REMARK, OWNER_ID, ACCOUNT_ID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        now, now, client.getClientName(), client.getClientPhone(), client.getClientEmail(), client.getClientShopName(), client.getClientShopLink(),
        client.getClientRemark(), client.getOwnerId(), client.getAccountId());
    client.setId(id);
  }

  public void updateClient(Client client) {
    commonDao.update("UPDATE CLIENT SET UPDATE_DATETIME = ?, NAME = ?, PHONE = ?, EMAIL = ?, SHOP_NAME = ?, SHOP_LINK = ?, REMARK = ? WHERE ID = ?", new Date(),
        client.getClientName(), client.getClientPhone(), client.getClientEmail(), client.getClientShopName(), client.getClientShopLink(),
        client.getClientRemark(), client.getId());
  }

  public void deleteClient(int clientId) {
    commonDao.update("UPDATE CLIENT SET ACTIVE = 0 WHERE ID = ?", clientId);
  }

  public List<Client> getClientList(int ownerId) {
    return commonDao.query(Client.class, "SELECT * FROM CLIENT WHERE ACTIVE = 1 AND OWNER_ID = ? ORDER BY NAME", ownerId);
  }

  public Client getClient(int id) {
    return commonDao.getFirst(Client.class, "SELECT * FROM CLIENT WHERE ID = ?", id);
  }

  public Client getClientByOrder(int orderId) {
    return commonDao.getFirst(Client.class, "SELECT A.* FROM CLIENT A LEFT JOIN ORDERS B ON B.CLIENT_ID = A.ID WHERE B.ID = ?", orderId);
  }

  public void insertClientMessage(ClientMessage clientMessage) {
    Date now = new Date();
    int id = commonDao.insert("INSERT INTO CLIENT_MESSAGE (INSERT_DATETIME, UPDATE_DATETIME, CLIENT_ID, ORDER_ID, MESSAGE) VALUES (?, ?, ?, ?, ?)", now, now,
        clientMessage.getClientId(), clientMessage.getOrderId(), clientMessage.getMessage());
    clientMessage.setId(id);
  }

  public List<ClientMessage> getClientMessageList(int clientId, int orderId) {
    return commonDao.query(ClientMessage.class, "SELECT * FROM CLIENT_MESSAGE WHERE CLIENT_ID = ? AND ORDER_ID = ? ORDER BY INSERT_DATETIME DESC", clientId,
        orderId);
  }

  public int getClientIdByAccountId(int accountId) {
    int clientId = 0;
    Client client = commonDao.getFirst(Client.class, "SELECT * FROM CLIENT WHERE ACCOUNT_ID = ?", accountId);
    if (client != null) {
      clientId = client.getId();
    }
    return clientId;
  }
}
