/**
 * 
 */
package com.bo;

import java.io.Serializable;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月17日上午10:00:12
 * @desc	
 */
@Getter
@Setter
public class QtSurveyRecordVo implements Serializable  {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7291127357585913868L;
	
	private Long id;
	private Long userSecondId;
	private String name;
	private Long qsId;//问卷调查
	private Long qstId;//问卷调查题目
	private Long qsaId;//问卷调查答案
	private Integer score;
	private Date createTime;
}
