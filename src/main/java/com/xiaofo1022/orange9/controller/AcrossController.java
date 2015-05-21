package com.xiaofo1022.orange9.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.modal.Across;

@Controller
@RequestMapping("/across")
public class AcrossController {
	@RequestMapping(value = "/", method = RequestMethod.POST)
	@ResponseBody
	public String acrossPost(@RequestBody Across across, HttpServletRequest request) {
		URL connect;
	    StringBuffer data = new StringBuffer();
	    try {
	        connect = new URL(across.getUrl());
	        HttpURLConnection connection = (HttpURLConnection) connect.openConnection();
	        connection.setRequestMethod("POST");
	        connection.setDoOutput(true);
	        
	        OutputStreamWriter paramout = new OutputStreamWriter(connection.getOutputStream(), "UTF-8");
	        //paramout.write(across);
	        paramout.flush();
	 
	        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
	        String line;            
	        while ((line = reader.readLine()) != null) {        
	            data.append(line);          
	        }
	     
	        paramout.close();
	        reader.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		return "";
	}
}
