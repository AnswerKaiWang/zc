/**
 * 
 */
package com.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月13日下午5:36:33
 * @desc	
 */
@Getter
@Setter
public class ActivityFundManager extends BaseEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2360930838693946404L;
	private Long activityId;
	private String name;
	private String avatar;
	private String gender;
	private String duty;
	private String brief;
}
