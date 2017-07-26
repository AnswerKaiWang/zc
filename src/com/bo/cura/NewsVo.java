/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月11日下午3:57:54
 * @desc	
 */
@Getter
@Setter
public class NewsVo implements Serializable {
	private static final long serialVersionUID = 1L;
	private Long id;
	private String cover;
	private String title;
	private String publishTime;
	private String brief;
	private String source;
	private String content;
}
