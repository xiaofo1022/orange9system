package com.xiaofo1022.orange9.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.common.Message;
import com.xiaofo1022.orange9.common.OrderConst;
import com.xiaofo1022.orange9.common.OrderStatusConst;
import com.xiaofo1022.orange9.common.RoleConst;
import com.xiaofo1022.orange9.common.TimeLimitConst;
import com.xiaofo1022.orange9.dao.ClientDao;
import com.xiaofo1022.orange9.dao.ClockInDao;
import com.xiaofo1022.orange9.dao.IndexDao;
import com.xiaofo1022.orange9.dao.LoginDao;
import com.xiaofo1022.orange9.dao.OrderConvertDao;
import com.xiaofo1022.orange9.dao.OrderDao;
import com.xiaofo1022.orange9.dao.OrderGoodsDao;
import com.xiaofo1022.orange9.dao.OrderPostProductionDao;
import com.xiaofo1022.orange9.dao.OrderTimeLimitDao;
import com.xiaofo1022.orange9.dao.OrderTransferDao;
import com.xiaofo1022.orange9.dao.OrderVerifyDao;
import com.xiaofo1022.orange9.dao.RoleDao;
import com.xiaofo1022.orange9.dao.UserDao;
import com.xiaofo1022.orange9.dao.WebPicDao;
import com.xiaofo1022.orange9.modal.ClockIn;
import com.xiaofo1022.orange9.modal.Login;
import com.xiaofo1022.orange9.modal.Order;
import com.xiaofo1022.orange9.modal.OrderFixedImageData;
import com.xiaofo1022.orange9.modal.OrderVerifyImage;
import com.xiaofo1022.orange9.modal.Password;
import com.xiaofo1022.orange9.modal.User;
import com.xiaofo1022.orange9.modal.WebPic;
import com.xiaofo1022.orange9.modal.WebPicModal;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.FailureResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;
import com.xiaofo1022.orange9.util.RequestUtil;

@Controller("mainController")
public class MainController {
  @Autowired
  private LoginDao loginDao;
  @Autowired
  private UserDao userDao;
  @Autowired
  private ClockInDao clockInDao;
  @Autowired
  private ClientDao clientDao;
  @Autowired
  private OrderTimeLimitDao orderTimeLimitDao;
  @Autowired
  private OrderDao orderDao;
  @Autowired
  private OrderConvertDao orderConvertDao;
  @Autowired
  private OrderPostProductionDao orderPostProductionDao;
  @Autowired
  private OrderVerifyDao orderVerifyDao;
  @Autowired
  private OrderGoodsDao orderGoodsDao;
  @Autowired
  private OrderTransferDao orderTransferDao;
  @Autowired
  private RoleDao roleDao;
  @Autowired
  private UserController userController;
  @Autowired
  private IndexDao indexDao;
  @Autowired
  private WebPicDao webPicDao;
  
  @RequestMapping(value = "/", method = RequestMethod.GET)
  public String index(HttpServletRequest request, ModelMap modelMap) {
    modelMap.addAttribute("path", "enu");
    indexDao.createIndexModalMap(request, "enu", modelMap);
    return "lufter/page/pag";
  }

  @RequestMapping(value = "/enu", method = RequestMethod.GET)
  public String enu(HttpServletRequest request, ModelMap modelMap) {
    modelMap.addAttribute("path", "enu");
    indexDao.createIndexModalMap(request, "enu", modelMap);
    return "lufter/page/pag";
  }

  @RequestMapping(value = "/jnk", method = RequestMethod.GET)
  public String jnk(HttpServletRequest request, ModelMap modelMap) {
    modelMap.addAttribute("path", "jnk");
    indexDao.createIndexModalMap(request, "jnk", modelMap);
    return "lufter/page/pag";
  }

  @RequestMapping(value = "/sta", method = RequestMethod.GET)
  public String sta(HttpServletRequest request, ModelMap modelMap) {
    modelMap.addAttribute("path", "sta");
    indexDao.createIndexModalMap(request, "sta", modelMap);
    return "lufter/page/pag";
  }

  @RequestMapping(value = "/tog", method = RequestMethod.GET)
  public String tog(HttpServletRequest request, ModelMap modelMap) {
    modelMap.addAttribute("path", "tog");
    indexDao.createIndexModalMap(request, "tog", modelMap);
    return "lufter/page/pag";
  }

