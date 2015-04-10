package com.xiaofo1022.orange9.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.User;

@Repository
public class UserDao {
	@Autowired
	private CommonDao commonDao;
	
	public void insertUser(User user) {
		Date now = new Date();
		int id = commonDao.insert(
			"INSERT INTO USER (NAME, ROLE_ID, ACCOUNT, PASSWORD, SALARY, PERFORMANCE_PAY, HEADER, BOSS_ID, INSERT_DATETIME, UPDATE_DATETIME) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
			user.getName(), user.getRoleId(), user.getAccount(), user.getPassword(), user.getSalary(), user.getPerformancePay(), user.getHeader(), user.getBossId(), now, now);
		user.setId(id);
	}
	
	public User getUserByAccount(String account) {
		return commonDao.getFirst(User.class, "SELECT * FROM USER WHERE ACCOUNT = ?", account);
	}
	
	public List<User> getUserList(int bossId) {
		return commonDao.query(User.class, "SELECT * FROM USER WHERE BOSS_ID = ? AND ACTIVE = 1", bossId);
	}
	
	public void deleteUser(int userId) {
		commonDao.update("UPDATE USER SET ACTIVE = 0 WHERE ID = ?", userId);
	}
}
