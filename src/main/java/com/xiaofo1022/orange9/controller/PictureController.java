package com.xiaofo1022.orange9.controller;

//import java.awt.Desktop;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
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

import sun.misc.BASE64Decoder;

import com.xiaofo1022.orange9.dao.PicDao;
import com.xiaofo1022.orange9.modal.PictureData;
import com.xiaofo1022.orange9.modal.Result;

@Controller
@RequestMapping("/picture")
public class PictureController {
	@Autowired
	private PicDao picDao;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	@ResponseBody
	public String main(HttpServletRequest request) {
		return "Fuck you and have a nice day!";
	}
	
	@RequestMapping(value="/checkConvertImage/{orderId}", method=RequestMethod.GET)
	@ResponseBody
	public Result checkConvertImage(@PathVariable int orderId, HttpServletRequest request, HttpServletResponse response) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		String serverPath = this.getServerPath(request, orderId, "original");
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
	
	public String getUnuploadOriginalPictureName(int orderId, HttpServletRequest request) {
		String result = "";
		String serverPath = this.getServerPath(request, orderId, "original");
		File fileDir = new File(serverPath);
		if (!fileDir.exists() && !fileDir.isDirectory()) {
			fileDir.mkdirs();
		}
		StringBuilder builder = new StringBuilder();
		List<String> picNameList = picDao.getConvertFileName(orderId);
		if (picNameList != null && picNameList.size() > 0) {
			Map<String, String> nameMap = this.getFolderPicNameMap(fileDir.listFiles());
			int nameSize = picNameList.size();
			for (int i = 0; i < nameSize; i++) {
				String picName = picNameList.get(i);
				if (!nameMap.containsKey(picName)) {
					builder.append(picName);
					if (i < nameSize - 1) {
						builder.append(" OR ");
					}
				}
			}
			result = builder.toString();
			if (result.equals("")) {
				result = "已完成";
			}
		}
		return result;
	}
	
