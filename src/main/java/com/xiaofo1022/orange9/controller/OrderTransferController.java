package com.xiaofo1022.orange9.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.dao.OrderTransferDao;
import com.xiaofo1022.orange9.modal.OrderTransferImage;

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
}
