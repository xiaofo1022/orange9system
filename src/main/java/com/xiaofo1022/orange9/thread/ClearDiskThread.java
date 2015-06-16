package com.xiaofo1022.orange9.thread;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

public class ClearDiskThread implements Runnable {
	private int orderId;
	private String path;
	private HttpServletRequest request;
	
	public ClearDiskThread(int orderId, String path, HttpServletRequest request) {
		this.orderId = orderId;
		this.path = path;
		this.request = request;
	}
	
	public void run() {
		this.clearPictures(this.orderId, this.path, this.request);
	}
	
	private void clearPictures(int orderId, String path, HttpServletRequest request) {
		String serverPath = this.getPicturePath(request, orderId, path);
		this.clearPicturesAction(serverPath);
	}
	
	private String getPicturePath(HttpServletRequest request, int orderId, String path) {
		String serverPath = request.getSession().getServletContext().getRealPath("/");
		serverPath += "\\WEB-INF\\pictures\\" + path + "\\" + orderId;
		return serverPath;
	}
	
	private void clearPicturesAction(String serverPath) {
		File fileDir = new File(serverPath);
		if (fileDir != null && fileDir.exists() && fileDir.isDirectory()) {
			File[] files = fileDir.listFiles();
			if (files != null && files.length > 0) {
				for (File pic : files) {
					if (pic != null && !pic.isDirectory()) {
						System.out.println(pic.getName() + " delete: " + pic.delete());
					}
				}
			}
			fileDir.delete();
		}
	}
}
