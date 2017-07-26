/**
 * 
 */
package com.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月17日上午9:34:16
 * @desc	用户测试结果记录
 */
@Getter
@Setter
public class QtSurveyRecord  implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	private Long userSecondId;
	private Long qsId;//问卷调查
	private Long qstId;//问卷调查题目
	private Long qsaId;//问卷调查答案
	private Integer score;
	private Date createTime;
}
