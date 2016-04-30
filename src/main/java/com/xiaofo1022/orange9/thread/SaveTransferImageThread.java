package com.xiaofo1022.orange9.thread;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import com.xiaofo1022.orange9.core.ImageCompresser;
import com.xiaofo1022.orange9.modal.OrderTransferImageData;

import sun.misc.BASE64Decoder;

public class SaveTransferImageThread implements Runnable {
  private OrderTransferImageData transferImageData;
  private boolean isFixedImage = false;

  public SaveTransferImageThread(OrderTransferImageData transferImageData) {
    this.transferImageData = transferImageData;
  }

  public void setIsFixedImage(boolean isFixedImage) {
    this.isFixedImage = isFixedImage;
  }

  public void run() {
    String imageDir = this.saveImageToDisk(this.transferImageData);
    this.saveCompressImageToDisk(imageDir, this.transferImageData.getFileName());
  }

  private String saveImageToDisk(OrderTransferImageData transferImageData) {
    try {
      String baseDir = transferImageData.getServerPath();
      if (isFixedImage) {
        baseDir += "\\WEB-INF\\pictures\\fixed\\";
      } else {
        baseDir += "\\WEB-INF\\pictures\\original\\";
      }
      String dir = baseDir + transferImageData.getOrderId();
      File fileDir = new File(dir);
      if (!fileDir.exists() && !fileDir.isDirectory()) {
        fileDir.mkdirs();
      }
      BufferedInputStream fileIn = new BufferedInputStream(new ByteArrayInputStream(getImageBytes(transferImageData.getBase64Data())));
      byte[] buf = new byte[1024];
      File file = new File(dir + "\\" + transferImageData.getFileName() + ".jpg");
      BufferedOutputStream fileOut = new BufferedOutputStream(new FileOutputStream(file));
      try {
        while (true) {
          int bytesIn = fileIn.read(buf, 0, 1024);
          if (bytesIn == -1) {
            break;
          } else {
            fileOut.write(buf, 0, bytesIn);
          }
        }
      } finally {
        fileOut.flush();
        fileOut.close();
        fileIn.close();
      }
      return dir;
    } catch (IOException e) {
      e.printStackTrace();
    }
    return "";
  }

  private byte[] getImageBytes(String byteString) {
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

  private void saveCompressImageToDisk(String imageDir, String fileName) {
    ImageCompresser compresser = new ImageCompresser();
    compresser.compressJpg(imageDir + "\\" + fileName + ".jpg", imageDir + "\\compress");
  }
}
