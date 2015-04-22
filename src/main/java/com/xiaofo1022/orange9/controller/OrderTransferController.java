package com.xiaofo1022.orange9.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.common.OrderStatusConst;
import com.xiaofo1022.orange9.dao.OrderDao;
import com.xiaofo1022.orange9.dao.OrderStatusDao;
import com.xiaofo1022.orange9.dao.OrderTransferDao;
import com.xiaofo1022.orange9.modal.OrderTransferImage;
import com.xiaofo1022.orange9.modal.OrderTransferImageData;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;
import com.xiaofo1022.orange9.thread.SaveTransferImageThread;
import com.xiaofo1022.orange9.util.RequestUtil;

@Controller
@RequestMapping("/orderTransfer")
public class OrderTransferController {
	@Autowired
	private OrderTransferDao orderTransferDao;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private OrderStatusDao orderStatusDao;
	
	@RequestMapping(value = "/getOrderList", method = RequestMethod.GET)
	@ResponseBody
	public List<OrderTransferImage> getOrderTransferImageList() {
		return orderTransferDao.getOrderTransferImageList();
	}
	
	@RequestMapping(value = "/getTransferImageList/{orderId}", method = RequestMethod.GET)
	@ResponseBody
	public List<OrderTransferImageData> getTransferImageDataListByOrder(@PathVariable int orderId) {
		return orderTransferDao.getTransferImageDataListByOrder(orderId);
	}
	
	@RequestMapping(value = "/uploadTransferImage", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse addOrderTransferImageData(@RequestBody OrderTransferImageData transferImageData, BindingResult bindingResult, HttpServletRequest request) {
		orderTransferDao.insertOrderTransferImageData(transferImageData);
		String serverPath = request.getSession().getServletContext().getRealPath("/");
		transferImageData.setServerPath(serverPath);
		Thread thread = new Thread(new SaveTransferImageThread(transferImageData));
		thread.start();
		return new SuccessResponse("Add Transfer Image Data Success");
	}
	
	@RequestMapping(value = "/setTransferImageIsDone/{orderId}/{tansferId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setTransferImageIsDone(@PathVariable int orderId, @PathVariable int tansferId, HttpServletRequest request) {
		orderTransferDao.setTransferImageIsDone(tansferId, OrderStatusConst.ORDER_TRANSFER_IMAGE_DONE);
		orderStatusDao.updateOrderStatus(orderId, RequestUtil.getLoginUser(request), OrderStatusConst.WAITING_FOR_CLIENT_CHOSE);
		return new SuccessResponse("Set Transfer Image Is Done Success");
	}
	
	@RequestMapping(value = "/setTransferImageSelected/{orderId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setTransferImageSelected(@RequestBody List<Integer> transferImgIdList, BindingResult bindingResult, @PathVariable int orderId, HttpServletRequest request) {
		if (transferImgIdList != null) {
			for (Integer id : transferImgIdList) {
				orderTransferDao.setTransferImageSelected(id);
			}
		}
		orderStatusDao.updateOrderStatus(orderId, RequestUtil.getLoginUser(request), OrderStatusConst.CONVERT_IMAGE);
		return new SuccessResponse("Set Transfer Image Selected Success");
	}
}
