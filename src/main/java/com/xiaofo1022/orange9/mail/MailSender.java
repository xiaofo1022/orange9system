package com.xiaofo1022.orange9.mail;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

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
    try {
      MimeMessage mime = mailSender.createMimeMessage();
      MimeMessageHelper helper = new MimeMessageHelper(mime, true, "GBK");
      helper.setFrom(globalData.getProperty("mail.from"));
      helper.setTo(address);
      helper.setSubject(MimeUtility.encodeText(this.getSubject(), "GBK", "B"));
      helper.setText(this.getText(clientName, orderNo), true);
      mailSender.send(mime);
    } catch (Exception exp) {
      exp.printStackTrace();
      return false;
    }
    return true;
  }

  private String getSubject() throws UnsupportedEncodingException {
    return globalData.getProperty("mail.client.chosen.subject");
  }

  private String getText(String clientName, String orderNo) throws UnsupportedEncodingException {
    String textTemplate = globalData.getProperty("mail.client.chosen.text");
    Map<String, String> paramMap = new HashMap<String, String>();
    paramMap.put("ClientName", clientName);
    paramMap.put("OrderNo", orderNo);
    String text = StringUtil.replaceTextParams(textTemplate, paramMap);
    return new String(text.getBytes("UTF-8"), "GBK");
  }
}
