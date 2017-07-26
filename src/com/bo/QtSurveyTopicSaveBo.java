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
 * @date	2016年9月17日上午10:13:57
 * @desc	问卷调查-题目加答案
 */
@Getter
@Setter
public class QtSurveyTopicSaveBo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 494123797091735065L;
	private Long id;
	private String title;//名称
	private Integer type;//题目类型
    private Integer sort;//题目排序为
    private Long qsId;//问卷调查ID
    private Integer qsType;
    private List<QtSurveyAnswer> answers = new ArrayList<>();
}
