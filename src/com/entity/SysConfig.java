/**
 * 
 */
package com.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月11日上午9:16:53
 * @desc	
 */
@Getter
@Setter
public class SysConfig extends BaseEntity {

	private static final long serialVersionUID = -4032974127746472288L;
	
	private String sysKey;
	private String sysValue;
	private Integer type;
	private String name;
}
