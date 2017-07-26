/**
 * 
 */
package com.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月13日上午10:47:23
 * @desc	
 */
@Getter
@Setter
public class Lecture extends BaseEntity {

	private static final long serialVersionUID = 1L;
	
	private String title;
	private String brief;
	private String lastestTime;//最后更新时间
	private String cover;//封面
	private Integer recStatus;//推荐状态，1：推荐；0：不推荐
}
