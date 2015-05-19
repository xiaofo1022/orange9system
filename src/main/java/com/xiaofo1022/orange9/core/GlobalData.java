package com.xiaofo1022.orange9.core;

import java.io.IOException;
import java.util.Properties;

public class GlobalData {
	private static GlobalData instance;
	private static Properties properties;
	private String picbaseurl;
	
	private GlobalData() {
		properties = new Properties();
		try {
			properties.load(this.getClass().getClassLoader().getResourceAsStream("server.properties"));
			picbaseurl = properties.getProperty("picbaseurl");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static GlobalData getInstance() {
		if (instance == null) {
			instance = new GlobalData();
		}
		return instance;
	}

	public String getPicbaseurl() {
		return picbaseurl;
	}
}
