package com.xiaofo1022.orange9.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.xiaofo1022.orange9.modal.PictureData;
import com.xiaofo1022.orange9.modal.User;
import com.xiaofo1022.orange9.util.RequestUtil;

@Controller
@RequestMapping("/across")
public class AcrossController {
  private RestTemplate restTemplate = new RestTemplate();

  @RequestMapping(value = "/fixskin", method = RequestMethod.POST)
  @ResponseBody
  public boolean acrossFixSkin(@RequestBody PictureData pictureData, HttpServletRequest request) {
    try {
      User user = RequestUtil.getLoginUser(request);
      if (user != null) {
        return restTemplate.postForObject(user.getPicbaseurl() + "saveFixSkinPicture", pictureData, boolean.class);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return false;
  }

  @RequestMapping(value = "/fixbackground", method = RequestMethod.POST)
  @ResponseBody
  public boolean acrossFixBackground(@RequestBody PictureData pictureData, HttpServletRequest request) {
    try {
      User user = RequestUtil.getLoginUser(request);
      if (user != null) {
        return restTemplate.postForObject(user.getPicbaseurl() + "saveFixBackgroundPicture", pictureData, boolean.class);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return false;
  }
}
