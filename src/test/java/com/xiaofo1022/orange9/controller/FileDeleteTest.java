package com.xiaofo1022.orange9.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

public class FileDeleteTest {
	public static void main(String[] args) {
//		File fileDir = new File("C:\\Users\\kurt.yu\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\orange9\\WEB-INF\\pictures\\post\\fixbackground\\3");
//		if (fileDir != null && fileDir.exists() && fileDir.isDirectory()) {
//			File[] files = fileDir.listFiles();
//			if (files != null && files.length > 0) {
//				for (File pic : files) {
//					pic.delete();
//				}
//			}
//			fileDir.delete();
//		}
		try {
			File file = new File("C:\\Users\\kurt.yu\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\orange9\\WEB-INF\\pictures\\post\\fixbackground\\4\\Hydrangeas.jpg");
			BufferedInputStream fileIn = new BufferedInputStream(new FileInputStream(file));
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
			fileOut.close();
			fileIn.close();
			System.out.println(file.delete());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
