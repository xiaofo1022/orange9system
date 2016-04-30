package com.xiaofo1022.orange9.core;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class ImageCompresser {
  private static final int COMPRESS_WIDTH = 1696;
  private static final int COMPRESS_HEIGHT = 1272;

  public void compressJpg(String originalFile, String compressPath) {
    try {
      File file = new File(originalFile);
      if (file.exists()) {
        Image image = ImageIO.read(file);

        int originalWidth = image.getWidth(null);
        int originalHeight = image.getHeight(null);
        int resizeWidth;
        int resizeHeight;

        if (originalWidth / originalHeight > COMPRESS_WIDTH / COMPRESS_HEIGHT) {
          resizeWidth = COMPRESS_WIDTH;
          resizeHeight = (int) (originalHeight * COMPRESS_WIDTH / originalWidth);
        } else {
          resizeWidth = (int) (originalWidth * COMPRESS_HEIGHT / originalHeight);
          resizeHeight = COMPRESS_HEIGHT;
        }

        File compressDir = new File(compressPath);
        if (!compressDir.exists()) {
          compressDir.mkdir();
        }

        BufferedImage bufferedImage = new BufferedImage(resizeWidth, resizeHeight, BufferedImage.TYPE_INT_RGB);
        bufferedImage.getGraphics().drawImage(image, 0, 0, resizeWidth, resizeHeight, null);
        FileOutputStream fos = new FileOutputStream(new File(compressPath + "\\" + file.getName()));
        JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(fos);
        encoder.encode(bufferedImage);
        fos.close();
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
}
