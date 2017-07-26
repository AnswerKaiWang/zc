/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月20日上午10:01:25
 * @desc	
 */
@Getter
@Setter
public class ActivityApplyBo implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Long activityId;
	private String name;
	private String phone;
	private Integer memberNum;
}
