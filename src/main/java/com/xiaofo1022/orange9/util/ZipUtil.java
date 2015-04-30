package com.xiaofo1022.orange9.util;

import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletResponse;

public class ZipUtil {
	public static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public static void downloadZipFile(List<File> fileList, HttpServletResponse response) {
		try {
			response.setContentType("APPLICATION/OCTET-STREAM");  
			response.setHeader("Content-Disposition", "attachment; filename=" + getZipFileName());
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
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static String getZipFileName() {
		return sdf.format(new Date()) + ".zip";
	}
}
