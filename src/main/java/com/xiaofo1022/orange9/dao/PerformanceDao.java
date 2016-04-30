package com.xiaofo1022.orange9.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.Performance;

@Repository
public class PerformanceDao {
  @Autowired
  private CommonDao commonDao;

  public List<Performance> getPerformanceList() {
    return commonDao.query(Performance.class, "SELECT * FROM PERFORMANCE ORDER BY ID");
  }
}
