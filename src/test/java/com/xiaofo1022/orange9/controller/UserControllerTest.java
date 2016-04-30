package com.xiaofo1022.orange9.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class UserControllerTest {
  public static void main(String[] args) {
    saveHeaderImageToDisk(getImageBytes());
  }

  private static byte[] getImageBytes() {
    BASE64Decoder decoder = new BASE64Decoder();
    byte[] b = null;
    try {
      BASE64Encoder encoder = new BASE64Encoder();
      String ttt = encoder.encode("fuckyou".getBytes());
      System.out.println(ttt);
      b = decoder.decodeBuffer(
          "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��");
      for (int i = 0; i < b.length; ++i) {
        // abnormal data
        if (b[i] < 0) {
          b[i] += 256;
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return b;
  }

  private static void saveHeaderImageToDisk(byte[] headerBytes) {
    try {
      OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream("c:/fuckyou"), "UTF-8");
      osw.write(new String(headerBytes, "UTF-8"));
      osw.flush();
      osw.close();

      BufferedInputStream fileIn = new BufferedInputStream(new ByteArrayInputStream(headerBytes));
      byte[] buf = new byte[1024];
      File file = new File("c:/shityou");
      BufferedOutputStream fileOut = new BufferedOutputStream(new FileOutputStream(file));
      while (true) {
        int bytesIn = fileIn.read(buf, 0, 1024);
        System.out.println(bytesIn);
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
}