  @RequestMapping(value = "/picdetail/{type}/{picindex}", method = RequestMethod.GET)
  public String picdetail(@PathVariable String type, @PathVariable String picindex, HttpServletRequest request, ModelMap modelMap) {
    modelMap.addAttribute("path", type);
    modelMap.addAttribute("pictureList", webPicDao.getPicsDetail(type, Integer.valueOf(picindex)));
    return "lufter/page/detail";
  }

  @RequestMapping(value = "/lgn", method = RequestMethod.GET)
  public String lgn() {
    return "lufter/page/lgn";
  }

  @RequestMapping(value = "/logout", method = RequestMethod.GET)
  @ResponseBody
  public String logout(HttpServletRequest request) {
    HttpSession session = request.getSession(false);
    if (session != null) {
      session.removeAttribute("user");
      session.invalidate();
    }
    return "/lgn";
  }

  @RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
  @ResponseBody
  public CommonResponse resetPassword(@ModelAttribute("password") Password password, HttpServletRequest request) {
    User user = RequestUtil.getLoginUser(request);
    if (user != null) {
      if (!user.getPassword().equals(password.getOldPassword())) {
        return new FailureResponse("Wrong old password!");
      }
      userDao.updatePassword(user.getId(), password.getNewPassword());
    }
    return new SuccessResponse("Reset password success!");
  }

  @RequestMapping(value = "/login", method = RequestMethod.POST)
  @ResponseBody
  public CommonResponse login(@ModelAttribute("login") Login login, BindingResult result, HttpServletRequest request) {
    User user = loginDao.getUser(login);
    if (user == null) {
      return new FailureResponse(Message.LOGIN_FAILURE);
    } else {
      this.initUserInfo(user);
      request.getSession(true).setAttribute("user", user);
      if (user.getRoleId() == RoleConst.CLIENT_ID) {
        return new SuccessResponse(Message.LOGIN_SUCCESS, "client/list/" + clientDao.getClientIdByAccountId(user.getId()));
      } else {
        return new SuccessResponse(Message.LOGIN_SUCCESS, "orderSummary");
      }
    }
  }

  private void initUserInfo(User user) {
    clockInDao.clockIn(user.getId());
    ClockIn clockIn = clockInDao.getEmployeeClockIn(user.getId());
    if (clockIn != null) {
      user.setLoginTime(clockIn.getClockDatetime());
    }
    user.setRole(roleDao.getRole(user.getRoleId()));
  }

  @RequestMapping(value = "/indexmanage/{type}", method = RequestMethod.GET)
  public String indexmanage(@PathVariable String type, HttpServletRequest request, ModelMap modelMap) {
    int startIndex = 0;
    int picIndex = webPicDao.getLastPicIndex(type);
    List<WebPicModal> webPics = new ArrayList<WebPicModal>();
    while (startIndex < picIndex) {
      startIndex++;
      List<WebPic> pics = webPicDao.getPicsByTypeAndIndex(type, startIndex);
      if (pics != null && pics.size() > 0) {
        WebPicModal picModal = new WebPicModal();
        picModal.setIndex(startIndex);
        picModal.setType(type);
        picModal.setFolderPic(pics.get(0));
        picModal.setWebPics(pics);
        webPics.add(picModal);
      }
    }
    modelMap.put("pictype", type);
    modelMap.put("webpics", webPics);
    return "lufter/indexmanage";
  }

  @RequestMapping(value = "/employee", method = RequestMethod.GET)
  public String employee(HttpServletRequest request, ModelMap modelMap) {
    modelMap.addAttribute("userDetailList", userController.getUserDetailList(request));
    return "lufter/employeemanage";
  }

  @RequestMapping(value = "/orderSummary", method = RequestMethod.GET)
  public String system2ordersummary(HttpServletRequest request, ModelMap modelMap) {
    User user = RequestUtil.getLoginUser(request);
    if (user != null) {
      modelMap.addAttribute("modelNameList", orderDao.getModelNameList(user.getBossId()));
      modelMap.addAttribute("dresserNameList", orderDao.getDresserNameList(user.getBossId()));
      modelMap.addAttribute("stylistNameList", orderDao.getStylistNameList(user.getBossId()));
      modelMap.addAttribute("brokerList", orderDao.getBrokerList(user.getBossId()));
    }
    return "lufter/main";
  }

  @RequestMapping(value = "/orderGoods", method = RequestMethod.GET)
  public String system2ordergoods(HttpServletRequest request, ModelMap modelMap) {
    User user = RequestUtil.getLoginUser(request);
    if (user != null) {
      modelMap.addAttribute("orderNoList", orderDao.getOrderNoList(user.getBossId()));
      modelMap.addAttribute("orderGoodsList", orderGoodsDao.getOrderGoodsList(user.getBossId()));
    }
    return "lufter/goodsmanage";
  }

