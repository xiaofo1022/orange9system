package com.xiaofo1022.orange9.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.dao.RoleDao;
import com.xiaofo1022.orange9.modal.Role;

@Controller
@RequestMapping("/role")
public class RoleController {
  @Autowired
  private RoleDao roleDao;

  @RequestMapping(value = "/getRoleList", method = RequestMethod.GET)
  @ResponseBody
  public List<Role> getRoleList() {
    return roleDao.getRoleList();
  }
}
