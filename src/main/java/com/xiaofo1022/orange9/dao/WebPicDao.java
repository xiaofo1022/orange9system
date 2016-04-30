package com.xiaofo1022.orange9.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.orange9.dao.common.CommonDao;
import com.xiaofo1022.orange9.modal.WebPic;

@Repository
public class WebPicDao {

  @Autowired
  private CommonDao commonDao;
  
  public int insertWebPic(WebPic webPic) {
    return commonDao.insert("INSERT INTO WEB_PIC (PIC_KEY, PIC_TYPE, PIC_INDEX, IS_FOLDER) VALUES (?, ?, ?, ?)", webPic.getPicKey(), webPic.getPicType(), webPic.getPicIndex(), webPic.getIsFolder());
  }
  
  public List<WebPic> getPicsByType(String picType) {
    return commonDao.query(WebPic.class, "SELECT * FROM WEB_PIC WHERE PIC_TYPE = ? ORDER BY PIC_INDEX", picType);
  }
  
  public List<WebPic> getFolderPics(String picType) {
    return commonDao.query(WebPic.class, "SELECT * FROM WEB_PIC WHERE PIC_TYPE = ? AND IS_FOLDER = 1 ORDER BY PIC_INDEX", picType);
  }
  
  public List<WebPic> getPicsByTypeAndIndex(String picType, int picIndex) {
    return commonDao.query(WebPic.class, "SELECT * FROM WEB_PIC WHERE PIC_TYPE = ? AND PIC_INDEX = ? AND IS_ACTIVE = 1 ORDER BY PIC_INDEX", picType, picIndex);
  }
  
  public List<WebPic> getPicsDetail(String picType, int picIndex) {
    return commonDao.query(WebPic.class, "SELECT * FROM WEB_PIC WHERE PIC_TYPE = ? AND PIC_INDEX = ? AND IS_ACTIVE = 1 AND IS_FOLDER = 0 ORDER BY PIC_INDEX", picType, picIndex);
  }
  
  public int getLastPicIndex(String type) {
    int lastIndex = 0;
    List<WebPic> picIds = commonDao.query(WebPic.class, "SELECT DISTINCT(PIC_INDEX) FROM WEB_PIC WHERE PIC_TYPE = ? ORDER BY PIC_INDEX DESC", type);
    if (picIds != null && picIds.size() > 0) {
      lastIndex = picIds.get(0).getPicIndex();
    }
    return lastIndex;
  }
}
