/**
 * 
 */
package com.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月27日下午6:26:50
 * @desc	
 */
@Getter
@Setter
public class QuestionAnswer extends BaseEntity {
	private static final long serialVersionUID = 1L;
	private Long questionId;
	private String answer;
	private Integer score;
	private String prefix;//ABCDEFG
}
