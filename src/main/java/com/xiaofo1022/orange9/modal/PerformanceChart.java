package com.xiaofo1022.orange9.modal;

import java.util.ArrayList;
import java.util.List;

public class PerformanceChart {
  private String userName;
  private List<Integer> performanceList = new ArrayList<Integer>(12);
  private List<Integer> fixSkinList = new ArrayList<Integer>(12);
  private List<Integer> fixBackgroundList = new ArrayList<Integer>(12);
  private List<Integer> cutLiquifyList = new ArrayList<Integer>(12);

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

  public List<Integer> getFixSkinList() {
    return fixSkinList;
  }

  public void setFixSkinList(List<Integer> fixSkinList) {
    this.fixSkinList = fixSkinList;
  }

  public List<Integer> getFixBackgroundList() {
    return fixBackgroundList;
  }

  public void setFixBackgroundList(List<Integer> fixBackgroundList) {
    this.fixBackgroundList = fixBackgroundList;
  }

  public List<Integer> getCutLiquifyList() {
    return cutLiquifyList;
  }

  public void setCutLiquifyList(List<Integer> cutLiquifyList) {
    this.cutLiquifyList = cutLiquifyList;
  }

  public void addPerformance(int performance) {
    this.performanceList.add(performance);
  }

  public void addFixSkin(int performance) {
    this.fixSkinList.add(performance);
  }

  public void addFixBackground(int performance) {
    this.fixBackgroundList.add(performance);
  }

  public void addCutLiquify(int performance) {
    this.cutLiquifyList.add(performance);
  }
}
