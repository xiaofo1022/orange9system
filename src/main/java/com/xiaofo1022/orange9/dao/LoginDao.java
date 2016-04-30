package com.xiaofo1022.orange9.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Login;
import com.xiaofo1022.orange9.modal.User;

@Repository
public class LoginDao {
  @Autowired
  private CommonDao commonDao;

  public User getUser(Login login) {
    return commonDao.getFirst(User.class, "SELECT * FROM USER WHERE (ACCOUNT = ? OR PHONE = ?) AND PASSWORD = ?", login.getUsername(), login.getUsername(),
        login.getPassword());
  }
}
