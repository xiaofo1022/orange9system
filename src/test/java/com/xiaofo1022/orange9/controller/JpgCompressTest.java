package com.xiaofo1022.orange9.controller;

import java.util.Date;

import com.xiaofo1022.orange9.core.ImageCompresser;

public class JpgCompressTest {

  public static void main(String[] args) {
    Date start = new Date();
    new ImageCompresser().compressJpg("C:\\BigPics\\temp\\IMG_0.jpg", "C:\\BigPics\\temp\\compress");
    Date end = new Date();
    System.out.println("Cost: " + (end.getTime() - start.getTime()));
  }

}
