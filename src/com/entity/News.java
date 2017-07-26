/**
 * 
 */
package com.entity;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月4日下午8:43:26
 * @desc	
 */
@Getter
@Setter
public class News extends BaseEntity {

	private static final long serialVersionUID = 1L;
	private String title;
	private String content;//内容
	private String cover;//封面
	private String brief;//简介
	private String source;
	private Date publishTime;
	private Integer reference;
}
