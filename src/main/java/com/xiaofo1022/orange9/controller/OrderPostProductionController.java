package com.xiaofo1022.orange9.controller;

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
import com.xiaofo1022.orange9.core.ImageDiskSaver;
import com.xiaofo1022.orange9.dao.OrderHistoryDao;
import com.xiaofo1022.orange9.dao.OrderPostProductionDao;
import com.xiaofo1022.orange9.dao.OrderStatusDao;
import com.xiaofo1022.orange9.dao.OrderVerifyDao;
import com.xiaofo1022.orange9.modal.AllotImage;
import com.xiaofo1022.orange9.modal.Denial;
import com.xiaofo1022.orange9.modal.OrderTransferImageData;
import com.xiaofo1022.orange9.modal.User;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.FailureResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;
import com.xiaofo1022.orange9.thread.ClearDiskThread;
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
	
	@RequestMapping(value = "/setFixSkinDone/{orderId}/{operatorId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setFixSkinDone(@PathVariable int orderId, @PathVariable int operatorId, HttpServletRequest request) {
		User loginUser = RequestUtil.getLoginUser(request);
		if (loginUser != null) {
			postProductionDao.setFixPostImageDone(OrderConst.COLUMN_FIXED_SKIN, OrderConst.COLUMN_FIXED_SKIN_OPERATOR, orderId, operatorId);
		}
		return new SuccessResponse("Set Fix Skin Done Success");
	}
	
	@RequestMapping(value = "/setFixSkinNextStep/{orderId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setFixSkinNextStep(@PathVariable int orderId, HttpServletRequest request) {
		User loginUser = RequestUtil.getLoginUser(request);
		if (loginUser != null) {
			postProductionDao.setFixPostImageDone(OrderConst.COLUMN_FIXED_SKIN, orderId);
			postProductionDao.setPostProductionDone(orderId, OrderConst.TABLE_ORDER_FIX_SKIN);
			postProductionDao.allotPostProduction(OrderConst.TABLE_ORDER_CUT_LIQUIFY, orderId, loginUser.getBossId());
			taskExecutor.execute(new ClearDiskThread(orderId, OrderConst.PATH_FIX_BACKGROUND, request));
		}
		return new SuccessResponse("Set Fix Skin Next Step Success");
	}
	
	@RequestMapping(value = "/setFixBackgroundDone/{orderId}/{operatorId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setFixBackgroundDone(@PathVariable int orderId, @PathVariable int operatorId, HttpServletRequest request) {
		User loginUser = RequestUtil.getLoginUser(request);
		if (loginUser != null) {
			postProductionDao.setFixPostImageDone(OrderConst.COLUMN_FIXED_BACKGROUND, OrderConst.COLUMN_FIXED_BACKGROUND_OPERATOR, orderId, operatorId);
		}
		return new SuccessResponse("Set Fix Background Done Success");
	}
	
	@RequestMapping(value = "/setFixBackgroundNextStep/{orderId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setFixBackgroundNextStep(@PathVariable int orderId, HttpServletRequest request) {
		User loginUser = RequestUtil.getLoginUser(request);
		if (loginUser != null) {
			postProductionDao.setFixPostImageDone(OrderConst.COLUMN_FIXED_BACKGROUND, orderId);
			postProductionDao.setPostProductionDone(orderId, OrderConst.TABLE_ORDER_FIX_BACKGROUND);
			postProductionDao.allotPostProduction(OrderConst.TABLE_ORDER_FIX_SKIN, orderId, loginUser.getBossId());
			taskExecutor.execute(new ClearDiskThread(orderId, OrderConst.PATH_POST_ORIGINAL, request));
		}
		return new SuccessResponse("Set Fix Background Next Step Success");
	}
	
	@RequestMapping(value = "/setCutLiquifyDone/{orderId}/{operatorId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setCutLiquifyDone(@PathVariable int orderId, @PathVariable int operatorId, HttpServletRequest request) {
		User loginUser = RequestUtil.getLoginUser(request);
		if (loginUser != null) {
			postProductionDao.setFixPostImageDone(OrderConst.COLUMN_CUT_LIQUIFY, OrderConst.COLUMN_CUT_LIQUIFY_OPERATOR, orderId, operatorId);
		}
		return new SuccessResponse("Set Cut Liquify Done Success");
	}
	
	@RequestMapping(value = "/setCutLiquifyNextStep/{orderId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse setCutLiquifyNextStep(@PathVariable int orderId, HttpServletRequest request) {
		if (postProductionDao.isAllPictureFixed(orderId)) {
			orderStatusDao.updateOrderStatus(orderId, RequestUtil.getLoginUser(request), OrderStatusConst.WAIT_FOR_VERIFY);
			orderVerifyDao.insertOrderVerifyImage(orderId, 0);
		}
		return new SuccessResponse("Set Cut Liquify Next Step Success");
	}
	
	@RequestMapping(value = "/uploadFixedImage", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse uploadFixedImage(@RequestBody OrderTransferImageData transferImageData, BindingResult bindingResult, HttpServletRequest request) {
		if (postProductionDao.isSelectedPicture(transferImageData.getOrderId(), transferImageData.getFileName())) {
			if (!postProductionDao.isExistFixedImageData(transferImageData.getOrderId(), transferImageData.getFileName())) {
				postProductionDao.insertOrderFixedImageData(transferImageData);
			}
			ImageDiskSaver.setBaseDir(request, OrderConst.PATH_FIXED, transferImageData.getOrderId());
			boolean result = ImageDiskSaver.saveImageToDisk(transferImageData.getFileName(), transferImageData.getBase64Data());
			if (result) {
				return new SuccessResponse("Upload Fixed Image Data Success");
			} else {
				return new FailureResponse("Upload Fixed Image Data Failure");
			}
		}
		return new SuccessResponse("Upload Fixed Image Data Success");
	}
	
	@RequestMapping(value = "/reuploadFixedImage/{imageId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse reuploadFixedImage(@PathVariable int imageId, @RequestBody OrderTransferImageData transferImageData, BindingResult bindingResult, HttpServletRequest request) {
		transferImageData.setId(imageId);
		postProductionDao.reverifyFixedImageData(transferImageData);
		ImageDiskSaver.setBaseDir(request, OrderConst.PATH_FIXED, transferImageData.getOrderId());
		ImageDiskSaver.saveImageToDisk(transferImageData.getFileName(), transferImageData.getBase64Data());
		return new SuccessResponse("Reupload Fixed Image Data Success");
	}
	
	@RequestMapping(value = "/getFixedImageZipPackage/{orderId}", method = RequestMethod.GET)
	public void getFixedImageZipPackage(@PathVariable int orderId, HttpServletRequest request, HttpServletResponse response) {
		pictureController.getFixedImageZipPackage(orderId, request, response);
	}
	
	@RequestMapping(value = "/allotFixSkinImage/{orderId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse allotFixSkinImage(@PathVariable int orderId, @RequestBody List<AllotImage> allotList, BindingResult bindingResult, HttpServletRequest request) {
		postProductionDao.allotImage(orderId, OrderConst.COLUMN_FIXED_SKIN, OrderConst.COLUMN_FIXED_SKIN_OPERATOR, allotList);
		return new SuccessResponse("Allot Fix Skin Image Data Success");
	}
	
	@RequestMapping(value = "/allotFixBackgroundImage/{orderId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse allotFixBackgroundImage(@PathVariable int orderId, @RequestBody List<AllotImage> allotList, BindingResult bindingResult, HttpServletRequest request) {
		postProductionDao.allotImage(orderId, OrderConst.COLUMN_FIXED_BACKGROUND, OrderConst.COLUMN_FIXED_BACKGROUND_OPERATOR, allotList);
		return new SuccessResponse("Allot Fix Background Image Data Success");
	}
	
	@RequestMapping(value = "/allotCutLiquifyImage/{orderId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse allotCutLiquifyImage(@PathVariable int orderId, @RequestBody List<AllotImage> allotList, BindingResult bindingResult, HttpServletRequest request) {
		postProductionDao.allotImage(orderId, OrderConst.COLUMN_CUT_LIQUIFY, OrderConst.COLUMN_CUT_LIQUIFY_OPERATOR, allotList);
		return new SuccessResponse("Allot Cut Liquify Image Data Success");
	}
	
	@RequestMapping(value = "/skipAllotFixBackground/{orderId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse skipAllotFixBackground(@PathVariable int orderId, HttpServletRequest request) {
		postProductionDao.skipAllotImage(orderId, OrderConst.COLUMN_FIXED_BACKGROUND);
		return new SuccessResponse("Skip allot fix background Success");
	}
	
	@RequestMapping(value = "/skipAllotFixSkin/{orderId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse skipAllotFixSkin(@PathVariable int orderId, HttpServletRequest request) {
		postProductionDao.skipAllotImage(orderId, OrderConst.COLUMN_FIXED_SKIN);
		return new SuccessResponse("Skip allot fix skin Success");
	}
	
	@RequestMapping(value = "/skipAllotCutLiquify/{orderId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse skipAllotCutLiquify(@PathVariable int orderId, HttpServletRequest request) {
		postProductionDao.skipAllotImage(orderId, OrderConst.COLUMN_CUT_LIQUIFY);
		return new SuccessResponse("Skip allot cut liquify Success");
	}
	
	@RequestMapping(value = "/skipOrderToComplete/{orderId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse skipOrderToComplete(@PathVariable int orderId, @RequestBody Denial denial, BindingResult bindingResult, HttpServletRequest request) {
		postProductionDao.setOrderCompleteRemark(orderId, denial.getReason());
		orderStatusDao.updateOrderStatus(orderId, RequestUtil.getLoginUser(request), OrderStatusConst.COMPLETE);
		return new SuccessResponse("Skip order to complete Success");
	}
}
