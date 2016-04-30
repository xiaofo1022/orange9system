package com.xiaofo1022.orange9.controller;

import java.io.File;

public class ChangeBigPicturesName {
  public static void main(String[] args) {
    String baseDir = "C:\\BigPics\\9007031";
    String newPath = "C:\\BigPics\\tmp";
    File dir = new File(baseDir);
    File newDir = new File(newPath);
    if (!newDir.exists()) {
      newDir.mkdir();
    }
    File[] files = dir.listFiles();
    for (int i = 0; i < files.length; i++) {
      File file = files[i];
      file.renameTo(new File(newDir + "\\IMG_" + i + ".jpg"));
    }
  }
}
