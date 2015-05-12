package com.xiaofo1022.orange9.modal;

import java.util.ArrayList;
import java.util.List;

public class PerformanceChart {
	private String userName;
	private List<Integer> performanceList = new ArrayList<Integer>(12);
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public List<Integer> getPerformanceList() {
		return performanceList;
	}
	public void setPerformanceList(List<Integer> performanceList) {
		this.performanceList = performanceList;
	}
	public void addPerformance(int performance) {
		this.performanceList.add(performance);
	}
}
