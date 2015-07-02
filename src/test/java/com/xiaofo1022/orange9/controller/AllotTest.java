package com.xiaofo1022.orange9.controller;

import java.util.ArrayList;
import java.util.List;

import com.xiaofo1022.orange9.modal.AllotImage;
import com.xiaofo1022.orange9.modal.OrderTransferImageData;

public class AllotTest {
	public static void main(String[] args) {
		AllotImage allot1 = new AllotImage();
		AllotImage allot2 = new AllotImage();
		AllotImage allot3 = new AllotImage();
		AllotImage allot4 = new AllotImage();
		allot1.setAllotCount(20);
		allot2.setAllotCount(26);
		allot3.setAllotCount(30);
		allot4.setAllotCount(20);
		List<AllotImage> allotList = new ArrayList<AllotImage>();
		allotList.add(allot1);
		allotList.add(allot2);
		allotList.add(allot3);
		allotList.add(allot4);
		allotImage(allotList);
	}
	
	private static void allotImage(List<AllotImage> allotList) {
		List<OrderTransferImageData> unAllotImageList = getUnAllotTransferImageDataList();
		int imageSize = unAllotImageList.size();
		int imageIndex = 0;
		if (unAllotImageList != null && imageSize > 0) {
			for (AllotImage allotImage : allotList) {
				if (allotImage.getAllotCount() > 0) {
					int allotCount = 0;
					for (int i = imageIndex; i < imageSize; i++) {
						allotCount++;
						if (allotCount == allotImage.getAllotCount()) {
							imageIndex = allotCount;
							System.out.println(allotCount + " alloted.");
							allotCount = 0;
							break;
						}
					}
				}
			}
		}
	}
	
	private static List<OrderTransferImageData> getUnAllotTransferImageDataList() {
		List<OrderTransferImageData> result = new ArrayList<OrderTransferImageData>(96);
		for (int i = 0; i < 96; i++) {
			result.add(new OrderTransferImageData());
		}
		return result;
	}
}
