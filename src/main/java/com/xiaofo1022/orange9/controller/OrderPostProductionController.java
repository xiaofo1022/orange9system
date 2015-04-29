package com.xiaofo1022.orange9.controller;

import java.util.List;

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

import com.xiaofo1022.orange9.common.OrderConst;
import com.xiaofo1022.orange9.common.OrderStatusConst;
import com.xiaofo1022.orange9.dao.OrderHistoryDao;
import com.xiaofo1022.orange9.dao.OrderPostProductionDao;
import com.xiaofo1022.orange9.dao.OrderStatusDao;
import com.xiaofo1022.orange9.modal.OrderPostProduction;
import com.xiaofo1022.orange9.modal.OrderTransferImageData;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;
import com.xiaofo1022.orange9.thread.SaveTransferImageThread;
import com.xiaofo1022.orange9.util.RequestUtil;

@Controller
@RequestMapping("/orderPostProduction")
@Transactional
public class OrderPostProductionController {
	@Autowired
	private OrderPostProductionDao postProductionDao;
	@Autowired
	private OrderHistoryDao orderHistoryDao;
	@Autowired
	private OrderStatusDao orderStatusDao;
	
	@RequestMapping(value = "/setFixSkinDone/{orderId}/{userId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setFixSkinDone(@PathVariable int orderId, @PathVariable int userId) {
		List<OrderPostProduction> postProductionDoneList = postProductionDao.setPostProductionDone(OrderConst.TABLE_ORDER_FIX_SKIN, orderId, userId);
		postProductionDao.allotPostProduction(OrderConst.TABLE_ORDER_FIX_BACKGROUND, postProductionDoneList);
		orderHistoryDao.addOrderHistory(orderId, userId, OrderConst.FIX_SKIN_DONE_INFO);
		return new SuccessResponse("Set Fix Skin Done Success");
	}
	
	@RequestMapping(value = "/setFixBackgroundDone/{orderId}/{userId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setFixBackgroundDone(@PathVariable int orderId, @PathVariable int userId) {
		List<OrderPostProduction> postProductionDoneList = postProductionDao.setPostProductionDone(OrderConst.TABLE_ORDER_FIX_BACKGROUND, orderId, userId);
		postProductionDao.allotPostProduction(OrderConst.TABLE_ORDER_CUT_LIQUIFY, postProductionDoneList);
		orderHistoryDao.addOrderHistory(orderId, userId, OrderConst.FIX_BACKGROUND_DONE_INFO);
		return new SuccessResponse("Set Fix Background Done Success");
	}
	
	@RequestMapping(value = "/setCutLiquifyDone/{orderId}/{userId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setCutLiquifyDone(@PathVariable int orderId, @PathVariable int userId, HttpServletRequest request) {
		postProductionDao.setPostProductionDone(OrderConst.TABLE_ORDER_CUT_LIQUIFY, orderId, userId);
		orderHistoryDao.addOrderHistory(orderId, userId, OrderConst.CUT_LIQUIFY_DONE_INFO);
		orderStatusDao.updateOrderStatus(orderId, RequestUtil.getLoginUser(request), OrderStatusConst.WAIT_FOR_VERIFY);
		return new SuccessResponse("Set Cut Liquify Done Success");
	}
	
	@RequestMapping(value = "/uploadFixedImage", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse uploadFixedImage(@RequestBody OrderTransferImageData transferImageData, BindingResult bindingResult, HttpServletRequest request) {
		postProductionDao.insertOrderFixedImageData(transferImageData);
		String serverPath = request.getSession().getServletContext().getRealPath("/");
		transferImageData.setServerPath(serverPath);
		SaveTransferImageThread imageThread = new SaveTransferImageThread(transferImageData);
		imageThread.setIsFixedImage(true);
		Thread thread = new Thread(imageThread);
		thread.start();
		return new SuccessResponse("Upload Fixed Image Data Success");
	}
	
	@RequestMapping(value = "/reuploadFixedImage/{imageId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse reuploadFixedImage(@PathVariable int imageId, @RequestBody OrderTransferImageData transferImageData, BindingResult bindingResult, HttpServletRequest request) {
		transferImageData.setId(imageId);
		postProductionDao.reverifyFixedImageData(transferImageData);
		String serverPath = request.getSession().getServletContext().getRealPath("/");
		transferImageData.setServerPath(serverPath);
		SaveTransferImageThread imageThread = new SaveTransferImageThread(transferImageData);
		imageThread.setIsFixedImage(true);
		Thread thread = new Thread(imageThread);
		thread.start();
		return new SuccessResponse("Reupload Fixed Image Data Success");
	}
}
