package com.xiaofo1022.orange9.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.common.OrderStatusConst;
import com.xiaofo1022.orange9.dao.OrderPostProductionDao;
import com.xiaofo1022.orange9.dao.OrderStatusDao;
import com.xiaofo1022.orange9.dao.OrderVerifyDao;
import com.xiaofo1022.orange9.modal.Count;
import com.xiaofo1022.orange9.modal.Denial;
import com.xiaofo1022.orange9.modal.OrderFixedImageData;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;
import com.xiaofo1022.orange9.util.RequestUtil;

@Controller
@RequestMapping("/orderVerify")
@Transactional
public class OrderVerifyController {
  @Autowired
  private OrderVerifyDao orderVerifyDao;
  @Autowired
  private OrderPostProductionDao orderPostProductionDao;
  @Autowired
  private OrderStatusDao orderStatusDao;

  @RequestMapping(value = "/setOrderVerifier/{orderId}/{userId}", method = RequestMethod.POST)
  @ResponseBody
  public CommonResponse setOrderVerifier(@PathVariable int orderId, @PathVariable int userId, HttpServletRequest request) {
    orderVerifyDao.insertOrderVerifyImage(orderId, userId);
    return new SuccessResponse("Set Order Verifier Success");
  }

  @RequestMapping(value = "/getVerifyImageData/{orderId}", method = RequestMethod.GET)
  @ResponseBody
  public OrderFixedImageData getVerifyImageData(@PathVariable int orderId, HttpServletRequest request) {
    OrderFixedImageData fixedImageData = orderPostProductionDao.getVerifyImageData(orderId);
    Count fixedCount = orderPostProductionDao.getVerifiedImageCount(orderId);
    Count originalCount = orderPostProductionDao.getAllOriginalImageCount(orderId);
    if (fixedCount.getCnt() == originalCount.getCnt()) {
      orderVerifyDao.setVerifyDone(orderId);
      orderStatusDao.updateOrderStatus(orderId, RequestUtil.getLoginUser(request), OrderStatusConst.COMPLETE);
      fixedImageData = new OrderFixedImageData();
      fixedImageData.setAllVerified(true);
    }
    return fixedImageData;
  }

  @RequestMapping(value = "/setImageVerified/{fixedImageId}", method = RequestMethod.POST)
  @ResponseBody
  public CommonResponse setImageVerified(@PathVariable int fixedImageId, HttpServletRequest request) {
    orderVerifyDao.setImageVerified(fixedImageId);
    return new SuccessResponse("Set Image Verified Success");
  }

  @RequestMapping(value = "/setImageDenied", method = RequestMethod.POST)
  @ResponseBody
  public CommonResponse setImageDenied(@RequestBody Denial denial, BindingResult bindingResult, HttpServletRequest request) {
    orderVerifyDao.setImageDenied(denial.getId(), denial.getReason());
    return new SuccessResponse("Set Image Denied Success");
  }
}
