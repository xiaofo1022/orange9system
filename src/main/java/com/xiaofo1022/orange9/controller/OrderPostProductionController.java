package com.xiaofo1022.orange9.controller;

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
import com.xiaofo1022.orange9.modal.OrderTransferImageData;
import com.xiaofo1022.orange9.modal.User;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;
import com.xiaofo1022.orange9.thread.SaveTransferImageThread;
import com.xiaofo1022.orange9.thread.TaskExecutor;
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
	@Autowired
	private OrderVerifyDao orderVerifyDao;
	@Autowired
	private TaskExecutor taskExecutor;
	@Autowired
	private PictureController pictureController;
	
	@RequestMapping(value = "/setFixSkinDone/{orderId}/{fileName}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setFixSkinDone(@PathVariable int orderId, @PathVariable String fileName) {
		// TODO If Chinese character, use json.
		if (postProductionDao.isSelectedPicture(orderId, fileName)) {
			postProductionDao.setFixPostImageDone(OrderConst.COLUMN_FIXED_SKIN, orderId, fileName);
		}
		return new SuccessResponse("Set Fix Skin Done Success");
	}
	
	@RequestMapping(value = "/setFixSkinNextStep/{orderId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setFixSkinNextStep(@PathVariable int orderId, HttpServletRequest request) {
		User loginUser = RequestUtil.getLoginUser(request);
		if (loginUser != null) {
			if (postProductionDao.isAllPictureFixed(orderId, OrderConst.COLUMN_FIXED_SKIN)) {
				postProductionDao.setPostProductionDone(orderId, OrderConst.TABLE_ORDER_FIX_SKIN);
				postProductionDao.allotPostProduction(OrderConst.TABLE_ORDER_FIX_BACKGROUND, orderId, loginUser.getBossId());
				pictureController.clearPreStepPictures(orderId, OrderConst.PATH_ORIGINAL, request);
			}
		}
		return new SuccessResponse("Set Fix Skin Next Step Success");
	}
	
	@RequestMapping(value = "/setFixBackgroundDone/{orderId}/{fileName}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setFixBackgroundDone(@PathVariable int orderId, @PathVariable String fileName) {
		if (postProductionDao.isSelectedPicture(orderId, fileName)) {
			postProductionDao.setFixPostImageDone(OrderConst.COLUMN_FIXED_BACKGROUND, orderId, fileName);
		}
		return new SuccessResponse("Set Fix Background Done Success");
	}
	
	@RequestMapping(value = "/setFixBackgroundNextStep/{orderId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setFixBackgroundNextStep(@PathVariable int orderId, HttpServletRequest request) {
		User loginUser = RequestUtil.getLoginUser(request);
		if (loginUser != null) {
			if (postProductionDao.isAllPictureFixed(orderId, OrderConst.COLUMN_FIXED_BACKGROUND)) {
				postProductionDao.setPostProductionDone(orderId, OrderConst.TABLE_ORDER_FIX_BACKGROUND);
				postProductionDao.allotPostProduction(OrderConst.TABLE_ORDER_CUT_LIQUIFY, orderId, loginUser.getBossId());
				pictureController.clearPreStepPictures(orderId, OrderConst.PATH_FIX_SKIN, request);
			}
		}
		return new SuccessResponse("Set Fix Background Next Step Success");
	}
	
	@RequestMapping(value = "/setCutLiquifyDone/{orderId}/{fileName}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setCutLiquifyDone(@PathVariable int orderId, @PathVariable String fileName, HttpServletRequest request) {
		if (postProductionDao.isSelectedPicture(orderId, fileName)) {
			postProductionDao.setFixPostImageDone(OrderConst.COLUMN_CUT_LIQUIFY, orderId, fileName);
		}
		return new SuccessResponse("Set Cut Liquify Done Success");
	}
	
	@RequestMapping(value = "/setCutLiquifyNextStep/{orderId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setCutLiquifyNextStep(@PathVariable int orderId, HttpServletRequest request) {
		if (postProductionDao.isAllPictureFixed(orderId)) {
			postProductionDao.setPostProductionDone(orderId, OrderConst.TABLE_ORDER_CUT_LIQUIFY);
			pictureController.clearPreStepPictures(orderId, OrderConst.PATH_FIX_BACKGROUND, request);
			orderStatusDao.updateOrderStatus(orderId, RequestUtil.getLoginUser(request), OrderStatusConst.WAIT_FOR_VERIFY);
			orderVerifyDao.insertOrderVerifyImage(orderId, 0);
		}
		return new SuccessResponse("Set Cut Liquify Next Step Success");
	}
	
	@RequestMapping(value = "/uploadFixedImage", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse uploadFixedImage(@RequestBody OrderTransferImageData transferImageData, BindingResult bindingResult, HttpServletRequest request) {
		if (postProductionDao.isSelectedPicture(transferImageData.getOrderId(), transferImageData.getFileName())) {
			postProductionDao.insertOrderFixedImageData(transferImageData);
			String serverPath = request.getSession().getServletContext().getRealPath("/");
			transferImageData.setServerPath(serverPath);
			SaveTransferImageThread imageThread = new SaveTransferImageThread(transferImageData);
			imageThread.setIsFixedImage(true);
			taskExecutor.execute(imageThread);
		}
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
		pictureController.getFixedImageZipPackage(orderId, request, response);
	}
}
