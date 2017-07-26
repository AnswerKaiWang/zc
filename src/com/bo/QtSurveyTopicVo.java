/**
 * 
 */
package com.bo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.entity.QtSurveyAnswer;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月17日上午11:04:43
 * @desc	
 */
@Getter
@Setter
public class QtSurveyTopicVo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long id;
	private String title;//名称
	private Integer type;//题目类型: 0：单选；1：多选；2：填写
    private Integer sort;//题目排序为
    private Integer qsType;//题目分类：投资，收入等等
    private Long qsId;//问卷调查ID
    private List<QtSurveyAnswer> answers = new ArrayList<>();
}
