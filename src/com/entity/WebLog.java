/**
 * 
 */
package com.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月22日上午11:45:06
 * @desc	
 */
@Getter
@Setter
public class WebLog extends BaseEntity {

	private static final long serialVersionUID = -7222602531081702719L;
	
	private String content;
	private Long userSecondId;
	private String ip;
}
