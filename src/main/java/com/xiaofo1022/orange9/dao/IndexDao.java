package com.xiaofo1022.orange9.dao;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Repository;
import org.springframework.ui.ModelMap;

import com.xiaofo1022.orange9.modal.IndexPicture;

@Repository
public class IndexDao {
  public String getUnusedPictureName(HttpServletRequest request, String path) {
    String showPath = this.getShowPath(request, path);
    int picindex = 1;
    while (true) {
      File file = new File(showPath + "\\" + picindex + ".jpg");
      if (!file.exists()) {
        return String.valueOf(picindex);
      }
      picindex++;
    }
  }

  public List<IndexPicture> getIndexShowMap(HttpServletRequest request, String path) {
    List<IndexPicture> result = new ArrayList<IndexPicture>();

    String showPath = this.getShowPath(request, path);
    File showDir = new File(showPath);

    if (showDir.exists() && showDir.isDirectory()) {
      File[] files = showDir.listFiles();

      for (File file : files) {
        if (file.isFile()) {
          String fileName = file.getName().replace(".jpg", "");
          List<String> detailPicnameList = new ArrayList<String>();

          String detailFilePath = showPath + "\\" + fileName;
          File detailFileDir = new File(detailFilePath);
          if (detailFileDir.exists() && detailFileDir.isDirectory()) {
            File[] detailFiles = detailFileDir.listFiles();
            for (File detailFile : detailFiles) {
              if (detailFile.isFile() && detailFile.getName().endsWith(".jpg")) {
                detailPicnameList.add(detailFile.getName().replace(".jpg", ""));
              }
            }
          }

          IndexPicture indexPicture = new IndexPicture();
          indexPicture.setIndexPicname(fileName);
          indexPicture.setDetailPicnameList(detailPicnameList);

          result.add(indexPicture);
        }
      }
    }

    return result;
  }

  public List<String> getIndexDetailPicnameList(HttpServletRequest request, String path, String fileName) {
    String showPath = this.getShowPath(request, path);
    return this.getDetailPicnameList(showPath, fileName);
  }

  public List<String> getDetailPicnameList(String showPath, String fileName) {
    List<String> detailPicnameList = new ArrayList<String>();

    String detailFilePath = showPath + "\\" + fileName;
    File detailFileDir = new File(detailFilePath);
    if (detailFileDir.exists() && detailFileDir.isDirectory()) {
      File[] detailFiles = detailFileDir.listFiles();
      for (File detailFile : detailFiles) {
        if (detailFile.isFile() && detailFile.getName().endsWith(".jpg")) {
          detailPicnameList.add(detailFile.getName().replace(".jpg", ""));
        }
      }
    }

    return detailPicnameList;
  }

  private String getShowPath(HttpServletRequest request, String path) {
    String serverPath = request.getSession().getServletContext().getRealPath("/");
    serverPath += "\\WEB-INF\\images\\show\\" + path;
    return serverPath;
  }

  public void deleteIndexPicture(HttpServletRequest request, String path, String picname) {
    String showPath = this.getShowPath(request, path);
    String detailFilePath = showPath + "\\" + picname;

    File indexPic = new File(detailFilePath + ".jpg");
    if (indexPic.exists() && indexPic.isFile()) {
      System.out.println("index pic: " + indexPic.getName() + " delete: " + indexPic.delete());
    }

    File detailDir = new File(detailFilePath);
    if (detailDir.exists() && detailDir.isDirectory()) {
      File[] files = detailDir.listFiles();
      if (files != null && files.length > 0) {
        for (File pic : files) {
          if (pic != null && !pic.isDirectory()) {
            System.out.println(pic.getName() + " delete: " + pic.delete());
          }
        }
      }
      detailDir.delete();
    }
  }

  public void createIndexModalMap(HttpServletRequest request, String path, ModelMap modelMap) {
    List<IndexPicture> pictureList = this.getIndexShowMap(request, path);
    if (pictureList != null && pictureList.size() > 0) {
      List<IndexPicture> pictureCol1List = new ArrayList<IndexPicture>();
      List<IndexPicture> pictureCol2List = new ArrayList<IndexPicture>();
      List<IndexPicture> pictureCol3List = new ArrayList<IndexPicture>();

      int colIndex = 0;

      for (IndexPicture picture : pictureList) {
        if (colIndex == 0) {
          pictureCol1List.add(picture);
        } else if (colIndex == 1) {
          pictureCol2List.add(picture);
        } else {
          pictureCol3List.add(picture);
        }
        colIndex++;
        if (colIndex > 2) {
          colIndex = 0;
        }
      }

      modelMap.addAttribute("pictureCol1List", pictureCol1List);
      modelMap.addAttribute("pictureCol2List", pictureCol2List);
      modelMap.addAttribute("pictureCol3List", pictureCol3List);
    }
  }
}
