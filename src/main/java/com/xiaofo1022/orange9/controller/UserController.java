package com.xiaofo1022.orange9.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import sun.misc.BASE64Decoder;

import com.xiaofo1022.orange9.modal.User;

@Controller
@RequestMapping("/user")
public class UserController {

	@RequestMapping(value = "/addUser", method = RequestMethod.POST)
	@ResponseBody
	public String addUser(@ModelAttribute("employee") User user, BindingResult result) {
		saveHeaderImageToDisk(getImageBytes(user.getHeader()));
		return "Hi";
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
	
	private void saveHeaderImageToDisk(byte[] headerBytes) {
		try {
			BufferedInputStream fileIn = new BufferedInputStream(new ByteArrayInputStream(headerBytes));
			byte[] buf = new byte[1024];
			File file = new File("c:/fuckyou.jpg");
			BufferedOutputStream fileOut = new BufferedOutputStream(new FileOutputStream(file));
			while (true) {
				int bytesIn = fileIn.read(buf, 0, 1024);
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
