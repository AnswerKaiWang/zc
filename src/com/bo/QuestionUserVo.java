/**
 * 
 */
package com.bo;

import com.entity.QuestionUserRecord;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月27日下午9:58:21
 * @desc	
 */
@Getter
@Setter
public class QuestionUserVo extends QuestionUserRecord {
	private static final long serialVersionUID = 1L;
	private String custName;
}
