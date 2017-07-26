/*
 * syb
 * syb
 * syb
 */
package com.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.apache.commons.lang.StringUtils;
import org.springframework.core.task.TaskExecutor;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.service.MailService;
import com.util.FreemarkerUtils;
import com.util.HttpSend;

@Service("mailServiceImpl")
public class MailServiceImpl implements MailService {

	@Resource(name = "javaMailSender")
	private JavaMailSenderImpl javaMailSender;
	@Resource(name = "taskExecutor")
	private TaskExecutor taskExecutor;

	private void addSendTask(final MimeMessage mimeMessage) {
		try {
			taskExecutor.execute(new Runnable() {
				public void run() {
					javaMailSender.send(mimeMessage);
				}
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int send(String smtpFromMail, String smtpHost, Integer smtpPort, String smtpUsername,String nickname, 
			String smtpPassword, String toMail, String subject, String template, Map<String, Object> model, boolean async) {
		try {
			String text = FreemarkerUtils.process(template, model);
			javaMailSender.setHost(smtpHost);
			javaMailSender.setPort(smtpPort);
			javaMailSender.setUsername(smtpUsername);
			javaMailSender.setPassword(smtpPassword);
			MimeMessage mimeMessage = javaMailSender.createMimeMessage();
			MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, false, "utf-8");
			mimeMessageHelper.setFrom(MimeUtility.encodeWord(nickname) + " <" + smtpFromMail + ">");
			mimeMessageHelper.setSubject(subject);
			mimeMessageHelper.setTo(toMail);
			mimeMessageHelper.setText("<html><body>"+text+"</body></html>", true);
			if (async) {
				addSendTask(mimeMessage);
				return 0;
			} else {
				javaMailSender.send(mimeMessage);
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		} 
	}

	@Override
	public int sendPhone(String toNumber, String contant) {
		Map<String, Object> map=new HashMap<>();
		map.put("name", "zcdx");
		map.put("pwd", "A61E3FC309C0D03530651E7CB0A9");
		map.put("content",contant);
		map.put("mobile",toNumber);
		map.put("sign","中城投资");
		map.put("type","pt");
		String s=HttpSend.post("http://web.duanxinwang.cc/asmx/smsservice.aspx", map);
		String[] tt=StringUtils.split(s, ",");
		if("0".equals(tt[0])){
			return 0;
		}else{
			return 1;
		}
	}
	public static void main(String[] args) {
		Map<String, Object> map=new HashMap<>();
		map.put("name", "zcdx");
		map.put("pwd", "A61E3FC309C0D03530651E7CB0A9");
		map.put("content","你的验证码为23456");
		map.put("mobile","18221506123");
		map.put("stime","");
		map.put("sign","中城投资");
		map.put("type","pt");
		map.put("extno","");
		String s=HttpSend.post("http://web.duanxinwang.cc/asmx/smsservice.aspx", map);
		System.out.println(s);
	}


}