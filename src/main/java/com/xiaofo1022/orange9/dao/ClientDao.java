package com.xiaofo1022.orange9.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Client;

@Repository
public class ClientDao {
	@Autowired
	private CommonDao commonDao;
	
	public void insertClient(Client client) {
		Date now = new Date();
		int id = commonDao.insert("INSERT INTO CLIENT (INSERT_DATETIME, UPDATE_DATETIME, NAME, PHONE, EMAIL, SHOP_NAME, SHOP_LINK, REMARK) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", 
			now, now, client.getClientName(), client.getClientPhone(), client.getClientEmail(), client.getClientShopName(), client.getClientShopLink(), client.getClientRemark());
		client.setId(id);
	}
	
	public List<Client> getClientList() {
		return commonDao.query(Client.class, "SELECT * FROM CLIENT WHERE ACTIVE = 1 ORDER BY NAME");
	}
}
