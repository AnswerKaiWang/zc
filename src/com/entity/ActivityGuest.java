/**
 * 
 */
package com.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月13日下午5:37:56
 * @desc	
 */
@Getter
@Setter
public class ActivityGuest extends BaseEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5927655655712399517L;
	
	private Long activityId;
	private String name;
	private String avatar;
	private String brief;
	private String education;
	private String actor;
}
