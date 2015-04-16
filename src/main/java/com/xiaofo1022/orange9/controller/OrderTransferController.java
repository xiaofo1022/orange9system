package com.xiaofo1022.orange9.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.dao.OrderTransferDao;
import com.xiaofo1022.orange9.modal.OrderTransferImage;
import com.xiaofo1022.orange9.modal.OrderTransferImageData;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;
import com.xiaofo1022.orange9.thread.SaveTransferImageThread;

@Controller
@RequestMapping("/orderTransfer")
public class OrderTransferController {
	@Autowired
	private OrderTransferDao orderTransferDao;
	
	@RequestMapping(value = "/getOrderList", method = RequestMethod.GET)
	@ResponseBody
	public List<OrderTransferImage> getOrderTransferImageList() {
		return orderTransferDao.getOrderTransferImageList();
	}
	
	@RequestMapping(value = "/uploadTransferImage", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse addOrderTransferImageData(@RequestBody OrderTransferImageData transferImageData, BindingResult bindingResult) {
		orderTransferDao.insertOrderTransferImageData(transferImageData);
		Thread thread = new Thread(new SaveTransferImageThread(transferImageData));
		thread.start();
		return new SuccessResponse("Add Transfer Image Data Success");
	}
}
