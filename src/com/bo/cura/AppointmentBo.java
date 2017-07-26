/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月6日上午11:15:25
 * @desc	
 */
@Getter
@Setter
public class AppointmentBo implements Serializable {

	private static final long serialVersionUID = 694170300389391480L;
	
	private String name;
	private String phone;
	private String province;
	private String city;
	private String captcha;//前台传输的
	private String captchaSys;
	private String startTime;
	private String endTime;
	private Integer callbackStatus;
}
