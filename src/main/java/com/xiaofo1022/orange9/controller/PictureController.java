package com.xiaofo1022.orange9.controller;

//import java.awt.Desktop;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.common.OrderConst;
import com.xiaofo1022.orange9.core.ImageDiskSaver;
import com.xiaofo1022.orange9.dao.OrderPostProductionDao;
import com.xiaofo1022.orange9.dao.PicDao;
import com.xiaofo1022.orange9.modal.OrderFixedImageData;
import com.xiaofo1022.orange9.modal.PictureData;
import com.xiaofo1022.orange9.modal.Result;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.FailureResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;
import com.xiaofo1022.orange9.util.ZipUtil;

@Controller
@RequestMapping("/picture")
public class PictureController {
	@Autowired
	private PicDao picDao;
	@Autowired
	private OrderPostProductionDao postProductionDao;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	@ResponseBody
	public String main(HttpServletRequest request) {
		return "Fuck you and have a nice day!";
	}
	
	@RequestMapping(value="/checkUploadedFixedImage/{orderId}", method=RequestMethod.GET)
	@ResponseBody
	public Result checkUploadedFixedImage(@PathVariable int orderId, HttpServletRequest request, HttpServletResponse response) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		String serverPath = this.getPicturePath(request, orderId, OrderConst.PATH_FIXED);
		File fileDir = new File(serverPath);
		if (!fileDir.exists() && !fileDir.isDirectory()) {
			fileDir.mkdirs();
			return new Result(false, "未上传任何图片");
		} else {
			String result = this.isAllPicCopiedIntoFolder(orderId, fileDir);
			if (result.equals("")) {
				return new Result(true, "");
			} else {
				return new Result(false, result);
			}
		}
	}
	
	public Result getUnuploadFixedImageFileNames(int orderId, HttpServletRequest request) {
		String serverPath = this.getPicturePath(request, orderId, OrderConst.PATH_FIXED);
		File fileDir = new File(serverPath);
		if (!fileDir.exists() && !fileDir.isDirectory()) {
			fileDir.mkdirs();
		}
		return createUnuploadFileNames(orderId, fileDir);
	}
	
	private Result createUnuploadFileNames(int orderId, File fileDir) {
		Result result = new Result();
		StringBuilder builder = new StringBuilder();
		int unuploadCount = 0;
		String fileNames = "";
		if (fileDir.isDirectory()) {
			List<String> picNameList = picDao.getSelectedImageNames(orderId);
			if (picNameList != null && picNameList.size() > 0) {
				Map<String, String> nameMap = this.getFolderPicNameMap(fileDir.listFiles());
				int nameSize = picNameList.size();
				for (int i = 0; i < nameSize; i++) {
					String picName = picNameList.get(i);
					if (!nameMap.containsKey(picName)) {
						builder.append(picName);
						unuploadCount++;
						if (i < nameSize - 1) {
							builder.append(" OR ");
						}
					}
				}
				fileNames = builder.toString();
				if (fileNames.equals("")) {
					fileNames = "已完成";
				}
			}
		}
		result.setFileNames(fileNames);
		result.setUnuploadCount(unuploadCount);
		return result;
	}
	
	public String getUnuploadOriginalPictureName(int orderId, HttpServletRequest request) {
		String result = "";
		String serverPath = this.getPicturePath(request, orderId, OrderConst.PATH_ORIGINAL);
		File fileDir = new File(serverPath);
		if (!fileDir.exists() && !fileDir.isDirectory()) {
			fileDir.mkdirs();
		}
		StringBuilder builder = new StringBuilder();
		List<String> picNameList = picDao.getSelectedImageNames(orderId);
		if (picNameList != null && picNameList.size() > 0) {
			//Map<String, String> nameMap = this.getFolderPicNameMap(fileDir.listFiles());
			int nameSize = picNameList.size();
			for (int i = 0; i < nameSize; i++) {
				String picName = picNameList.get(i);
				//if (!nameMap.containsKey(picName)) {
					builder.append(picName);
					if (i < nameSize - 1) {
						builder.append(" OR ");
					}
				//}
			}
			result = builder.toString();
			//if (result.equals("")) {
			//	result = "已完成";
			//}
		}
		return result;
	}
	
	private String getPicturePath(HttpServletRequest request, int orderId, String path) {
		String serverPath = request.getSession().getServletContext().getRealPath("/");
		serverPath += "\\WEB-INF\\pictures\\" + path + "\\" + orderId;
		return serverPath;
	}
	
	private String getCompressPicturePath(HttpServletRequest request, int orderId, String path) {
		String serverPath = request.getSession().getServletContext().getRealPath("/");
		serverPath += "\\WEB-INF\\pictures\\" + path + "\\" + orderId + "\\compress";
		return serverPath;
	}
	
	/*
	private void openDeskFolder(File fileDir) {
		try {
			Desktop.getDesktop().open(fileDir);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	*/
	
	private String isAllPicCopiedIntoFolder(int orderId, File fileDir) {
		StringBuilder builder = new StringBuilder();
		if (fileDir.isDirectory()) {
			List<String> picNameList = picDao.getSelectedImageNames(orderId);
			if (picNameList != null && picNameList.size() > 0) {
				Map<String, String> nameMap = this.getFolderPicNameMap(fileDir.listFiles());
				for (String picName : picNameList) {
					if (!nameMap.containsKey(picName)) {
						builder.append(picName + " ");
					}
				}
				if (builder.length() > 0) {
					builder.append(" 没有上传");
				}
			} else {
				return "No pic selected";
			}
		} else {
			return "Not Directory";
		}
		return builder.toString();
	}
	
	private Map<String, String> getFolderPicNameMap(File[] files) {
		Map<String, String> result = null;
		if (files != null && files.length > 0) {
			result = new HashMap<String, String>(files.length);
			for (File file : files) {
				if (!file.isDirectory()) {
					String fileName = file.getName();
					if (fileName.toLowerCase().endsWith(".jpg")) {
						String frontName = fileName.split("\\.")[0];
						result.put(frontName, frontName);
					}
				}
			}
		} else {
			result = new HashMap<String, String>();
		}
		return result;
	}
	
	@RequestMapping(value = "/downloadOriginalPicture/{orderId}", method = RequestMethod.GET)
	public void downloadOriginalPicture(@PathVariable int orderId, HttpServletRequest request, HttpServletResponse response) {
		String serverPath = this.getPicturePath(request, orderId, OrderConst.PATH_POST_ORIGINAL);
		this.downloadZipFile(orderId, serverPath, response);
	}
	
	@RequestMapping(value = "/downloadFixSkinPicture/{orderId}", method = RequestMethod.GET)
	public void downloadFixSkinPicture(@PathVariable int orderId, HttpServletRequest request, HttpServletResponse response) {
		String serverPath = this.getPicturePath(request, orderId, OrderConst.PATH_FIX_SKIN);
		this.downloadZipFile(orderId, serverPath, response);
	}
	
	@RequestMapping(value = "/downloadFixBackgroundPicture/{orderId}", method = RequestMethod.GET)
	public void downloadFixBackgroundPicture(@PathVariable int orderId, HttpServletRequest request, HttpServletResponse response) {
		String serverPath = this.getPicturePath(request, orderId, OrderConst.PATH_FIX_BACKGROUND);
		this.downloadZipFile(orderId, serverPath, response);
	}
	
	@RequestMapping(value = "/downloadOriginalCompressPicture/{orderId}", method = RequestMethod.GET)
	public void downloadOriginalCompressPicture(@PathVariable int orderId, HttpServletRequest request, HttpServletResponse response) {
		String serverPath = this.getCompressPicturePath(request, orderId, OrderConst.PATH_ORIGINAL);
		File fileDir = new File(serverPath);
		if (fileDir.exists() && fileDir.isDirectory()) {
			File[] files = fileDir.listFiles();
			if (files != null && files.length > 0) {
				List<File> compressFileList = new ArrayList<File>(files.length);
				for (File file : files) {
					if (file.exists() && file.isFile()) {
						compressFileList.add(file);
					}
				}
				ZipUtil.downloadZipFile(compressFileList, response);
			}
		}
	}
	
	public void downloadZipFile(int orderId, String serverPath, HttpServletResponse response) {
		try {
			List<String> fileNames = picDao.getSelectedImageNames(orderId);
			
			if (fileNames != null && fileNames.size() > 0) {
				List<File> fileList = new ArrayList<File>(fileNames.size());
				for (String fileName : fileNames) {
					File file = new File(serverPath + "\\" + fileName + ".jpg");
					if (file.exists()) {
						fileList.add(file);
					}
				}
				response.setContentType("APPLICATION/OCTET-STREAM");  
				response.setHeader("Content-Disposition", "attachment; filename=O9" + orderId + ".zip");
				ZipOutputStream zos = new ZipOutputStream(response.getOutputStream());
				for (File file : fileList) {
					zos.putNextEntry(new ZipEntry(file.getName()));
					FileInputStream fis = new FileInputStream(file);     
					byte[] buffer = new byte[1024];     
					int r = 0;     
					while ((r = fis.read(buffer)) != -1) {     
						zos.write(buffer, 0, r);     
					}     
					fis.close();
				}
				zos.flush();
				zos.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/saveOriginalPicture", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse saveOriginalPicture(@RequestBody PictureData pictureData, BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response) {
		try {
			if (postProductionDao.isSelectedPicture(pictureData.getOrderId(), pictureData.getFileName())) {
				ImageDiskSaver.setBaseDir(request, OrderConst.PATH_POST_ORIGINAL, pictureData.getOrderId());
				ImageDiskSaver.saveImageToDisk(pictureData.getFileName(), pictureData.getBase64Data());
				return new SuccessResponse("Save Success");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new FailureResponse("Save Failure");
	}
	
	@RequestMapping(value = "/saveFixSkinPicture", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse saveFixSkinPicture(@RequestBody PictureData pictureData, BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response) {
		try {
			if (postProductionDao.isSelectedPicture(pictureData.getOrderId(), pictureData.getFileName())) {
				ImageDiskSaver.setBaseDir(request, OrderConst.PATH_FIX_SKIN, pictureData.getOrderId());
				ImageDiskSaver.saveImageToDisk(pictureData.getFileName(), pictureData.getBase64Data());
				return new SuccessResponse("Save Success");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new FailureResponse("Save Failure");
	}
	
	@RequestMapping(value = "/saveFixBackgroundPicture", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse saveFixBackgroundPicture(@RequestBody PictureData pictureData, BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response) {
		try {
			if (postProductionDao.isSelectedPicture(pictureData.getOrderId(), pictureData.getFileName())) {
				ImageDiskSaver.setBaseDir(request, OrderConst.PATH_FIX_BACKGROUND, pictureData.getOrderId());
				ImageDiskSaver.saveImageToDisk(pictureData.getFileName(), pictureData.getBase64Data());
				return new SuccessResponse("Save Success");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new FailureResponse("Save Failure");
	}
	
	@RequestMapping(value = "/saveCutLiquifyPicture", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse saveCutLiquifyPicture(@RequestBody PictureData pictureData, BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response) {
		try {
			if (postProductionDao.isSelectedPicture(pictureData.getOrderId(), pictureData.getFileName())) {
				ImageDiskSaver.setBaseDir(request, OrderConst.PATH_CUT_LIQUIFY, pictureData.getOrderId());
				ImageDiskSaver.saveImageToDisk(pictureData.getFileName(), pictureData.getBase64Data());
				return new SuccessResponse("Save Success");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new SuccessResponse("Save Success");
	}
	
	public void getFixedImageZipPackage(int orderId, HttpServletRequest request, HttpServletResponse response) {
		List<OrderFixedImageData> imageList = postProductionDao.getOrderFixedImageDataList(orderId);
		if (imageList != null && imageList.size() > 0) {
			String serverPath = request.getSession().getServletContext().getRealPath("/");
			String fixedPath = serverPath + "\\WEB-INF\\pictures\\fixed\\";
			List<File> fileList = new ArrayList<File>(imageList.size());
			for (OrderFixedImageData imageData : imageList) {
				fileList.add(new File(fixedPath + "\\" + imageData.getOrderId() + "\\" + imageData.getFileName() + ".jpg"));
			}
			ZipUtil.downloadZipFile(fileList, response);
		}
	}
}
