/**
 * 
 */
package com.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月13日下午5:34:58
 * @desc	
 */
@Getter
@Setter
public class ActivityFile extends BaseEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7977890583346080460L;
	
	private Long activityId;
	private String name;
	private String path;
	private Integer actFileType;
	private String actTime;
}
