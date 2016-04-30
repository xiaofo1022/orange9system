package com.xiaofo1022.orange9.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.dao.WebPicDao;
import com.xiaofo1022.orange9.modal.WebPic;
import com.xiaofo1022.orange9.service.QiniuAuth;

@Controller
@RequestMapping(value="/webpic")
public class WebPicController {

  @Autowired
  private WebPicDao webPicDao;
  @Autowired
  private QiniuAuth qiniuAuth;
  
  @RequestMapping(value="/addWebPic", method=RequestMethod.POST)
  @ResponseBody
  public String addWebPic(@RequestBody List<WebPic> webPics) {
    if (webPics != null && webPics.size() > 0) {
      int picIndex = webPicDao.getLastPicIndex(webPics.get(0).getPicType());
      picIndex++;
      boolean isFirst = true;
      for (WebPic webPic : webPics) {
        if (isFirst) {
          webPic.setIsFolder(1);
          isFirst = false;
        }
        webPic.setPicIndex(picIndex);
        webPicDao.insertWebPic(webPic);
      }
    }
    return "success";
  }
  
  @RequestMapping(value = "/getUpToken", method = RequestMethod.GET)
  @ResponseBody
  public String getUpToken() {
    return qiniuAuth.getUpToken("orange9");
  }
}
