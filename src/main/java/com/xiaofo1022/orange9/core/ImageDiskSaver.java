package com.xiaofo1022.orange9.core;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;

import javax.servlet.http.HttpServletRequest;

import sun.misc.BASE64Decoder;

public class ImageDiskSaver {
	public static ImageCompresser compresser = new ImageCompresser();
	public static String baseDir;
	public static File fileDir;
	
	public static void setIndexDir(HttpServletRequest request, String appendPath) {
		try {
			baseDir = request.getSession().getServletContext().getRealPath("/") + "\\WEB-INF\\images\\show\\" + appendPath;
			fileDir = new File(baseDir);
			if (!fileDir.exists() && !fileDir.isDirectory()) {
				fileDir.mkdirs();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void setIndexDir(HttpServletRequest request, String appendPath, String picname) {
		try {
			baseDir = request.getSession().getServletContext().getRealPath("/") + "\\WEB-INF\\images\\show\\" + appendPath + "\\" + picname;
			fileDir = new File(baseDir);
			if (!fileDir.exists() && !fileDir.isDirectory()) {
				fileDir.mkdirs();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void setBaseDir(HttpServletRequest request, String appendPath, int orderId) {
		try {
			baseDir = request.getSession().getServletContext().getRealPath("/") + "\\WEB-INF\\pictures\\" + appendPath + "\\" + orderId;
			fileDir = new File(baseDir);
			if (!fileDir.exists() && !fileDir.isDirectory()) {
				fileDir.mkdirs();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static boolean saveImageToDisk(String fileName, String base64Data) {
		try {
			saveOriginalImage(fileName, base64Data);
			saveCompressImageToDisk(fileName);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	private static void saveOriginalImage(String fileName, String base64Data) throws Exception {
		BufferedInputStream fileIn = new BufferedInputStream(new ByteArrayInputStream(getImageBytes(base64Data)));
		byte[] buf = new byte[1024];
		File file = new File(baseDir + "\\" + fileName + ".jpg");
		BufferedOutputStream fileOut = new BufferedOutputStream(new FileOutputStream(file));
		try {
			while (true) {
				int bytesIn = fileIn.read(buf, 0, 1024);
				if (bytesIn == -1) {
					break;
				} else {
					fileOut.write(buf, 0, bytesIn);
				}
			}
		} finally {
			fileOut.flush();
			fileOut.close();
			fileIn.close();
		}
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
	
	private static void saveCompressImageToDisk(String fileName) {
		compresser.compressJpg(baseDir + "\\" + fileName + ".jpg", baseDir + "\\compress");
	}
}
