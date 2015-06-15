package com.xiaofo1022.orange9.controller;

import com.xiaofo1022.orange9.core.ImageCompresser;

public class JpgCompressTest {

	public static void main(String[] args) {
		new ImageCompresser().compressJpg("F:\\IMG_8085.jpg", "F:\\tmp");
	}

}
