package com.xiaofo1022.orange9.dao;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Notification;

@Repository
public class NotificationDao {
	@Autowired
	private CommonDao commonDao;
	
	public void insertNotification(Notification notification) {
		Date now = new Date();
		int id = commonDao.insert("INSERT INTO NOTIFICATION (INSERT_DATETIME, UPDATE_DATETIME, SENDER_ID, RECEIVER_ID, MESSAGE) VALUES (?, ?, ?, ?, ?)",
				now, now, notification.getSenderId(), notification.getReceiverId(), notification.getMessage());
		notification.setId(id);
	}
	
	public Notification getNotification(int receiverId) {
		return commonDao.getFirst(Notification.class, "SELECT * FROM NOTIFICATION WHERE RECEIVER_ID = ? AND IS_READ = 0 ORDER BY ID", receiverId);
	}
	
	public void readNotification(int id) {
		commonDao.update("UPDATE NOTIFICATION SET IS_READ = 1, UPDATE_DATETIME = ? WHERE ID = ?", new Date(), id);
	}
}
