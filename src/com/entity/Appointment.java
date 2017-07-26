/**
 * 
 */
package com.entity;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月5日上午11:49:22
 * @desc	财富预约
 */
@Getter
@Setter
public class Appointment extends BaseEntity {
	private static final long serialVersionUID = 1L;
	private String name;
	private String phone;
	private String city;
	private String province;
	private Integer callbackStatus;
	private Date startTime;
	private Date endTime;
	private String remark;
}
