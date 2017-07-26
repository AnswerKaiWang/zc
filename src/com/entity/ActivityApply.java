/**
 * 
 */
package com.entity;

import javax.persistence.Transient;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月13日下午5:30:48
 * @desc	
 */
@Getter
@Setter
public class ActivityApply extends BaseEntity {
	private static final long serialVersionUID = -1793543027737634529L;
	private Long activityId;
	private String name;
	private String phone;
	private Integer memberNum;
	
	@Transient
	private String actName;
}
