/**
 * 
 */
package com.bo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月3日下午2:46:20
 * @desc	题目
 */
@Getter
@Setter
public class RiskSubjectVo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer sort;
	private Integer qeId;//问题的ID
	private String subject;//问题的名称
	private List<RiskAnswerVo> answers = new ArrayList<>();
}
