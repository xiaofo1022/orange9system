package com.xiaofo1022.orange9.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.xiaofo1022.orange9.dao.OrderVerifyDao;
import com.xiaofo1022.orange9.modal.OrderFixedImageData;
import com.xiaofo1022.orange9.modal.OrderPostProduction;
import com.xiaofo1022.orange9.modal.OrderTransferImageData;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;
import com.xiaofo1022.orange9.thread.SaveTransferImageThread;
import com.xiaofo1022.orange9.thread.TaskExecutor;
import com.xiaofo1022.orange9.util.RequestUtil;
import com.xiaofo1022.orange9.util.ZipUtil;

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
	@Autowired
	private OrderVerifyDao orderVerifyDao;
	@Autowired
	private TaskExecutor taskExecutor;
	
	@RequestMapping(value = "/setFixSkinDone/{orderId}/{fileName}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setFixSkinDone(@PathVariable int orderId, @PathVariable String fileName) {
		// TODO If Chinese character, use json.
		postProductionDao.setPostProductionDone(OrderConst.TABLE_ORDER_FIX_SKIN, orderId, fileName);
		if (postProductionDao.isAllPictureFixed(orderId, OrderConst.TABLE_ORDER_FIX_SKIN)) {
			List<OrderPostProduction> postProductionDoneList = postProductionDao.getPostProductionListByOrderId(OrderConst.TABLE_ORDER_FIX_SKIN, orderId);
			postProductionDao.allotPostProduction(OrderConst.TABLE_ORDER_FIX_BACKGROUND, postProductionDoneList);
		}
		return new SuccessResponse("Set Fix Skin Done Success");
	}
	
	@RequestMapping(value = "/setFixBackgroundDone/{orderId}/{fileName}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setFixBackgroundDone(@PathVariable int orderId, @PathVariable String fileName) {
		postProductionDao.setPostProductionDone(OrderConst.TABLE_ORDER_FIX_BACKGROUND, orderId, fileName);
		if (postProductionDao.isAllPictureFixed(orderId, OrderConst.TABLE_ORDER_FIX_BACKGROUND)) {
			List<OrderPostProduction> postProductionDoneList = postProductionDao.getPostProductionListByOrderId(OrderConst.TABLE_ORDER_FIX_BACKGROUND, orderId);
			postProductionDao.allotPostProduction(OrderConst.TABLE_ORDER_CUT_LIQUIFY, postProductionDoneList);
		}
		return new SuccessResponse("Set Fix Background Done Success");
	}
	
	@RequestMapping(value = "/setCutLiquifyDone/{orderId}/{fileName}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setCutLiquifyDone(@PathVariable int orderId, @PathVariable String fileName, HttpServletRequest request) {
		postProductionDao.setPostProductionDone(OrderConst.TABLE_ORDER_CUT_LIQUIFY, orderId, fileName);
		if (postProductionDao.isAllPictureFixed(orderId)) {
			orderStatusDao.updateOrderStatus(orderId, RequestUtil.getLoginUser(request), OrderStatusConst.WAIT_FOR_VERIFY);
			orderVerifyDao.insertOrderVerifyImage(orderId, 0);
		}
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
		taskExecutor.execute(imageThread);
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
		taskExecutor.execute(imageThread);
		return new SuccessResponse("Reupload Fixed Image Data Success");
	}
	
	@RequestMapping(value = "/getFixedImageZipPackage/{orderId}", method = RequestMethod.GET)
	public void getFixedImageZipPackage(@PathVariable int orderId, HttpServletRequest request, HttpServletResponse response) {
		List<OrderFixedImageData> imageList = postProductionDao.getOrderFixedImageDataList(orderId);
		if (imageList != null && imageList.size() > 0) {
			String serverPath = request.getSession().getServletContext().getRealPath("/");
			String fixedPath = serverPath + "\\WEB-INF\\pictures\\fixed\\";
			List<File> fileList = new ArrayList<File>(imageList.size());
			for (OrderFixedImageData imageData : imageList) {
				fileList.add(new File(fixedPath + "\\" + imageData.getOrderId() + "\\" + imageData.getId() + ".jpg"));
			}
			ZipUtil.downloadZipFile(fileList, response);
		}
	}
}
