/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月30日下午1:29:23
 * @desc	
 */
@Getter
@Setter
public class RegBo implements Serializable {
	private static final long serialVersionUID = 4191091014168997718L;
	
	private String phone;
	private String password;
	private String ackPwd;
	private String captchaSys;
	private String captcha;//验证码
	private String smsCodeSys;
	private String smsCode;//短信验证码
	private String message;//错误消息
	
	//第三步骤
	private String name;
	private Integer age;
	private Integer gender;
	private Integer city;
	private String address;
	private String birth;
	private String email;
	
	//
	private String userNo;
	
	private Long userId;
}
