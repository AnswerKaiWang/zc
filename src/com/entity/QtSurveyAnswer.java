/**
 * 
 */
package com.entity;

import java.io.Serializable;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月17日上午9:30:47
 * @desc 	问卷调查
 */
@Getter
@Setter
public class QtSurveyAnswer  implements Serializable  {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	private Long qsId;//问卷调查ID
	private Long  qstId;//问卷调查题目Id
	private String answer;//答案
	private Integer score;//分数
	private String prefix;
}
