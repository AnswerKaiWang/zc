/**
 * 
 */
package com.entity;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月31日下午9:46:03
 * @desc	
 */
@Getter
@Setter
public class QuestionTime extends BaseEntity {
	private static final long serialVersionUID = 1L;
	private String name;
	private Date startTime;
	private String endTime;
	private String type;
}
