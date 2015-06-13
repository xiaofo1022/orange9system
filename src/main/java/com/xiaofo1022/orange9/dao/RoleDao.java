package com.xiaofo1022.orange9.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Role;

@Repository
public class RoleDao {
	@Autowired
	private CommonDao commonDao;
	
	public List<Role> getRoleList() {
		return commonDao.query(Role.class, "SELECT * FROM ROLE WHERE IS_SHOW = 1");
	}
	
	public Role getRole(int roleId) {
		return commonDao.getFirst(Role.class, "SELECT * FROM ROLE WHERE ID = ?", roleId);
	}
}
