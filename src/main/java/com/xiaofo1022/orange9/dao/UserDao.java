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
			"INSERT INTO USER (NAME, ROLE_ID, ACCOUNT, PASSWORD, SALARY, PERFORMANCE_PAY, HEADER, BOSS_ID, INSERT_DATETIME, UPDATE_DATETIME, PHONE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
			user.getName(), user.getRoleId(), user.getAccount(), user.getPassword(), user.getSalary(), user.getPerformancePay(), user.getHeader(), user.getBossId(), now, now, user.getPhone());
		user.setId(id);
	}
	
	public User getUserByAccount(String account) {
		return commonDao.getFirst(User.class, "SELECT * FROM USER WHERE ACCOUNT = ?", account);
	}
	
	public User getUserByPhone(String phone) {
		return commonDao.getFirst(User.class, "SELECT * FROM USER WHERE PHONE = ?", phone);
	}
	
	public void updateUserPhone(int userId, String phone) {
		commonDao.update("UPDATE USER SET PHONE = ? WHERE ID = ?", phone, userId);
	}
	
	public User getUserById(int id) {
		return commonDao.getFirst(User.class, "SELECT * FROM USER WHERE ID = ?", id);
	}
	
	public List<User> getUserList() {
		return commonDao.query(User.class, "SELECT A.* FROM USER A LEFT JOIN ROLE B ON A.ROLE_ID = B.ID WHERE A.ACTIVE = 1 AND B.IS_SHOW = 1");
	}
	
	public List<User> getUserList(int bossId) {
		return commonDao.query(User.class, "SELECT * FROM USER WHERE BOSS_ID = ? AND ACTIVE = 1", bossId);
	}
	
	public List<User> getUserListByRoleId(int roleId) {
		return commonDao.query(User.class, "SELECT * FROM USER WHERE ROLE_ID = ? AND ACTIVE = 1", roleId);
	}
	
	public void updateUser(User user) {
		commonDao.update("UPDATE USER SET UPDATE_DATETIME = ?, NAME = ?, ROLE_ID = ?, PHONE = ?, SALARY = ?, PERFORMANCE_PAY = ? WHERE ID = ?",
			new Date(), user.getName(), user.getRoleId(), user.getPhone(), user.getSalary(), user.getPerformancePay(), user.getId());
	}
	
	public void deleteUser(int userId) {
		commonDao.update("UPDATE USER SET ACTIVE = 0, UPDATE_DATETIME = ? WHERE ID = ?", new Date(), userId);
	}
	
	public void updatePassword(int userId, String password) {
		commonDao.update("UPDATE USER SET PASSWORD = ? WHERE ID = ?", password, userId);
	}
}
