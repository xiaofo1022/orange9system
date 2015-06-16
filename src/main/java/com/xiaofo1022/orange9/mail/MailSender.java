package com.xiaofo1022.orange9.mail;

import java.util.HashMap;
import java.util.Map;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

import com.xiaofo1022.orange9.core.GlobalData;
import com.xiaofo1022.orange9.util.StringUtil;

public class MailSender {
	private JavaMailSender mailSender;
	private GlobalData globalData = GlobalData.getInstance();
	
	public JavaMailSender getMailSender() {
		return mailSender;
	}

	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}
	
	public boolean sendEmail(String address, String clientName, String orderNo) {
		SimpleMailMessage mailMessage = new SimpleMailMessage();
		mailMessage.setFrom(globalData.getProperty("mail.from"));
		mailMessage.setTo(address);
		mailMessage.setSubject(this.getSubject());
		mailMessage.setText(this.getText(clientName, orderNo));
		mailSender.send(mailMessage);
		return true;
	}
	
	private String getSubject() {
		return globalData.getProperty("mail.client.chosen.subject");
	}
	
	private String getText(String clientName, String orderNo) {
		String textTemplate = globalData.getProperty("mail.client.chosen.text");
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("ClientName", clientName);
		paramMap.put("OrderNo", orderNo);
		return StringUtil.replaceTextParams(textTemplate, paramMap);
	}
}
