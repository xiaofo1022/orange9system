package com.xiaofo1022.orange9.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import sun.misc.BASE64Decoder;

public class Base64Util {
	public static void saveHeaderImageToDisk(String base64Code) {
		try {
			BufferedInputStream fileIn = new BufferedInputStream(new ByteArrayInputStream(getImageBytes(base64Code)));
			byte[] buf = new byte[1024];
			File file = new File("c:/fuckyou.jpg"); // TODO A test file.
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
		} catch (IOException e) {
			e.printStackTrace();
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
	
	public static String getJpgHeader() {
		return "data:image/jpeg;base64,";
	}
}