  @RequestMapping(value = "/client", method = RequestMethod.GET)
  public String client(HttpServletRequest request, ModelMap modelMap) {
    User loginUser = RequestUtil.getLoginUser(request);
    if (loginUser != null) {
      modelMap.addAttribute("clientList", clientDao.getClientList(loginUser.getBossId()));
    }
    return "lufter/clientmanage";
  }

  @RequestMapping(value = "/shooting", method = RequestMethod.GET)
  public String system2shoot(HttpServletRequest request, ModelMap modelMap) {
    User loginUser = RequestUtil.getLoginUser(request);
    if (loginUser != null) {
      modelMap.addAttribute("orderShootList", orderDao.getOrderListByStatus(OrderStatusConst.SHOOTING, loginUser.getBossId()));
      modelMap.addAttribute("limitMinutes", orderTimeLimitDao.getTimeLimit(TimeLimitConst.SHOOT_ID).getLimitMinutes());
    }
    return "lufter/ordershooting";
  }

  @RequestMapping(value = "/transferImage", method = RequestMethod.GET)
  public String system2transferimage(HttpServletRequest request, ModelMap modelMap) {
    User loginUser = RequestUtil.getLoginUser(request);
    if (loginUser != null) {
      modelMap.addAttribute("limitMinutes", orderTimeLimitDao.getTimeLimit(TimeLimitConst.TRANSFER_ID).getLimitMinutes());
      modelMap.addAttribute("orderTransferList", orderTransferDao.getOrderTransferImageList(loginUser.getBossId()));
    }
    return "lufter/orderuploadoriginal";
  }

  @RequestMapping(value = "/clientWaiting", method = RequestMethod.GET)
  public String system2clientwaiting(HttpServletRequest request, ModelMap map) {
    User loginUser = RequestUtil.getLoginUser(request);
    if (loginUser != null) {
      map.addAttribute("orderList", orderDao.getOrderListByStatus(OrderStatusConst.WAITING_FOR_CLIENT_CHOSE, loginUser.getBossId()));
    }
    return "lufter/orderclientchosen";
  }

  @RequestMapping(value = "/convertImage", method = RequestMethod.GET)
  public String convertImage(HttpServletRequest request, ModelMap modelMap) {
    User loginUser = RequestUtil.getLoginUser(request);
    if (loginUser != null) {
      modelMap.addAttribute("orderConvertList", orderConvertDao.getOrderConvertList(request, loginUser.getBossId()));
      modelMap.addAttribute("designerList", userDao.getUserListByRoleId(RoleConst.DESIGNER_ID, loginUser.getBossId()));
      modelMap.addAttribute("limitMinutes", orderTimeLimitDao.getTimeLimit(TimeLimitConst.CONVERT_ID).getLimitMinutes());
    }
    return "lufter/orderconvertimage";
  }

  @RequestMapping(value = "/fixSkin", method = RequestMethod.GET)
  public String system2fixskin(HttpServletRequest request, ModelMap modelMap) {
    User loginUser = RequestUtil.getLoginUser(request);
    if (loginUser != null) {
      modelMap.addAttribute("designerList", userDao.getUserListByRoleId(RoleConst.DESIGNER_ID, loginUser.getBossId()));
      modelMap.addAttribute("unAllotOrderList",
          orderPostProductionDao.getUnAllotOrderList(loginUser.getBossId(), OrderConst.COLUMN_FIXED_SKIN, OrderConst.COLUMN_FIXED_SKIN_OPERATOR));
      modelMap.addAttribute("postProductionList",
          orderPostProductionDao.getPostProductionListByTransfer(OrderConst.COLUMN_FIXED_SKIN, OrderConst.COLUMN_FIXED_SKIN_OPERATOR, loginUser.getBossId()));
    }
    return "lufter/orderfixskin";
  }

