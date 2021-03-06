package com.xiaofo1022.orange9.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.common.OrderStatusConst;
import com.xiaofo1022.orange9.dao.OrderConvertDao;
import com.xiaofo1022.orange9.dao.OrderStatusDao;
import com.xiaofo1022.orange9.modal.User;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;
import com.xiaofo1022.orange9.util.RequestUtil;

@Controller
@RequestMapping("/orderConvert")
@Transactional
public class OrderConvertController {
  @Autowired
  private OrderConvertDao orderConvertDao;
  @Autowired
  private OrderStatusDao orderStatusDao;

  @RequestMapping(value = "/setOrderConvertor/{orderId}/{userId}", method = RequestMethod.POST)
  @ResponseBody
  public CommonResponse setOrderConvertor(@PathVariable int orderId, @PathVariable int userId, HttpServletRequest request) {
    orderConvertDao.insertOrderConvert(orderId, userId);
    return new SuccessResponse("Set Order Convertor Success");
  }

  @RequestMapping(value = "/setOrderConvertDone/{orderId}/{convertId}", method = RequestMethod.POST)
  @ResponseBody
  public CommonResponse setOrderConvertDone(@PathVariable int orderId, @PathVariable int convertId, HttpServletRequest request) {
    User loginUser = RequestUtil.getLoginUser(request);
    if (loginUser != null) {
      orderConvertDao.setOrderConvertDone(convertId);
      orderStatusDao.updateOrderStatus(orderId, RequestUtil.getLoginUser(request), OrderStatusConst.POST_PRODUCTION);
    }
    return new SuccessResponse("Set Order Convert Done Success");
  }
}
