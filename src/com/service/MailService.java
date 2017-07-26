/*
 * syb
 * syb
 * syb
 */
package com.service;

import java.util.Map;

public interface MailService {

	int send(String smtpFromMail, String smtpHost, Integer smtpPort, String smtpUsername,String nickname, String smtpPassword, String toMail, String subject, String templatePath, Map<String, Object> model, boolean async);

	int sendPhone(String toNumber,String contant);

}