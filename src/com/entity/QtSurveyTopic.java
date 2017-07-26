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
 * @date	2016年9月17日上午9:28:45
 * @desc	题目
 */
@Getter
@Setter
public class QtSurveyTopic  implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	private Long qsId;
	private String title;
	private Integer qsType;
	private Integer sort;
	private Integer type;//题目类型，单选，多选，填写
}
