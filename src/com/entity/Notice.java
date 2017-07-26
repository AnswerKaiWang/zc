/**
 * 
 */
package com.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月13日上午10:21:32
 * @desc	
 */
@Getter
@Setter
public class Notice extends BaseEntity {
	
	private static final long serialVersionUID = -3988297845382412001L;
	private String title;
	private String content;
	private String url;
}
