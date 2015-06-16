package com.xiaofo1022.orange9.controller;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.xiaofo1022.orange9.mail.MailSender;

public class MailTest {
	private static ApplicationContext factory;

	public static void main(String[] args) {
		factory = new ClassPathXmlApplicationContext("spring-config.xml");
		MailSender mailSender = factory.getBean(MailSender.class);
		mailSender.sendEmail("553216263@qq.com", "Test", "Test");
	}
}