  @RequestMapping(value = "/fixBackground", method = RequestMethod.GET)
  public String system2fixbackground(HttpServletRequest request, ModelMap modelMap) {
    User loginUser = RequestUtil.getLoginUser(request);
    if (loginUser != null) {
      modelMap.addAttribute("designerList", userDao.getUserListByRoleId(RoleConst.DESIGNER_ID, loginUser.getBossId()));
      modelMap.addAttribute("unAllotOrderList",
          orderPostProductionDao.getUnAllotOrderList(loginUser.getBossId(), OrderConst.COLUMN_FIXED_BACKGROUND, OrderConst.COLUMN_FIXED_BACKGROUND_OPERATOR));
      modelMap.addAttribute("postProductionList", orderPostProductionDao.getPostProductionListByTransfer(OrderConst.COLUMN_FIXED_BACKGROUND,
          OrderConst.COLUMN_FIXED_BACKGROUND_OPERATOR, loginUser.getBossId()));
    }
    return "lufter/orderfixbackground";
  }

  @RequestMapping(value = "/cutLiquify", method = RequestMethod.GET)
  public String system2cutliquify(HttpServletRequest request, ModelMap modelMap) {
    User loginUser = RequestUtil.getLoginUser(request);
    if (loginUser != null) {
      modelMap.addAttribute("designerList", userDao.getUserListByRoleId(RoleConst.DESIGNER_ID, loginUser.getBossId()));
      modelMap.addAttribute("unAllotOrderList",
          orderPostProductionDao.getUnAllotOrderList(loginUser.getBossId(), OrderConst.COLUMN_CUT_LIQUIFY, OrderConst.COLUMN_CUT_LIQUIFY_OPERATOR));
      modelMap.addAttribute("postProductionList",
          orderPostProductionDao.getPostProductionListByTransfer(OrderConst.COLUMN_CUT_LIQUIFY, OrderConst.COLUMN_CUT_LIQUIFY_OPERATOR, loginUser.getBossId()));
    }
    return "lufter/ordercutliquify";
  }

  @RequestMapping(value = "/uploadFixed", method = RequestMethod.GET)
  public String uploadFixed(HttpServletRequest request, ModelMap modelMap) {
    User loginUser = RequestUtil.getLoginUser(request);
    if (loginUser != null) {
      modelMap.addAttribute("postProductionList", orderPostProductionDao.getUploadFixedImageOrderList(loginUser.getBossId(), request));
    }
    return "lufter/uploadfixedimage";
  }

  @RequestMapping(value = "/verifyImage", method = RequestMethod.GET)
  public String system2verifyimage(HttpServletRequest request, ModelMap modelMap) {
    User loginUser = RequestUtil.getLoginUser(request);
    if (loginUser != null) {
      List<Order> orderList = orderDao.getOrderListByStatus(OrderStatusConst.WAIT_FOR_VERIFY, loginUser.getBossId());
      List<OrderVerifyImage> orderVerifyList = new ArrayList<OrderVerifyImage>(orderList.size());
      if (orderList != null && orderList.size() > 0) {
        for (Order order : orderList) {
          OrderVerifyImage verifyImage = orderVerifyDao.getOrderVerifyImage(order.getId());
          if (verifyImage == null) {
            verifyImage = new OrderVerifyImage();
            verifyImage.setOrderNo(order.getOrderNo());
            verifyImage.setOrderId(order.getId());
          }
          List<OrderFixedImageData> fixedImageDataList = orderPostProductionDao.getOrderFixedImageDataList(order.getId());
          if (fixedImageDataList != null && fixedImageDataList.size() > 0) {
            verifyImage.setFixedImageDataList(fixedImageDataList);
            int verifyCount = 0;
            int verifiedCount = 0;
            int deniedCount = 0;
            for (OrderFixedImageData fixedImageData : fixedImageDataList) {
              if (fixedImageData.getIsVerified() == 1) {
                verifiedCount++;
              } else {
                if (fixedImageData.getReason() == null) {
                  verifyCount++;
                } else {
                  deniedCount++;
                }
              }
            }
            verifyImage.setDeniedCount(deniedCount);
            verifyImage.setVerifyCount(verifyCount);
            verifyImage.setVerifiedCount(verifiedCount);
          }
          orderVerifyList.add(verifyImage);
        }
      }
      modelMap.addAttribute("userList", userDao.getUserList(loginUser.getBossId()));
      modelMap.addAttribute("orderVerifyList", orderVerifyList);
    }
    return "lufter/orderverify";
  }

  @RequestMapping(value = "/leaveRequest", method = RequestMethod.GET)
  public String leaveRequest(HttpServletRequest request, ModelMap modelMap) {
    User loginUser = RequestUtil.getLoginUser(request);
    if (loginUser != null) {
      modelMap.addAttribute("leaveRequestList", clockInDao.getUnconfirmLeaveRequestList());
    }
    return "lufter/leaverequest";
  }
}