	private String getServerPath(HttpServletRequest request, int orderId, String path) {
		String serverPath = request.getSession().getServletContext().getRealPath("/");
		serverPath += "\\WEB-INF\\pictures\\post\\" + path + "\\" + orderId;
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
			List<String> picNameList = picDao.getConvertFileName(orderId);
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
				String fileName = file.getName();
				if (fileName.toLowerCase().endsWith(".jpg")) {
					String frontName = fileName.split("\\.")[0];
					result.put(frontName, frontName);
				}
			}
		} else {
			result = new HashMap<String, String>();
		}
		return result;
	}
	
	@RequestMapping(value = "/downloadOriginalPicture/{orderId}", method = RequestMethod.GET)
	public void downloadOriginalPicture(@PathVariable int orderId, HttpServletRequest request, HttpServletResponse response) {
		String serverPath = this.getServerPath(request, orderId, "original");
		this.downloadZipFile(orderId, "ORDER_IMAGE_FIX_SKIN", serverPath, response);
	}
	
	@RequestMapping(value = "/downloadOriginalPicture/{orderId}/{fileName}", method = RequestMethod.GET)
	public void downloadOriginalPicture(@PathVariable int orderId, @PathVariable String fileName, HttpServletRequest request, HttpServletResponse response) {
		String serverPath = this.getServerPath(request, orderId, "original");
		this.downloadPicture(serverPath, fileName, response);
	}
	
	@RequestMapping(value = "/downloadFixSkinPicture/{orderId}", method = RequestMethod.GET)
	public void downloadFixSkinPicture(@PathVariable int orderId, HttpServletRequest request, HttpServletResponse response) {
		String serverPath = this.getServerPath(request, orderId, "fixskin");
		this.downloadZipFile(orderId, "ORDER_IMAGE_FIX_BACKGROUND", serverPath, response);
	}
	
	@RequestMapping(value = "/downloadFixSkinPicture/{orderId}/{fileName}", method = RequestMethod.GET)
	public void downloadFixSkinPicture(@PathVariable int orderId, @PathVariable String fileName, HttpServletRequest request, HttpServletResponse response) {
		String serverPath = this.getServerPath(request, orderId, "fixskin");
		this.downloadPicture(serverPath, fileName, response);
	}
	
	@RequestMapping(value = "/downloadFixBackgroundPicture/{orderId}", method = RequestMethod.GET)
	public void downloadFixBackgroundPicture(@PathVariable int orderId, HttpServletRequest request, HttpServletResponse response) {
		String serverPath = this.getServerPath(request, orderId, "fixbackground");
		this.downloadZipFile(orderId, "ORDER_IMAGE_CUT_LIQUIFY", serverPath, response);
	}
	
	@RequestMapping(value = "/downloadFixBackgroundPicture/{orderId}/{fileName}", method = RequestMethod.GET)
	public void downloadFixBackgroundPicture(@PathVariable int orderId, @PathVariable String fileName, HttpServletRequest request, HttpServletResponse response) {
		String serverPath = this.getServerPath(request, orderId, "fixbackground");
		this.downloadPicture(serverPath, fileName, response);
	}
	
	public void downloadZipFile(int orderId, String tableName, String serverPath, HttpServletResponse response) {
		try {
			List<String> fileNames = picDao.getPostProductionFileNames(tableName, orderId);
			
			if (fileNames != null && fileNames.size() > 0) {
				List<File> fileList = new ArrayList<File>(fileNames.size());
				for (String fileName : fileNames) {
					fileList.add(new File(serverPath + "\\" + fileName + ".jpg"));
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
	
	public void downloadPicture(String serverPath, String fileName, HttpServletResponse response) {
		String filePath = serverPath + "\\" + fileName + ".jpg";
		File file = new File(filePath);
		if (file.exists()) {
			response.setContentType("APPLICATION/OCTET-STREAM");  
			response.setHeader("Content-Disposition", "attachment; filename=" + file.getName());
			try {
				DataOutputStream dos = new DataOutputStream(response.getOutputStream());
				FileInputStream fis = new FileInputStream(file);     
				byte[] buffer = new byte[1024];     
				int r = 0;     
				while ((r = fis.read(buffer)) != -1) {     
					dos.write(buffer, 0, r);     
				}     
				fis.close();
				dos.flush();
				dos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping(value = "/saveOriginalPicture", method = RequestMethod.POST)
	@ResponseBody
	public boolean saveOriginalPicture(@RequestBody PictureData pictureData, BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response) {
		String serverPath = this.getServerPath(request, pictureData.getOrderId(), "original");
		try {
			this.savePictureToDisk(serverPath, pictureData.getFileName(), pictureData.getBase64Data());
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@RequestMapping(value = "/saveFixSkinPicture", method = RequestMethod.POST)
	@ResponseBody
	public boolean saveFixSkinPicture(@RequestBody PictureData pictureData, BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response) {
		String serverPath = this.getServerPath(request, pictureData.getOrderId(), "fixskin");
		try {
			this.savePictureToDisk(serverPath, pictureData.getFileName(), pictureData.getBase64Data());
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@RequestMapping(value = "/saveFixBackgroundPicture", method = RequestMethod.POST)
	@ResponseBody
	public boolean saveFixBackgroundPicture(@RequestBody PictureData pictureData, BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response) {
		String serverPath = this.getServerPath(request, pictureData.getOrderId(), "fixbackground");
		try {
			this.savePictureToDisk(serverPath, pictureData.getFileName(), pictureData.getBase64Data());
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@RequestMapping(value = "/saveCutLiquifyPicture", method = RequestMethod.POST)
	@ResponseBody
	public boolean saveCutLiquifyPicture(@RequestBody PictureData pictureData, BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response) {
		String serverPath = this.getServerPath(request, pictureData.getOrderId(), "cutliquify");
		try {
			this.savePictureToDisk(serverPath, pictureData.getFileName(), pictureData.getBase64Data());
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	private void savePictureToDisk(String serverPath, String fileName, String base64Data) throws Exception {
		File fileDir = new File(serverPath);
		if (!fileDir.exists() && !fileDir.isDirectory()) {
			fileDir.mkdirs();
		}
		File file = new File(serverPath + "\\" + fileName + ".jpg");
		BufferedInputStream fileIn = new BufferedInputStream(new ByteArrayInputStream(getImageBytes(base64Data)));
		byte[] buf = new byte[1024];
		BufferedOutputStream fileOut = new BufferedOutputStream(new FileOutputStream(file));
		while (true) {
			int bytesIn = fileIn.read(buf, 0, 1024);
			if (bytesIn == -1) {
				break;
			} else {
				fileOut.write(buf, 0, bytesIn);
			}
		}
		fileOut.flush();
		fileOut.close();
	}
	
	private static byte[] getImageBytes(String byteString) {
		BASE64Decoder decoder = new BASE64Decoder();
		byte[] b = null;
		try {
			b = decoder.decodeBuffer(byteString);
			for (int i = 0; i < b.length; ++i) {
				if (b[i] < 0) {
					b[i] += 256;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return b;
	}
}
