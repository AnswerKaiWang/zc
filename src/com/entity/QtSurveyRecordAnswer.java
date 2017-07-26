/**
 * 
 */
package com.entity;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月17日下午4:01:45
 * @desc	
 */
@Getter
@Setter
public class QtSurveyRecordAnswer implements Serializable {

	private static final long serialVersionUID = 5896026989767425351L;
	
	private Long qsrId;//问卷记录ID
	private Long qstId;//问卷题目ID
	private Long qsaId;//问卷调查的答案
	private String text;
}
