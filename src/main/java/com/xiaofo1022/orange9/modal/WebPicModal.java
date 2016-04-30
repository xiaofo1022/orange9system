package com.xiaofo1022.orange9.modal;

import java.util.List;

public class WebPicModal {

  private int index;
  private String type;
  private WebPic folderPic;
  private List<WebPic> webPics;
  
  public int getIndex() {
    return index;
  }
  public void setIndex(int index) {
    this.index = index;
  }
  public String getType() {
    return type;
  }
  public void setType(String type) {
    this.type = type;
  }
  public List<WebPic> getWebPics() {
    return webPics;
  }
  public void setWebPics(List<WebPic> webPics) {
    this.webPics = webPics;
  }
  public WebPic getFolderPic() {
    return folderPic;
  }
  public void setFolderPic(WebPic folderPic) {
    this.folderPic = folderPic;
  }
}
